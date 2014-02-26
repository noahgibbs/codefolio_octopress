require 'bundler/setup'
require 'sinatra/base'

# The project root directory
$root = ::File.dirname(__FILE__)

class SinatraStaticServer < Sinatra::Base
  # Generated from old Codefolio posts by post_redirects.rb
  REDIRECTS = [
    [1, "/posts/First-Post"],
    [2, "/posts/Developers-Are-You-Sure-That-Payment-Page-is-Secure"],
    [3, "/posts/BigCo-New-Employee-Training-Inside-Voice"],
    [4, "/posts/Your-App-Is-Written-From-Your-Point-of-View"],
    [5, "/posts/The-Five-Minute-Framework"],
    [6, "/posts/Starting-Rails-programming"],
    [7, "/posts/The-Grace-of-the-Snail"],
    [8, "/posts/VonChurch-Recruiters-are-Really-Obnoxious"],
    [9, "/posts/How-Does-Rack-Parse-Query-Params-With-parse-nested-query"],
    [10, "/posts/Juggernaut-with-New-Eyes-Nitpicks"],
    [11, "/posts/Deep-Rails-Understanding-HashWithIndifferentAccess-Understanding-the-Params-Hash"],
    [12, "/posts/Rails-Reading-Club"],
    [13, "/posts/Unsolvable-Ruby-Problems-Array-map-on-an-Array-subclass-but-keep-the-subclass"],
    [14, "/posts/What-is-Rack-A-Primer"],
    [15, "/posts/Rack-Authentication-Middleware"],
    [16, "/posts/Developer-not-Coder"],
    [17, "/posts/MiniTest-3-3-0-breaks-some-things"],
    [18, "/posts/Bring-Your-Skills-Up-A-Standard-Deviation"],
    [19, "/posts/Timing-Attacks-Are-Really-Tricky"],
    [20, "/posts/Automatic-HTTPS-JavaScript-Redirect"],
    [21, "/posts/Rebuilding-Rails-Exercises"],
    [22, "/posts/My-First-Thousand-in-Product-Revenue-Story-and-Numbers"],
    [23, "/posts/Rejected-by-GoGaRuCo-Mocking-Time-now-for-Faster-Tests"],
    [24, "/posts/Redesign-Rebuilding-Rails-com"],
    [25, "/posts/30x500-why"],
    [26, "/posts/Rejected-by-GoGaRuCo-Mocking-Time-and-Threads-Part-2"],
    [27, "/posts/The-Anti-Pants-Conspiracy-Cellular-Edition"],
    [28, "/posts/The-Pants-Conspiracy-Cellular-Edition"],
    [29, "/posts/Why-Rails-and-not-Sinatra-or-Node-js"],
    [30, "/posts/Five-Kinds-of-Marketing-for-Tiny-Web-Businesses"],
    [31, "/posts/Clean-Ruby-Code"],
    [32, "/posts/No-More-Requires"],
    [33, "/posts/Use-Rails-Until-It-Hurts-But-Not-for-APIs"],
    [34, "/posts/Rails-Is-the-Wrong-Tool-for-Your-REST-API"],
    [35, "/posts/Could-Not-Fetch-Specs-From-https-rubygems-org"],
    [36, "/posts/Building-Ruby-Castles-in-the-Clouds"],
    [37, "/posts/How-to-Create-XKCD-Style-Charts-Using-Rickshaw"],
    [38, "/posts/Free-and-Cheap-Rails-Training"],
    [39, "/posts/Order-Muppet-Programmers-Chaos-Muppet-Programmers"],
    [40, "/posts/Rack-and-Session-Store"],
    [41, "/posts/Bodybuilder-Bodhisattva"],
    [42, "/posts/I-Hope-I-Die-of-Cancer"],
    [43, "/posts/In-Praise-of-Deep-Distrust"],
    [44, "/posts/Mutual-Hero-Worship-Societies"],
    [45, "/posts/You-Need-Your-Vespene"],
    [46, "/posts/Understanding-the-Structure-of-Rails"],
    [47, "/posts/Class-Index"],
    [48, "/posts/Where-Do-I-Put-My-Code"],
    [49, "/posts/StartCom-SSL-Certificates"],
    [50, "/posts/Web-Servers-and-Application-Servers"],
    [51, "/posts/Digging-Into-the-Rails-Source"],
    [52, "/posts/The-Programmers-Secret-Weapon-for-Code-Spelunking"],
    [53, "/posts/The-Art-of-the-MetaObject-Protocol"],
    [54, "/posts/The-Ruby-Community-is-a-Loud-Bright-Wonderful-Mess"],
    [55, "/posts/On-Hiring-a-Developer"],
    [56, "/posts/Why-Ruby-Should-Stay-a-Laughing-Stock"],
    [57, "/posts/Does-Ruby-Have-a-Metaobject-Protocol"],
    [58, "/posts/What-Hooks-does-Ruby-have-for-Metaprogramming"],
    [59, "/posts/You-and-Britney-Spears-BFFs"],
    [60, "/posts/Your-Mind-is-a-Motorcycle"],
  ]

  REDIRECTS.each do |post_id, post_url|
    get(/^\/posts\/#{post_id}-/) do
      redirect to(post_url)
    end
    get(/^\/posts\/#{post_id}$/) do
      redirect to(post_url)
    end
  end

  get "/posts.atom" do
    send_sinatra_file "/atom.xml"
  end

  get(/.+/) do
    send_sinatra_file(request.path) {404}
  end

  not_found do
    send_file(File.join(File.dirname(__FILE__), 'public', '404.html'), {:status => 404})
  end

  def send_sinatra_file(path, &missing_file_block)
    file_path = File.join(File.dirname(__FILE__), 'public',  path)
    file_path = File.join(file_path, 'index.html') unless file_path =~ /\.[a-z]+$/i
    File.exist?(file_path) ? send_file(file_path) : missing_file_block.call
  end


end

run SinatraStaticServer
