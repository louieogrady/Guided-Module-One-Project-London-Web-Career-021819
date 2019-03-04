class CreateReleases < ActiveRecord::Migration

  def change
    create_table :releases do |t|
      t.string :artist
      t.string :title
      t.date :release_date
      t.string :genre
      t.string :format
    end
  end

end
