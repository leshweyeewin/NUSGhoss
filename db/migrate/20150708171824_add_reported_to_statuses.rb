class AddReportedToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :reported, :boolean, :default => false
  end
end
