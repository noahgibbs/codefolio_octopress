#!/usr/bin/env ruby

require "time"
require "multi_json"

posts = MultiJson.load File.read "codefolio_posts_20140201.json"

posts.each do |post|
  post_date = Time.parse post["created_at"]
  post_title = post["title"].tr("'", "").tr('^a-zA-Z0-9', '-').gsub(/-+/, "-").gsub(/^-/, "").gsub(/-$/, "")
  post_url = "/posts/#{post_title}.html"

  puts "    [#{post["id"]}, #{post_url.inspect}],"
end
