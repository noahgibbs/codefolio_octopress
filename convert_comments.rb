require 'xmlsimple'
require 'pp'
require 'time'

puts "Parsing..."
comments = XmlSimple.xml_in "all-comments.xml"

threads_to_consolidate = {}
canonical_threads = {}
import_threads = {}
comments["thread"].each do |thread|
  next unless thread["link"][0]["codefol.io/"]  # Must be from current site
  id = thread["dsq:id"]
  link = thread["link"][0]

  _, url_final = link.split "posts/", 2
  if url_final =~ /^([0-9]+)$/
    canonical_threads[$1] = id
  else
    url_final =~ /^([0-9]+)/
    threads_to_consolidate[id] = $1
  end

  import_threads[id] = {
    thread_id: id,
    title: thread["title"][0].strip,
    link: link,
    content: "",  # TODO: do we need this for some reason?
    post_date: Time.parse(thread["createdAt"][0]),
  }
end

import_comments = { "" => true }  # Don't raise on blank parent ID

comments["post"].each do |post|
  thread_id = post["thread"][0]["dsq:id"]

  if threads_to_consolidate[thread_id]
    thread_id = canonical_threads[threads_to_consolidate[thread_id]]
  end
  next unless import_threads[thread_id]

  parent_id = post["parent"] ? post["parent"][0]["dsq:id"] : ""

  import_comments[thread_id] ||= []
  import_comments[thread_id].push({
    id: post["dsq:id"],
    author: post["author"][0]["name"][0],
    author_email: post["author"][0]["email"][0],
    author_ip: post["ipAddress"][0],
    date: Time.parse(post["createdAt"][0]),
    content: post["message"][0],
    approved: "1",
    parent: parent_id,
  })
end

items_xml = ""
import_comments.each do |thread_id, comments|
  next if thread_id == ""

  thread = import_threads[thread_id]

  comments_xml = ""
  comments.each do |comment|
    comments_xml.concat <<-COMMENT
      <wp:comment>
        <wp:comment_id>#{comment[:id]}</wp:comment_id>
        <wp:comment_author>#{comment[:author]}</wp:comment_author>
        <wp:comment_author_email>#{comment[:author_email]}</wp:comment_author_email>
        <wp:comment_author_url></wp:comment_author_url>
        <wp:comment_author_IP>#{comment[:author_ip]}</wp:comment_author_IP>
        <wp:comment_date_gmt>#{comment[:date].strftime("%F %T")}</wp:comment_date_gmt>
        <wp:comment_content><![CDATA[#{comment[:content]}]]></wp:comment_content>
        <wp:comment_approved>1</wp:comment_approved>
        <!-- parent id (match up with wp:comment_id) -->
        <wp:comment_parent>#{comment[:parent] == "" ? 0 : comment[:parent]}</wp:comment_parent>
      </wp:comment>
    COMMENT
  end

  items_xml.concat <<-ITEM
    <item>
      <title>#{thread[:title]}</title>
      <link>#{thread[:link]}</link>
      <content:encoded><![CDATA[Hello world]]></content:encoded>
      <dsq:thread_identifier>#{thread[:thread_id]}</dsq:thread_identifier>
      <wp:post_date_gmt>#{thread[:post_date].strftime("%F %T")}</wp:post_date_gmt>
      <wp:comment_status>open</wp:comment_status>
#{comments_xml}
    </item>
  ITEM
end

contents = <<CONTENTS
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0"
  xmlns:content="http://purl.org/rss/1.0/modules/content/"
  xmlns:dsq="http://www.disqus.com/"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:wp="http://wordpress.org/export/1.0/"
>
  <channel>
#{items_xml}
  </channel>
</rss>
CONTENTS

puts "Writing output..."
File.open("importable-comments.xml", "w") { |f| f.write(contents) }
puts "Done!"

