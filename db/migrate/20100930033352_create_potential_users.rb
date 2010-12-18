class CreatePotentialUsers < ActiveRecord::Migration
  def self.up
    create_table :potential_users do |t|
      t.string :email
      t.string :type
      t.timestamps
    end
  end

  def self.down
    drop_table :potential_users
  end
end
