class CreateSkus < ActiveRecord::Migration
  def self.up
    create_table :skus do |t|
      
      t.column :history, :text
      
      #------------------------------------------------------------ publishable data
      
      t.column :code,             :string,  :default => nil
      t.column :price,            :integer, :default => nil

      #--- for course
      t.column :location,         :string,  :default => nil
      t.column :start_date,       :datetime
      t.column :end_date,         :datetime
      t.column :capacity,         :integer, :default => 12

      #--- for product
      t.column :size,             :string,  :default => nil
      t.column :package,          :string,  :default => nil
      t.column :position,         :integer, :default => 0
            
      #------------------------------------------------------------ published data

      t.column :p_code,           :string,  :default => nil
      t.column :p_price,          :integer, :default => nil

      #--- for course
      t.column :p_location,       :string,  :default => nil
      t.column :p_start_date,     :datetime
      t.column :p_end_date,       :datetime
      t.column :p_capacity,       :integer, :default => 12

      #--- for product
      t.column :p_size,           :string,  :default => nil
      t.column :p_package,        :string,  :default => nil
      t.column :p_position,       :integer, :default => 0
      
      #------------------------------------------------------------ live data

      # sku flags
      t.column :sr_only,          :boolean, :default => true # can only be visible/purchasable to stg SR

      # status flags
      t.column :active,           :boolean, :default => true
      t.column :adjusted,         :boolean, :default => false
      t.column :published,        :boolean, :default => false

      #--- currently enrolled
      t.column :enrolled,         :integer, :default => 0

      # bindings
      t.column :course_id,        :integer, :default => nil
      t.column :product_id,       :integer, :default => nil
      
      # timeline events
      t.column :introduced_at,    :datetime
      t.column :introduced_by,    :integer, :default => 1
      t.column :disabled_at,      :datetime
      t.column :disabled_by,      :integer, :default => 1
      t.column :released_at,      :datetime
      t.column :released_by,      :integer, :default => 1
      t.column :created_by,       :integer, :default => 1
      t.column :updated_by,       :integer, :default => nil
      t.timestamps
    end
  end

  def self.down
    drop_table :skus
  end
end
