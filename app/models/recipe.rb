class Recipe < ActiveRecord::Base
	serialize :ingredients, Array
	attr_accessible :name, :ingredients, :instructions, :servings, :author, :img_url, :prep_time, :cook_time, :total_time, :url, :source
	validates :name,  presence: true
	validates :ingredients,  presence: true
end
