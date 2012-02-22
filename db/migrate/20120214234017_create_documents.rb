class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      
      t.column :history, :text
      
      #------------------------------------------------------------ publishable data
      
      t.column :code,             :string,  :default => nil
      t.column :name,             :string,  :default => nil
      t.column :title,            :string,  :default => nil
      t.column :description,      :string,  :default => nil
      
      t.column :file_name,        :string,  :default => nil
      t.column :file_url,         :string,  :default => nil

      # html content
      t.column :abstract,         :text
      t.column :content,          :text

      # css content
      t.column :style_id,         :integer, :default => nil
      t.column :style_css,        :text

      # meta fields
      t.column :m_title,          :string,  :default => nil
      t.column :m_keywords,       :text
      t.column :m_description,    :text

      # search fields
      t.column :s_title,          :string,  :default => nil
      t.column :s_keywords,       :text
      t.column :s_description,    :text
      
      # auto fields
      t.column :a_title,          :string,  :default => nil
      t.column :a_keywords,       :text
      t.column :a_description,    :text

      #------------------------------------------------------------ published data

      t.column :p_code,           :string,  :default => nil
      t.column :p_name,           :string,  :default => nil
      t.column :p_title,          :string,  :default => nil
      t.column :p_description,    :string,  :default => nil
      
      t.column :p_file_url,       :string,  :default => nil
 
      # html content
      t.column :p_abstract,       :text
      t.column :p_content,        :text

      # css content
      t.column :p_style_id,       :integer, :default => nil
      t.column :p_style_css,      :text

      # meta fields
      t.column :p_m_title,        :string,  :default => nil
      t.column :p_m_keywords,     :text
      t.column :p_m_description,  :text

      # search fields
      t.column :p_s_title,        :string,  :default => nil
      t.column :p_s_keywords,     :text
      t.column :p_s_description,  :text

      # auto fields
      t.column :p_a_title,        :string,  :default => nil
      t.column :p_a_keywords,     :text
      t.column :p_a_description,  :text

      #------------------------------------------------------------ live data

      # status flags
      t.column :active,           :boolean, :default => true
      t.column :adjusted,         :boolean, :default => false
      t.column :published,        :boolean, :default => false

      # document-specific
      t.column :document_type_id, :integer, :default => nil

      # live bindings
      t.column :site_id,          :integer, :default => 1
      t.column :replacement_id,   :integer, :default => nil
      
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
    
    
    create_table :document_types do |t|

      t.column :code,             :string,  :default => nil
      t.column :name,             :string,  :default => nil
      t.column :title,            :string,  :default => nil
      t.column :description,      :string,  :default => nil
      
      t.column :file_path,        :string,  :default => nil

      # timeline events
      t.column :created_by,       :integer, :default => 1
      t.column :updated_by,       :integer, :default => nil
      t.timestamps
    end
    
    
  end

  def self.down
    drop_table :documents
    drop_table :document_types
  end
end
