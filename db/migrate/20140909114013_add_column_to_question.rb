class AddColumnToQuestion < ActiveRecord::Migration
  def change
  	add_reference :questions, :category, index: true
  end
end
