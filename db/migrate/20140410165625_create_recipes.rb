class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :ingredients
      t.string :instructions
      t.string :servings
      t.string :author
      t.string :img_url
      t.string :prep_time
      t.string :cook_time
      t.string :total_time
      t.string :url
      t.string :source

      t.timestamps
    end
  end
end
