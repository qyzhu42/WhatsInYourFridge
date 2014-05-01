require 'spec_helper'


describe FoodNetworkParser do

	describe "image url parser" do

		it "should return nil for page with no images" do
			url = "http://www.foodnetwork.com/recipes/waffle-iron-brownies-recipe.html"
			image_url = FoodNetworkParser.parse_image_url(url)
			expect(image_url).to eq(nil)
		end

		it "should return correct image url for recipe pages" do
			url1 = "http://www.foodnetwork.com/recipes/food-network-kitchens/waffled-leftover-thanksgiving-brunch-recipe.html"
			url2 = "http://www.foodnetwork.com/recipes/ree-drummond/meatloaf-recipe.html"
			correct_image1 = "http://foodnetwork.sndimg.com/content/dam/images/food/fullset/2013/9/28/0/FNK_Waffled-Leftover-Thanksgiving-Brunch_s4x3.jpg.rend.sni12col.landscape.jpeg"
			correct_image2 = "http://foodnetwork.sndimg.com/content/dam/images/food/fullset/2012/4/27/1/WU0213H_meatloaf_s4x3.jpg.rend.sni18col.jpeg"
			image_url1 = FoodNetworkParser.parse_image_url(url1)
			image_url2 = FoodNetworkParser.parse_image_url(url2)
			expect(image_url1).to eq(correct_image1)
			expect(image_url2).to eq(correct_image2)

		end
	end

	describe "parse menu page" do
		it "should return 150 urls" do
			url = "http://www.foodnetwork.com/recipes/a-z.W.1.html"
			result = FoodNetworkParser.parse_menu_page(url)
			expect(result.size).to eq(150)
		end

		it "should return correct urls" do
			url = "http://www.foodnetwork.com/recipes/a-z.W.1.html"
			result = FoodNetworkParser.parse_menu_page(url)
			waffle_chips = "/recipes/waffle-chips-recipe.html"
			waffle_king = "/recipes/waffle-king-recipe.html"
			warm_brown_rice_salad = "/recipes/warm-brown-rice-salad-recipe.html"
			expect(result).to include(waffle_chips)
			expect(result).to include(waffle_king)
			expect(result).to include(warm_brown_rice_salad)
		end
	end

end
