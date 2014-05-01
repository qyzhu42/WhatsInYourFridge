require 'timeout'

module SearchHelper

	def self.ignore_list
		['sugar', 'salt', 'vinegar','black pepper','butter','clove', ' paprika',
		 'cumin', 'white pepper', 'basil', 'parsley', 'paprika', 'chili powder',
		 'curry powder', 'oregano', 'ginger', 'rosemary', 'oil', 'water']
	end

=begin
	def self.could_cook(recipe,ingredients_list)
		retval = true;
		recipe.ingredients.each do |ingredient|
			if ingredients_list.any? { |s| ingredient.include?(s) }
				retval = true;
			else
				return false unless ignore_list.any? { |s| ingredient.include?(s) }
			end

		end
		return true
	end
=end

	def self.filter_by_servings(recipe_list, lower_bound, upper_bound)
		filtered_results = Array.new
    	recipe_list.each do |r|
			servings = r.first.servings.to_i
			if (servings >= lower_bound.to_i and servings <= upper_bound.to_i)	
				filtered_results.push(r)
			end
		end
		return filtered_results
	end




	def self.sort_by_time_ascend(recipe_list)
		puts "sorting"
		return recipe_list.sort_by{|r, v| StringHelper.duration_to_int(r.total_time)}
	end

	def self.sort_by_time_descend(recipe_list)
				puts "sorting"

		return recipe_list.sort_by{|r, v| - StringHelper.duration_to_int(r.total_time)}
	end

	def self.ingredients_needed(recipe,ingredients_list)
		ingredients_list.delete('')
		included = false
		ingredients_missing = recipe.ingredients.size		
		recipe.ingredients.each do |ingredient|
			if ingredients_list.any? { |s| ingredient.include?(s) }
				ingredients_missing = ingredients_missing - 1
				included = true
			else
				if ignore_list.any? { |s| ingredient.include?(s) }
					ingredients_missing = ingredients_missing - 1
				end
			end
			
		end
		if !included
			return -1
		else
			return ingredients_missing
		end
	end	

	def self.search_recipe(ingredients_list)
		#cookable = []
		partial = Hash.new(0)
		Recipe.all.each do |recipe|
			#if could_cook(recipe,ingredients_list)
				#cookable << recipe
			#else	
			missing_ingredients = ingredients_needed(recipe,ingredients_list)	
			if missing_ingredients >= 0
				partial[recipe] = missing_ingredients
			end
			#end
		end
		partial_sorted = partial.sort_by{|k,v| v}
		partial_recipe = []
		#partial_sorted.each do |entry|
			#puts entry.first.name
			#puts entry.second
			#partial_recipe << entry.first
		#end
		return partial_sorted
	end

end
