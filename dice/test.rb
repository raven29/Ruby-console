require "#{File.dirname(__FILE__)}/lib.rb"
require 'test/unit'

class DiceTest < Test::Unit::TestCase

	PRECISION = 1.0e-10
	
	@@edge_data 	= [[100 , 100], [100, 600], [300, 300], [300, 1800], [100, 101]]
	@@edge_result 	= [1.to_f/6**100, 1.to_f/6**100, 1.to_f/6**300, 1.to_f/6**300, 1.to_f*100/6**100]
	@@zero_data 	= [[100, 99], [100, 601], [300, 25], [300, 2010]]
	@@two_data		= [[2, 5], [2, 6], [2, 7], [2, 8], [2, 9]]
	@@two_result 	= [1.to_f*4/6**2, 1.to_f*5/6**2, 1.to_f*6/6**2, 1.to_f*5/6**2, 1.to_f*4/6**2]
	@@sum_data		= 30

	def test_01_edge
		process(@@edge_data, @@edge_result)
	end
	
	def test_02_zero
		zero_result = get_result(@@zero_data)
		zero_result.collect{|x| assert_equal(0, x, "Fail in test_02_zero")}
	end
	
	def test_03_2
		process(@@two_data, @@two_result)
	end

	def test_04_sum
		s = (@@sum_data..(6*@@sum_data)).inject(0) do |sum, m|
			sum + DiceThrow.run(@@sum_data, m)
		end
		assert_in_delta(1, s, PRECISION, "Fail in test_04_sum")
	end


		private
	
	def get_result(fixture_data)
		fixture_data.collect{|n,m| DiceThrow.run(n,m)}
	end
	
	def process(fixture_data, fixture_result)
		actual_result = get_result(fixture_data)
		actual_result.zip(fixture_result) do |actual, expected|
			assert_in_delta(expected, actual, expected*PRECISION, "Fail in 'process' private function actual: #{actual} expected: #{expected}")
		end
	end
	
end