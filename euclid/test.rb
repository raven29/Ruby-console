require "#{File.dirname(__FILE__)}/lib.rb"
require 'test/unit'

class EuclidTest < Test::Unit::TestCase

	@@control_data 		= [[525, 231], [525, -231], [-525, 231], [-525 ,-231], [8672, -640, 26016, 38378]]
	@@control_results 	= [21, 21, 21, 21, 2]
	@@sum_data			= [[525, 231], [2008, 2010], [2008, 2009], [2012, 2014, 2016], [2012, 2014, -2016], [-2012, -2014, -2016], [23234, 3434, 43242, 354656, 4565767, -45566567, 466, -345553], [8672, -640, 26016, 38378]]

	def test_01_control_data
		@@control_data.zip(@@control_results){|x,y| process(x,y)}
	end
	
	def test_02_sum
		@@sum_data.each{|x| process_sum(x)}
	end

		private
	
	def process(nums, gcd)
		actual_result = Euclid.run(nums)
		assert_equal(gcd, actual_result[:gcd], "Fail in 'process' private function")
	end

	def process_sum(nums)
		actual_result = Euclid.run(nums)
		actual_gcd_1  = actual_result[:gcd]
		actual_coefs  = actual_result[:coefs]
		actual_gcd_2  = 0
		actual_coefs.zip(nums){|x,y| actual_gcd_2=actual_gcd_2+x.to_i*y.to_i}
		assert_equal(actual_gcd_1, actual_gcd_2, "Fail from 'process_sum'")
	end

end