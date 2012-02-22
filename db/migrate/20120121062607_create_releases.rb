class CreateReleases < ActiveRecord::Migration
  def self.up
    create_table :releases do |t|

      t.column :time, :datetime

      t.column :user_id,      :integer, :default => nil
      t.column :object_id,    :integer, :default => nil
      t.column :object_type,  :string,  :default => nil
      
      t.column :action,       :string,  :default => nil
      t.column :description,  :text
      
      t.column :app_id,       :integer, :default => nil
      t.column :site_id,      :integer, :default => 1

      t.timestamps
    end
  end

  def self.down
  end
end
