class CreateUsersReleases < ActiveRecord::Migration

  def change
    create_table :users_releases do |t|
      t.integer :user_id
      t.integer :release_id
    end
  end

end
