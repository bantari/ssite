class CreateLogs < ActiveRecord::Migration
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
      t.column :site_id,     :integer, :default => 1
      
      t.timestamps
    end
    create_table :error_logs do |t|

      t.column :time, :datetime

      t.column :user_id,     :integer, :default => nil
      t.column :object_id,   :integer, :default => nil
      t.column :object_type, :string,  :default => nil
      t.column :object_name, :string,  :default => nil
      
      t.column :controller_name, :string, :default => nil
      t.column :action_name,     :string, :default => nil
      t.column :message,         :text

      t.column :severity,        :integer, :default => 0
      t.column :active,          :boolean, :default => true
      t.column :sent,            :boolean, :default => false
      
      t.column :app_id,      :integer, :default => nil # application id
      t.column :site_id,     :integer, :default => 1
      
      t.timestamps
    end
  end

  def self.down
    drop_table :event_logs
    drop_table :error_logs
  end
end
