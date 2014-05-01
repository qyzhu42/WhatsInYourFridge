require 'nokogiri'
require 'open-uri'
require 'timeout'
require 'restclient'
require 'hangry'

module FoodNetworkParser
	

	def self.letter_map 
			   [['123',1],['A',13],['B',37],['C',62],['D',8],['E',8],
			   ['F',18],['G',28],['H',13],['I',5],['J',4],['K',4],['L',12],
			   ['M',24],['N',5],['O',8],['P',36],['Q',3],['R',23],['S',58],
			   ['T',22],['U',1],['V',6],['W',10],['XYZ',3]]
	end

	# Parse the url of image from the recipe page
	def self.parse_image_url(page_url)
		parsed_url = RestClient.get(page_url)
      		page_html =  Nokogiri::HTML(parsed_url)
		page_s = page_html.to_s
    		img_start = page_s.index('lightbox-recipe-image')
    		if img_start != nil
    			img = page_s[img_start...page_s.length]
      			start_index = img.index('src=')
			end_of_class = img.index('</script>')
                        if start_index < end_of_class
				img = img[start_index+5...img.length]
      				end_index = img.index('jpeg')
      				img = img[0...end_index + 4]
      				return img
			end
		end
        end

	# Returns a list of urls to recipe pages from a singld menu page
	def self.parse_menu_page(url)
		f = RestClient.get(url)
		doc = Nokogiri::HTML(f)
		pages = doc.css("li[class = col18]")
		url_list = []
		pages.each do |link|
			page_url = link.css('span').css('a')[0]['href']
			url_list.push(page_url)


		end
		return url_list

	end

	# Uses Hangry and image parse to extract information of a recipe form its page and create a Recipe object
	def self.create_recipe(url)
		begin
			page_as_string = open(url).read
		rescue OpenURI::HTTPError => ex
			puts 'Page not found!'
		end

		begin
			recipe = Hangry.parse(page_as_string)
			image_url = parse_image_url(url)
			Recipe.create(name: recipe.name, url: url, source: "FoodNetwork.com", author: recipe.author, ingredients: recipe.ingredients, instructions: recipe.instructions, servings: recipe.yield, prep_time: recipe.prep_time, cook_time: recipe.cook_time, total_time: recipe.total_time, img_url: image_url)
			puts "Recipe created!"
			puts recipe.name
		rescue NoMethodError
			puts "Hangry went wrong!"
		end
	end

	# Go through all menu pages, extract urls of all 
	def self.parse_all_recipe_url
		home_url = 'http://www.foodnetwork.com'
		url_base = 'http://www.foodnetwork.com/recipes/a-z.'
		letter_map.each do |pair|
			#(1..pair[1]).each do |num|
			(1..1).each do |num|
				url = url_base + pair[0] + '.' + num.to_s + '.html'
				url_list = parse_menu_page(url)
				url_list.each do |page_url|
					complete_url = home_url + page_url
					exact_matches = Recipe.where("url LIKE ?", complete_url)
					if exact_matches.size == 0
						create_recipe(complete_url)
					else
						puts 'recipe already in database'
					end
				end
			end
		end
	end


end
