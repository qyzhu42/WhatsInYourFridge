require 'spec_helper'

describe SearchHelper do

	describe "sort_by_time_ascend" do
		it "should sort list in correct order" do
			recipe1 = Recipe.create(name: "recipe1", total_time: "PT2H40M")
			recipe2 = Recipe.create(name: "recipe2", total_time: "PT1H40M")
			recipe3 = Recipe.create(name: "recipe3", total_time: "PT2H30M")
			input_list = [[recipe1,1],[recipe2,2],[recipe3,3]]
			result = SearchHelper.sort_by_time_ascend(input_list)
			expect(result.first[0]).to eq(recipe2)
			expect(result.last[0]).to eq(recipe1)
		end
	end

	describe "sort_by_time_descend" do
		it "should sort list in correct order" do
			recipe1 = Recipe.create(name: "recipe1", total_time: "PT2H40M")
			recipe2 = Recipe.create(name: "recipe2", total_time: "PT1H40M")
			recipe3 = Recipe.create(name: "recipe3", total_time: "PT2H30M")
			input_list = [[recipe1,1],[recipe2,2],[recipe3,3]]
			result = SearchHelper.sort_by_time_descend(input_list)
			expect(result.first[0]).to eq(recipe1)
			expect(result.last[0]).to eq(recipe2)
		end
	end

	describe "filter_by_servings" do
		it "should filter out correct recipes" do
			recipe1 = Recipe.create(name: "recipe1", servings: "6 servings")
			recipe2 = Recipe.create(name: "recipe2", servings: "5 servings")
			recipe3 = Recipe.create(name: "recipe3", servings: "2 servings")
			input_list = [[recipe1,1],[recipe2,2],[recipe3,3]]
			result = SearchHelper.filter_by_servings(input_list, 3, 5)
			expect(result.size).to eq(1)
			expect(result).to include([recipe2,2])
			result = SearchHelper.filter_by_servings(input_list, 1, 5)
			expect(result.size).to eq(2)
			expect(result).to include([recipe3,3])
		end


	end

	describe "ingredients_needed" do
		it "should return correct value" do

			recipe = Recipe.create(name: "Shrimp and Asparagus Fettuccine", ingredients: [" 1 bunch fresh asparagus, trimmed and cut into 1 inch pieces "," 1 pound uncooked shrimp - peeled, deveined, and tails removed "," 1 pound dry fettuccine pasta"])
			ingredients_list1 = ["shrimp", "pasta", "asparagus"]
			ingredients_list2 = ["shrimp", "pasta", "coke"]
			ingredients_list3 = ["shrimp", "angel hair pasta", "lettuce"]
			item_missing1 = SearchHelper.ingredients_needed(recipe,ingredients_list1)
			item_missing2 = SearchHelper.ingredients_needed(recipe,ingredients_list2)
			item_missing3 = SearchHelper.ingredients_needed(recipe,ingredients_list3)
			expect(item_missing1).to eq(0)
			expect(item_missing2).to eq(1)
			expect(item_missing3).to eq(2)		
		end


		it "should ignore ingredients in the ignore list" do

			recipe = Recipe.create(name: "Shrimp and Asparagus Fettuccine", ingredients: [" 1 bunch fresh asparagus, trimmed and cut into 1 inch pieces "," 1 pound uncooked shrimp - peeled, deveined, and tails removed "," 1 pound dry fettuccine pasta", " 2 teaspoons olive oil ", " 6 cloves garlic, pressed "])
			ingredients_list1 = ["shrimp", "pasta", "asparagus"]
			ingredients_list2 = ["shrimp", "pasta", "coke"]
			ingredients_list3 = ["shrimp", "angel hair pasta", "lettuce"]
			item_missing1 = SearchHelper.ingredients_needed(recipe,ingredients_list1)
			item_missing2 = SearchHelper.ingredients_needed(recipe,ingredients_list2)
			item_missing3 = SearchHelper.ingredients_needed(recipe,ingredients_list3)
			expect(item_missing1).to eq(0)
			expect(item_missing2).to eq(1)
			expect(item_missing3).to eq(2)	
		end

		it "should return -1 when the recipe contains nothing from ingredients list" do

			recipe = Recipe.create(name: "Shrimp and Asparagus Fettuccine", ingredients: [" 1 bunch fresh asparagus, trimmed and cut into 1 inch pieces "," 1 pound uncooked shrimp - peeled, deveined, and tails removed "," 1 pound dry fettuccine pasta", " 2 teaspoons olive oil ", " 6 cloves garlic, pressed "])
			ingredients_list1 = ["catfish", "chicken breast", "lettuce"]
			item_missing1 = SearchHelper.ingredients_needed(recipe,ingredients_list1)
			expect(item_missing1).to eq(-1)

		end

		it "should ignore empty string in ingredients list" do

			recipe = Recipe.create(name: "Shrimp and Asparagus Fettuccine", ingredients: [" 1 bunch fresh asparagus, trimmed and cut into 1 inch pieces "," 1 pound uncooked shrimp - peeled, deveined, and tails removed "," 1 pound dry fettuccine pasta", " 2 teaspoons olive oil ", " 6 cloves garlic, pressed "])
			ingredients_list3 = ["shrimp", "angel hair pasta", "lettuce", '']
			item_missing3 = SearchHelper.ingredients_needed(recipe,ingredients_list3)
			expect(item_missing3).to eq(2)	

		end

	end



end
