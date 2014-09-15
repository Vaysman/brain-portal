class CreateCheckOnline < ActiveRecord::Migration
  def change
    create_table :check_onlines do |t|
      t.timestamp :time
    end
    add_reference :check_onlines, :user, index: true
  end
end
