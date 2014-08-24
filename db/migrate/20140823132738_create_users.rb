class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password
      t.string :email
      t.string :activation_token
      t.integer :login_count
      t.string :failed_login_count
      t.datetime :last_login_at
      t.string :last_login_ip
      t.references :city, index: true
      t.references :country, index: true
      t.datetime :birthday
      t.string :skype
      t.string :icq
      t.string :about

      t.timestamps
    end
  end
end
