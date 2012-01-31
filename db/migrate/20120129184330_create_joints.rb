class CreateJoints < ActiveRecord::Migration

  JOINTS = [

    %w(course document),
    %w(course publication),
    %w(course reference),
    %w(course component),
    %w(course suggestion), 
    %w(course relation), 
    %w(course image),
    %w(course vdeo),
    %w(course promo),
    %w(course menu),
    %w(course banner),
    %w(course style),

    %w(product document),
    %w(product publication),
    %w(product reference),
    %w(product component),
    %w(product suggestion), 
    %w(product relation), 
    %w(product image),
    %w(product vdeo),
    %w(product promo),
    %w(product menu),
    %w(product banner),
    %w(product style),

    %w(brand suggestion), 
    %w(brand promo),
    %w(brand menu),
    %w(brand banner),
    %w(brand style),

    %w(category suggestion), 
    %w(category promo),
    %w(category menu),
    %w(category banner),
    %w(category style),

    %w(page document),
    %w(page publication),
    %w(page image),
    %w(page vdeo),
    %w(page promo),
    %w(page menu),
    %w(page banner),
    %w(page style),

    %w(survey document),
    %w(survey publication),
    %w(survey image),
    %w(survey vdeo),
    %w(survey promo),
    %w(survey menu),
    %w(survey banner),
    %w(survey style)

    ]


  def self.up
    
    JOINTS.each do |j|
      
      create_table "#{j[0]}_#{j[1].pluralize}" do |t|

        t.column "#{j[0]}_id",   :integer, :default => nil
        t.column "#{j[1]}_id",   :integer, :default => nil
        t.column :active,        :boolean, :default => true
        t.column :position,      :integer, :default => nil
        t.column :created_by,    :integer, :default => 1
        t.column :updated_by,    :integer, :default => nil
        t.timestamps
      end
      
      
    end
    
    
  end

  def self.down
    JOINTS.each do |j|
      drop_table "#{j[0]}_#{j[1].pluralize}"
    end
  end
end
