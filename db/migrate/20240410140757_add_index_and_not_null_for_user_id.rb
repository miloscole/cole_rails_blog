class AddIndexAndNotNullForUserId < ActiveRecord::Migration[7.1]
  def change
    change_column_null :articles, :user_id, false
    add_index :articles, :user_id
  end
end
