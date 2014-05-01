require 'nokogiri'
require 'open-uri'
require 'timeout'
require 'restclient'
require 'hangry'

module AllRecipesParser

	def self.parse_image_url(doc)

		return doc.css("div[id = divHeroPhotoContainer]").css("img[id=imgPhoto]")[0]["src"]
	end

	def self.parse_menu_page(url)
		f= RestClient.get(url)
		doc = Nokogiri::HTML(f)
		grids = doc.css("div[id = divGridItemWrapper]")
		url_list = []
		grids.each do |link|
			page_url = link.css("a[class = img-link]")[0]["href"]
			url_list.push(page_url)
		end
		return url_list


	end

	def self.parse_prep_time(doc)
		return doc.css("time[id = timePrep]")[0]["datetime"]
	end
	
	def self.parse_cook_time(doc)
		return doc.css("time[id = timeCook]")[0]["datetime"]
	end

	def self.parse_total_time(doc)
		return doc.css("time[id = timeTotal]")[0]["datetime"]
	end



	def self.create_recipe(url)
		begin
			page_as_string = open(url).read
		rescue OpenURI::HTTPError => ex
			puts 'Page not found!'
		end

		begin
			recipe = Hangry.parse(page_as_string)
			f= RestClient.get(url)
			doc = Nokogiri::HTML(f)
			prep_time = parse_prep_time(doc)
			cook_time = parse_cook_time(doc)
			total_time = parse_total_time(doc)
			image_url = parse_image_url(doc)
			Recipe.create(name: recipe.name, author: recipe.author, url: url, source: "AllRecipes.com",ingredients: recipe.ingredients, instructions: recipe.instructions, servings: recipe.yield, prep_time: prep_time, cook_time: cook_time, total_time: total_time, img_url: image_url)
			puts "Recipe created!"
			puts recipe.name
		rescue NoMethodError => ex
			puts "Hangry went wrong!"
		end
	end

	def self.parse_all_recipes
		num_of_page = 100
		(1..100).each do |num|
			url = 'http://allrecipes.com/recipes/main.aspx?Page=' + num.to_s + '#recipes'
			url_list = parse_menu_page(url)
			url_list.each do |recipe_url|
				recipe_url = 'http://allrecipes.com' + recipe_url
				exact_matches = Recipe.where("url LIKE ?", recipe_url)
				if exact_matches.size == 0
					create_recipe(recipe_url)
				else
					puts 'recipe already in database'
				end
			end
	
		end

	end







end
