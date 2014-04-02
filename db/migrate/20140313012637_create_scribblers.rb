class CreateScribblers < ActiveRecord::Migration
  def change
    create_table :scribbler_containers, :force => true do |t|
      t.string      :name
      t.string      :description
      t.boolean     :scaleable, :default => false
      t.integer     :element_id
      t.timestamps
    end
    
    create_table :scribbler_groups, :force => true do |t|
      t.string  :name
      t.integer :container_id
      t.timestamps
    end
    
    create_table :scribbler_texts, :force => true do |t|
      t.string  :name
      t.integer :group_id
      t.text    :content
      t.boolean :plain
      t.boolean :released, :default => false
      t.timestamps
    end
    
    create_table :scribbler_links, :force => true do |t|
      t.string :name
      t.text :url
      t.string :title, :title => "Link"
      t.boolean :released, :default => false
      t.integer :group_id
      t.boolean :external, :default => false

      t.timestamps
    end
    
    create_table :scribbler_images, :force => true do |t|
      t.string :name
      t.string :group_id
      t.boolean :released, :default => false
      t.string :copyright
      t.string :alt_text
      t.string :opt_size, :default => "128x128"
      t.attachment :image
      t.timestamps
    end
  end
end