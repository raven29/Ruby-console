require "#{File.dirname(__FILE__)}/lib.rb"

if $*.length != 2  # case of incorrect format

	puts <<eof
 wrong format! 
 correct form is:

 > ruby #{$0} N M
	
 where: 
  N - number of dice
  M - value
eof

else
	strN = $*[0]
	strM = $*[1]
	regnum = /^\d+$/
	
	if strN !~ regnum or strM !~ regnum # case of incorrect data
		puts <<eof
 incorrect data! 
 correct usage:

 > ruby #{$0} N M
	
 where N and M are both INTEGER POSITIVE
eof
		exit!
	end
	
	N = strN.to_i
	M = strM.to_i

	#ts = Time.now.to_f	
	p DiceThrow.run(N, M)	
	#p Time.now.to_f - ts
end

