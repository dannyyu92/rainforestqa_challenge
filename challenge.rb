#!/usr/bin/env ruby
require "net/http"
require "json"

url = 'http://letsrevolutionizetesting.com/challenge'
while url
  uri = URI(url)
  request = Net::HTTP::Get.new(uri)
  request['ACCEPT'] = 'application/json'
  response = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(request)
  end

  error_msg = "Some error happened"
  if response.code == "200"
    json = JSON.parse(response.body)
    if json["follow"]
      url = json["follow"]
      puts "Following url: #{url}"
    elsif json["message"]
      url = nil
      puts json["message"]
    else
     raise error_msg
    end
  else
    raise error_msg
  end
end