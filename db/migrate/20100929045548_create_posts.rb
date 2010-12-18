class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :external_id
      t.string :href
      t.string :email
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
