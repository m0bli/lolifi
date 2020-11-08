require 'colorize'
require 'net/http'
require 'net/dns'

banner = "
        :::       :::::::: :::       :::::::::::::::::::::::::::::::: 
       :+:      :+:    :+::+:           :+:    :+:           :+:      
      +:+      +:+    +:++:+           +:+    +:+           +:+       
     +#+      +#+    +:++#+           +#+    :#::+::#      +#+        
    +#+      +#+    +#++#+           +#+    +#+           +#+         
   #+#      #+#    #+##+#           #+#    #+#           #+#          
  ################## ########################       ########### 
"
print banner.bold.blue

class String
def red;            "\e[31m#{self}\e[0m" end
def green;          "\e[32m#{self}\e[0m" end
def blue;           "\e[34m#{self}\e[0m" end
def bold;           "\e[1m#{self}\e[22m" end
def underline;      "\e[4m#{self}\e[24m" end
end

puts " " 

print " TARGET: ".yellow
ipurl = gets.chomp

#puts "\t\tTARGET".bold.blue

puts "\n "
packet = Net::DNS::Resolver.start(ipurl)   
answer = packet.answer
answer.any? {|ans| p   ans}
puts "\n "


puts " "
    File.open("list.txt").readlines.each do |line|       
    req = "http://"+ipurl+'/'+line.chomp+'/'
    res = Net::HTTP.get_response(URI.parse(req.strip))    
  if res.code == "200"
     puts "#{req} ==> #{res.code}".red.bold
  elsif res.code == "301" or  res.code == "302"
     puts "#{req} ==> #{res.code}".red.bold.underline   
  else
     puts "#{req} ==> #{res.code}".green.bold
  end
end
