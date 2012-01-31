class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable
      
      t.column :code,         :string,  :default => nil
      t.column :name,         :string,  :default => nil
      t.column :title,        :string,  :default => nil
      t.column :description,  :string,  :default => nil
      
      #--- special roles
      t.column :admin,        :boolean, :default => false
      t.column :developer,    :boolean, :default => false

      #--- action roles
      t.column :creator,      :boolean, :default => false
      t.column :editor,       :boolean, :default => false
      t.column :destroyer,    :boolean, :default => false
      t.column :releaser,     :boolean, :default => false

      #--- access roles
      t.column :documents,    :boolean, :default => false
      t.column :inventory,    :boolean, :default => false
      t.column :website,      :boolean, :default => false
      t.column :web_glossary, :boolean, :default => false
      t.column :web_social,   :boolean, :default => false
      t.column :web_faq,      :boolean, :default => false
      t.column :media,        :boolean, :default => false

      #--- additional access roles
      t.column :special,      :boolean, :default => false
      t.column :system,       :boolean, :default => false
      t.column :live,         :boolean, :default => false

      #--- object flags
      t.column :active,       :boolean, :default => true
      t.column :editable,     :boolean, :default => true

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true

  end

  def self.down
    drop_table :users
    drop_table :roles
    drop_table :permissions
  end
end
