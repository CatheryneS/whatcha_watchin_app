class AddUser < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :name
      u.string :username
      u.string :email
      u.string :password_digest
    end
  end
end
