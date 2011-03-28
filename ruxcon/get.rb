require 'pp'

require "net/http"
require "uri"

url = URI.parse("http://www.ruxcon.org.au/")
url = URI.parse("http://127.0.0.1/")

headers = {'Cookie' => "lol=pqlsdwq"} 
resp = Net::HTTP.start(url.host, url.port) do |http|
  http.get(url.request_uri,headers)
end

puts resp.code
puts resp.header['Server']
puts resp.body

