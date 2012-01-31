class CategoriesBrands < ActiveRecord::Migration
  def self.up

    create_table :brands do |t|

      t.column :history, :text
      
      t.column :code,             :string,  :default => nil
      t.column :name,             :string,  :default => nil
      t.column :title,            :string,  :default => nil
      t.column :description,      :string,  :default => nil
      
      t.column :parent_id,        :integer, :default => nil
      t.column :trace,            :string,  :default => nil
      t.column :full,             :string,  :default => nil

      t.column :site_id,          :integer, :default => nil

      t.timestamps
    end

    create_table :categories do |t|

      t.column :history, :text
      
      t.column :code,             :string,  :default => nil
      t.column :name,             :string,  :default => nil
      t.column :title,            :string,  :default => nil
      t.column :description,      :string,  :default => nil
      
      t.column :parent_id,        :integer, :default => nil
      t.column :trace,            :string,  :default => nil
      t.column :full,             :string,  :default => nil
      
      t.column :site_id,          :integer, :default => nil

      t.timestamps
    end

  end

  def self.down
  end
end
