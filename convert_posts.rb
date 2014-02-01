#!/usr/bin/env ruby

require "time"

require "multi_json"

posts = MultiJson.load File.read "codefolio_posts_20140201.json"
taggings = MultiJson.load File.read "codefolio_taggings_20140201.json"

# Delete old posts - so only run this on initial import :-)
puts "Deleting old posts... Don't worry if you see a 'No such file or directory' error!"
`rm source/_posts/*`

posts.each do |post|
  tags = taggings.select { |t| t["post_id"] == post["id"] }
  categories = tags.map { |t| t["tag"] }.select {|t| t != "," }.join ","
  categories = "[#{categories}]" unless categories == ""

  post_date = Time.parse post["created_at"]
  post_title = post["title"].tr("'", "").tr('^a-zA-Z0-9', '-').gsub(/-+/, "-").gsub(/^-/, "").gsub(/-$/, "")
  post_filename = "#{post_date.strftime("%Y-%m-%d")}-#{post_title}.markdown"
  post_contents = <<-CONTENTS
---
layout: post
title: #{post["title"].inspect}
date: #{post_date.strftime("%Y-%m-%d %H:%M")}
comments: true
published: #{post["published"] ? "true" : "false"}
categories: #{categories}
---
#{post["body"]}
  CONTENTS

  File.open("source/_posts/#{post_filename}", "a") { |f| f.write post_contents }
end

puts "Done!"
