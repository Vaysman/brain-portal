class RenameTableMessages < ActiveRecord::Migration
  def change
  	rename_table :messages, :chat_messages
  end
end
