class AddUserToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :user, :string
    Post.update_all({:user => "lister"}, {:user => nil})
  end

  def self.down
    remove_column :posts, :user
  end
end
