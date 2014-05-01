require 'spec_helper'


describe AllRecipesParser do

	describe "image url parser" do


		it "should return correct image url for recipe pages" do
			url = "http://allrecipes.com/Recipe/Jays-Signature-Pizza-Crust/Detail.aspx?evt19=1"
			correct_image = "http://images.media-allrecipes.com/userphotos/250x250/00/23/78/237891.jpg"
			f= RestClient.get(url)
			doc = Nokogiri::HTML(f)
			image_url1 = AllRecipesParser.parse_image_url(doc)
			expect(image_url1).to eq(correct_image)

		end
	end

	describe "prep time parser" do


		it "should return correct time" do
			url = "http://allrecipes.com/Recipe/Jays-Signature-Pizza-Crust/Detail.aspx?evt19=1"
			correct_result = "30 mins"
			f= RestClient.get(url)
			doc = Nokogiri::HTML(f)
			result = AllRecipesParser.parse_prep_time(doc)
			expect(result).to eq(correct_result)

		end
	end

	describe "cook time parser" do


		it "should return correct time" do
			url = "http://allrecipes.com/Recipe/Jays-Signature-Pizza-Crust/Detail.aspx?evt19=1"
			correct_result = "20 mins"
			f= RestClient.get(url)
			doc = Nokogiri::HTML(f)
			result = AllRecipesParser.parse_cook_time(doc)
			expect(result).to eq(correct_result)

		end
	end
	describe "total time parser" do


		it "should return correct time" do
			url = "http://allrecipes.com/Recipe/Jays-Signature-Pizza-Crust/Detail.aspx?evt19=1"
			correct_result = "50 mins"
			f= RestClient.get(url)
			doc = Nokogiri::HTML(f)
			result = AllRecipesParser.parse_total_time(doc)
			expect(result).to eq(correct_result)

		end
	end




	describe "parse menu page" do
		it "should return 20 urls" do
			url = "http://allrecipes.com/recipes/main.aspx?Page=3#recipes"
			result = AllRecipesParser.parse_menu_page(url)
			expect(result.size).to eq(20)
		end

		it "should return correct urls" do
			url = "http://allrecipes.com/recipes/main.aspx?Page=3#recipes"
			result = AllRecipesParser.parse_menu_page(url)
			buffalo_chicken_dip = "/Recipe/Buffalo-Chicken-Dip/Detail.aspx?evt19=1"
			rice_pudding = "/Recipe/Creamy-Rice-Pudding/Detail.aspx?evt19=1"
			grilled_salmon = "/Recipe/Grilled-Salmon-I/Detail.aspx?evt19=1"
			expect(result).to include(buffalo_chicken_dip)
			expect(result).to include(rice_pudding)
			expect(result).to include(grilled_salmon)
		end
	end

end
