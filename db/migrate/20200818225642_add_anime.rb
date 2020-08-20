class AddAnime < ActiveRecord::Migration
  def change
    create_table :animes do |a|
      a.string :title
      a.string :status
      a.string :rating
      a.integer :user_id
    end
  end
end
