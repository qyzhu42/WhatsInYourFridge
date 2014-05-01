include SearchHelper
include StringHelper
require 'will_paginate/array'

class RecipeController < ApplicationController

  def search
	@results = SearchHelper.search_recipe(StringHelper.make_query_list(params[:ingredients]))
	if (params[:method] == '1')
		@results = SearchHelper.sort_by_time_ascend(@results)
	end
	if (params[:method] == '2')
		@results = SearchHelper.sort_by_time_descend(@results)
	end
	@results = SearchHelper.filter_by_servings(@results, params[:low], params[:high])
    @results = @results.paginate(page: params[:page], per_page: 20)

  end

  def show

  	@recipe = Recipe.find(params[:id])
  end
end
