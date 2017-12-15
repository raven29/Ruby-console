require "#{File.dirname(__FILE__)}/lib.rb"

if $*.length < 2  # case of incorrect format

	puts <<eof
 wrong format! 
 correct form is:

 > ruby #{$0} N1 N2 ...
	
 with more than 1 parameter
 
eof

else
	regnum = /^-?\d+$/
	
	($*).each do |x| 
		if x !~ regnum or x !~ regnum # case of incorrect data
		puts <<eof
 incorrect data! 
 correct usage:

 > ruby #{$0} N1 N2 ...
	
 with 2 or more INTEGER numbers
eof
		exit!
		end
	end

	numbers = $*.clone
	result = Euclid.run(numbers)
	s0 = "%i = " % result[:gcd]
	coefs = result[:coefs]
	terms = []
	$*.zip(coefs){|x,y| terms<<y.to_s+'*'+x}
	s = terms.inject(''){|s,t| s+' + '+t}
	s.slice!(0..2)
	puts s0 + s
end

