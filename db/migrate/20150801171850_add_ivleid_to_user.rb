class AddIvleidToUser < ActiveRecord::Migration
  def change
    add_column :users, :ivle_id, :string
  end
end
