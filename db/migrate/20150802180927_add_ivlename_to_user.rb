class AddIvlenameToUser < ActiveRecord::Migration
  def change
    add_column :users, :ivle_name, :string
  end
end
