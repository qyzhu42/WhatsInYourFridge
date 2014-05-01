require 'spec_helper'

describe StringHelper do

	describe "duration_to_int" do
		it "should return correct value" do
			str1 = "PT3H4M"
			result = StringHelper.duration_to_int(str1)
			expect(result).to eq(184)
			str2 = "PT4M"
			result = StringHelper.duration_to_int(str2)
			expect(result).to eq(4)
			str3 = "PT1D"
			result = StringHelper.duration_to_int(str3)
			expect(result).to eq(1440)
			str4 = "PT1D24M"
			result = StringHelper.duration_to_int(str4)
			expect(result).to eq(1464)
			str5 = "PT1D2H24M"
			result = StringHelper.duration_to_int(str5)
			expect(result).to eq(1584)

		end
	end

	describe "duration_to_string" do
		it "should return correct string" do
			str1 = "PT3H4M"
			result = StringHelper.duration_to_string(str1)
			expect(result).to eq("3 Hours 4 Minutes")
			str2 = "PT4M"
			result = StringHelper.duration_to_string(str2)
			expect(result).to eq("4 Minutes")
			str3 = "PT1D"
			result = StringHelper.duration_to_string(str3)
			expect(result).to eq("1 Day ")
			str4 = "PT1D24M"
			result = StringHelper.duration_to_string(str4)
			expect(result).to eq("1 Day 24 Minutes")
			str5 = "PT1D2H24M"
			result = StringHelper.duration_to_string(str5)
			expect(result).to eq("1 Day 2 Hours 24 Minutes")
		end

		it "should ignore invalid input" do
			str1 = "3H4M"
			result = StringHelper.duration_to_string(str1)
			expect(result).to eq(nil)
		end

		it "should handle both Day and D" do
			str1 = "1D3H4M"
			str2 = "1Day3H4M"
			result1 = StringHelper.duration_to_string(str1)
			result2 = StringHelper.duration_to_string(str2)
			expect(result1).to eq(result2)
		end

	end
end 