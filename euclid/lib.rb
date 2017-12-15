class Euclid

	def self.run(numbers)
		nums = numbers.clone
		gcd(nums)
	end

	def self.gcd(nums, coefs=[1])
		a = nums[0]
		b = nums[1]
		return {:gcd=>a, :coefs=>coefs} if b.nil?
		result  = self.gcd2(a, b)
		coefs   = prod(result[:coefs][0], coefs) << result[:coefs][1]
		nums.shift
		nums[0] = result[:gcd]
		gcd(nums, coefs)
	end
	
	def self.gcd2(a, b)
		a = a.to_i
		b = b.to_i
		cprev = [1, 0]
		cnext = [0, 1]
	    while !b.eql? 0
			cnext, cprev = minus(cprev, prod(a/b, cnext)), cnext
	        a, b = b, a % b
	    end
		(0..1).each{|i| cprev[i]=-cprev[i]} if a<0
	    {:gcd=>a.abs, :coefs=>cprev}
	end
		
	def self.prod(c, array)
		array.collect{|x| x*c}
	end

	def self.minus(array1, array2)
		a = []
		array1.zip(array2){|x, y| a<<(x-y)}
		a
	end
	
end
