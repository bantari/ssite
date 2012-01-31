# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120129184330) do

  create_table "action_events", :force => true do |t|
    t.datetime "time"
    t.integer  "user_id"
    t.integer  "object_id"
    t.string   "object_type"
    t.string   "action"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brand_banners", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "banner_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brand_menus", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "menu_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brand_promos", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "promo_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brand_styles", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "style_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brand_suggestions", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "suggestion_id"
    t.boolean  "active",        :default => true
    t.integer  "position"
    t.integer  "created_by",    :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brands", :force => true do |t|
    t.text     "history"
    t.string   "code"
    t.string   "name"
    t.string   "title"
    t.string   "description"
    t.integer  "parent_id"
    t.string   "trace"
    t.string   "full"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.text     "history"
    t.string   "code"
    t.string   "name"
    t.string   "title"
    t.string   "description"
    t.integer  "parent_id"
    t.string   "trace"
    t.string   "full"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_banners", :force => true do |t|
    t.integer  "category_id"
    t.integer  "banner_id"
    t.boolean  "active",      :default => true
    t.integer  "position"
    t.integer  "created_by",  :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_menus", :force => true do |t|
    t.integer  "category_id"
    t.integer  "menu_id"
    t.boolean  "active",      :default => true
    t.integer  "position"
    t.integer  "created_by",  :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_promos", :force => true do |t|
    t.integer  "category_id"
    t.integer  "promo_id"
    t.boolean  "active",      :default => true
    t.integer  "position"
    t.integer  "created_by",  :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_styles", :force => true do |t|
    t.integer  "category_id"
    t.integer  "style_id"
    t.boolean  "active",      :default => true
    t.integer  "position"
    t.integer  "created_by",  :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_suggestions", :force => true do |t|
    t.integer  "category_id"
    t.integer  "suggestion_id"
    t.boolean  "active",        :default => true
    t.integer  "position"
    t.integer  "created_by",    :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_banners", :force => true do |t|
    t.integer  "course_id"
    t.integer  "banner_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_components", :force => true do |t|
    t.integer  "course_id"
    t.integer  "component_id"
    t.boolean  "active",       :default => true
    t.integer  "position"
    t.integer  "created_by",   :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_documents", :force => true do |t|
    t.integer  "course_id"
    t.integer  "document_id"
    t.boolean  "active",      :default => true
    t.integer  "position"
    t.integer  "created_by",  :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_images", :force => true do |t|
    t.integer  "course_id"
    t.integer  "image_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_menus", :force => true do |t|
    t.integer  "course_id"
    t.integer  "menu_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_promos", :force => true do |t|
    t.integer  "course_id"
    t.integer  "promo_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_publications", :force => true do |t|
    t.integer  "course_id"
    t.integer  "publication_id"
    t.boolean  "active",         :default => true
    t.integer  "position"
    t.integer  "created_by",     :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_references", :force => true do |t|
    t.integer  "course_id"
    t.integer  "reference_id"
    t.boolean  "active",       :default => true
    t.integer  "position"
    t.integer  "created_by",   :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_relations", :force => true do |t|
    t.integer  "course_id"
    t.integer  "relation_id"
    t.boolean  "active",      :default => true
    t.integer  "position"
    t.integer  "created_by",  :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_styles", :force => true do |t|
    t.integer  "course_id"
    t.integer  "style_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_suggestions", :force => true do |t|
    t.integer  "course_id"
    t.integer  "suggestion_id"
    t.boolean  "active",        :default => true
    t.integer  "position"
    t.integer  "created_by",    :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_vdeos", :force => true do |t|
    t.integer  "course_id"
    t.integer  "vdeo_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_banners", :force => true do |t|
    t.integer  "page_id"
    t.integer  "banner_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_documents", :force => true do |t|
    t.integer  "page_id"
    t.integer  "document_id"
    t.boolean  "active",      :default => true
    t.integer  "position"
    t.integer  "created_by",  :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_images", :force => true do |t|
    t.integer  "page_id"
    t.integer  "image_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_menus", :force => true do |t|
    t.integer  "page_id"
    t.integer  "menu_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_promos", :force => true do |t|
    t.integer  "page_id"
    t.integer  "promo_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_publications", :force => true do |t|
    t.integer  "page_id"
    t.integer  "publication_id"
    t.boolean  "active",         :default => true
    t.integer  "position"
    t.integer  "created_by",     :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_styles", :force => true do |t|
    t.integer  "page_id"
    t.integer  "style_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_vdeos", :force => true do |t|
    t.integer  "page_id"
    t.integer  "vdeo_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_banners", :force => true do |t|
    t.integer  "product_id"
    t.integer  "banner_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_components", :force => true do |t|
    t.integer  "product_id"
    t.integer  "component_id"
    t.boolean  "active",       :default => true
    t.integer  "position"
    t.integer  "created_by",   :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_documents", :force => true do |t|
    t.integer  "product_id"
    t.integer  "document_id"
    t.boolean  "active",      :default => true
    t.integer  "position"
    t.integer  "created_by",  :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_images", :force => true do |t|
    t.integer  "product_id"
    t.integer  "image_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_menus", :force => true do |t|
    t.integer  "product_id"
    t.integer  "menu_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_promos", :force => true do |t|
    t.integer  "product_id"
    t.integer  "promo_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_publications", :force => true do |t|
    t.integer  "product_id"
    t.integer  "publication_id"
    t.boolean  "active",         :default => true
    t.integer  "position"
    t.integer  "created_by",     :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_references", :force => true do |t|
    t.integer  "product_id"
    t.integer  "reference_id"
    t.boolean  "active",       :default => true
    t.integer  "position"
    t.integer  "created_by",   :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_relations", :force => true do |t|
    t.integer  "product_id"
    t.integer  "relation_id"
    t.boolean  "active",      :default => true
    t.integer  "position"
    t.integer  "created_by",  :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_styles", :force => true do |t|
    t.integer  "product_id"
    t.integer  "style_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_suggestions", :force => true do |t|
    t.integer  "product_id"
    t.integer  "suggestion_id"
    t.boolean  "active",        :default => true
    t.integer  "position"
    t.integer  "created_by",    :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_vdeos", :force => true do |t|
    t.integer  "product_id"
    t.integer  "vdeo_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.text     "history"
    t.string   "code"
    t.string   "name"
    t.string   "title"
    t.string   "description"
    t.text     "overview"
    t.text     "specifications"
    t.integer  "style_id"
    t.text     "style_css"
    t.integer  "brand_id"
    t.integer  "category_id"
    t.string   "m_title"
    t.text     "m_keywords"
    t.text     "m_description"
    t.string   "s_title"
    t.text     "s_keywords"
    t.text     "s_description"
    t.string   "a_title"
    t.text     "a_keywords"
    t.text     "a_description"
    t.string   "p_code"
    t.string   "p_name"
    t.string   "p_title"
    t.string   "p_description"
    t.text     "p_overview"
    t.text     "p_specifications"
    t.integer  "p_style_id"
    t.text     "p_style_css"
    t.string   "p_sizes"
    t.string   "p_images"
    t.string   "p_videos"
    t.string   "p_documents"
    t.string   "p_references"
    t.string   "p_publications"
    t.string   "p_relations"
    t.string   "p_components"
    t.string   "p_suggestions"
    t.string   "p_brand_id"
    t.string   "p_category_id"
    t.string   "p_categories"
    t.string   "p_extras"
    t.string   "p_m_title"
    t.text     "p_m_keywords"
    t.text     "p_m_description"
    t.string   "p_s_title"
    t.text     "p_s_keywords"
    t.text     "p_s_description"
    t.string   "p_a_title"
    t.text     "p_a_keywords"
    t.text     "p_a_description"
    t.boolean  "active",              :default => true
    t.boolean  "adjusted",            :default => false
    t.boolean  "published",           :default => false
    t.boolean  "wholesale",           :default => false
    t.boolean  "restricted_use",      :default => false
    t.boolean  "notice_to_purchaser", :default => false
    t.boolean  "sigma",               :default => false
    t.boolean  "bulk",                :default => false
    t.boolean  "inherited_bulk",      :default => false
    t.integer  "replacement_id"
    t.datetime "introduced_at"
    t.integer  "introduced_by",       :default => 1
    t.datetime "disabled_at"
    t.integer  "disabled_by",         :default => 1
    t.datetime "released_at"
    t.integer  "released_by",         :default => 1
    t.integer  "created_by",          :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "releases", :force => true do |t|
    t.datetime "time"
    t.integer  "user_id"
    t.integer  "object_id"
    t.string   "object_type"
    t.string   "action"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skus", :force => true do |t|
    t.text     "history"
    t.string   "code"
    t.integer  "price"
    t.string   "location"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "capacity",      :default => 12
    t.string   "size"
    t.string   "package"
    t.integer  "position",      :default => 0
    t.string   "p_code"
    t.integer  "p_price"
    t.string   "p_location"
    t.datetime "p_start_date"
    t.datetime "p_end_date"
    t.integer  "p_capacity",    :default => 12
    t.string   "p_size"
    t.string   "p_package"
    t.integer  "p_position",    :default => 0
    t.boolean  "sr_only",       :default => true
    t.boolean  "active",        :default => true
    t.boolean  "adjusted",      :default => false
    t.boolean  "published",     :default => false
    t.integer  "enrolled",      :default => 0
    t.integer  "course_id"
    t.integer  "product_id"
    t.datetime "introduced_at"
    t.integer  "introduced_by", :default => 1
    t.datetime "disabled_at"
    t.integer  "disabled_by",   :default => 1
    t.datetime "released_at"
    t.integer  "released_by",   :default => 1
    t.integer  "created_by",    :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_banners", :force => true do |t|
    t.integer  "survey_id"
    t.integer  "banner_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_documents", :force => true do |t|
    t.integer  "survey_id"
    t.integer  "document_id"
    t.boolean  "active",      :default => true
    t.integer  "position"
    t.integer  "created_by",  :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_images", :force => true do |t|
    t.integer  "survey_id"
    t.integer  "image_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_menus", :force => true do |t|
    t.integer  "survey_id"
    t.integer  "menu_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_promos", :force => true do |t|
    t.integer  "survey_id"
    t.integer  "promo_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_publications", :force => true do |t|
    t.integer  "survey_id"
    t.integer  "publication_id"
    t.boolean  "active",         :default => true
    t.integer  "position"
    t.integer  "created_by",     :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_styles", :force => true do |t|
    t.integer  "survey_id"
    t.integer  "style_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_vdeos", :force => true do |t|
    t.integer  "survey_id"
    t.integer  "vdeo_id"
    t.boolean  "active",     :default => true
    t.integer  "position"
    t.integer  "created_by", :default => 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "code"
    t.string   "name"
    t.string   "title"
    t.string   "description"
    t.boolean  "admin",                                 :default => false
    t.boolean  "developer",                             :default => false
    t.boolean  "creator",                               :default => false
    t.boolean  "editor",                                :default => false
    t.boolean  "destroyer",                             :default => false
    t.boolean  "releaser",                              :default => false
    t.boolean  "documents",                             :default => false
    t.boolean  "inventory",                             :default => false
    t.boolean  "website",                               :default => false
    t.boolean  "web_glossary",                          :default => false
    t.boolean  "web_social",                            :default => false
    t.boolean  "web_faq",                               :default => false
    t.boolean  "media",                                 :default => false
    t.boolean  "special",                               :default => false
    t.boolean  "system",                                :default => false
    t.boolean  "live",                                  :default => false
    t.boolean  "editable",                              :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
