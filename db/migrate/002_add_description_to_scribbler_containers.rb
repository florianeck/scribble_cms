class AddDescriptionToScribblerContainers < ActiveRecord::Migration
  def change
    add_column :scribbler_containers, :description, :text unless column_exists?(:scribbler_containers, :description)
  end
end