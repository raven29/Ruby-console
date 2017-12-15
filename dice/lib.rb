=begin
Let 
N  - number of dice
M  - value
xi - number of die revealing i points (i=[1,2,3,4,5,6])
So we need to find all non-negative integer solutions of the system of two equations:
(1) 1*x1 + 2*x2 + 3*x3 + 4*x4 + 5*x5 + 6*x6 = M
(2) x1 + x2 + x3 + x4 + x5 + x6 = N
or:
(1) x2 = M - N - 2*x3 - 3*x4 - 4*x5 - 5*x6
(2) x1 = N - x2 - x3 - x4 - x5 - x6
Each of these has probability (1/6)^N and can be realized by N!/(x1!*x2!*...*x6!) combinations.
We use logarithms in order to avoid overflow of big float and to increase productivity.
=end

class DiceThrow

	def self.run(n, m)

		logfact = Array.new
		logfact[0] = 0.to_f
		n.times do |i| 
			logfact[i+1] = logfact[i]+Math.log(i+1)
		end
			
		#mn = m - n
		nlog6  	= Math.log(6)*n
		probability = 0
		if 6*n>m
			n6max = m/6
			(n6max+1).times do |x6|
				n5 = n - x6
				m5 = m - 6*x6
				next if 5*n5<m5
				if 5*n5==m5
					add = logfact[n]-logfact[n5]-logfact[x6]-nlog6
					probability += Math.exp(add)
					next
				end
				n5max = m5/5
				(n5max+1).times do |x5|
					n4 = n5 - x5
					m4 = m5 - 5*x5
					next if 4*n4<m4
					if 4*n4==m4
						add = logfact[n]-logfact[n4]-logfact[x5]-logfact[x6]-nlog6
						probability += Math.exp(add)
						next
					end
					n4max = m4/4
					(n4max+1).times do |x4|
						n3 = n4 - x4
						m3 = m4 - 4*x4
						next if 3*n3<m3
						if 3*n3==m3
							add = logfact[n]-logfact[n3]-logfact[x4]-logfact[x5]-logfact[x6]-nlog6
							probability += Math.exp(add)
							next
						end
						n3min = m3-2*n3
						n3min = 0 if n3min<0
						n3max = (m3-n3)/2
						break if n3min>n3max
						n3min.upto(n3max) do |x3|
							x2 = m3 - n3 - 2*x3
							x1 = n3 - x2 - x3
							add = logfact[n]-logfact[x1]-logfact[x2]-logfact[x3]-logfact[x4]-logfact[x5]-logfact[x6]-nlog6
							#output all info of combination - useful when debug:
							#p "[x1 = %i, x2 = %i, x3 = %i, x4 = %i, x5 = %i, x6 = %i] - %i combinations" % [x1, x2, x3, x4, x5, x6, Math.exp(add+nlog6).to_i]
							probability += Math.exp(add)
						end
					end
				end
			end
		elsif 6*n==m
			probability = Math.exp(-nlog6)
		end

		return probability

	end

end
