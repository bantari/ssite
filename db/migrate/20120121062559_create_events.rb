class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :event_logs do |t|

      t.column :time, :datetime

      t.column :user_id,     :integer, :default => nil
      t.column :object_id,   :integer, :default => nil
      t.column :object_type, :string,  :default => nil
      t.column :object_name, :string,  :default => nil
      
      t.column :action,      :string,  :default => nil
      t.column :result,      :text
      t.column :comment,     :text
      
      t.column :app_id,      :integer, :default => nil # application id
      t.column :site_id,     :integer, :default => nil
      
      t.timestamps
    end
  end

  def self.down
    drop_table :event_logs
  end
end
