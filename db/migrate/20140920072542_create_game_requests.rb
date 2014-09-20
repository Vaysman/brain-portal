class CreateGameRequests < ActiveRecord::Migration
  def change
    create_table :game_requests do |t|
      t.references :category, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
