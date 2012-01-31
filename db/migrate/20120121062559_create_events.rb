class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :action_events do |t|

      t.column :time, :datetime

      t.column :user_id,     :integer, :default => nil
      t.column :object_id,   :integer, :default => nil
      t.column :object_type, :string,  :default => nil
      
      t.column :action,      :string,  :default => nil
      t.column :description, :text
      
      t.timestamps
    end
  end

  def self.down
    drop_table :action_events
  end
end
