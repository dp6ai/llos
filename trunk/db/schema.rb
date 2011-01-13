# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110113215748) do

  create_table "fabrics", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_name"
    t.string   "address"
    t.boolean  "callmeback"
    t.boolean  "member_of_public"
    t.boolean  "shop_owner"
    t.boolean  "architect"
    t.boolean  "other"
    t.string   "other_detail"
    t.boolean  "indoor"
    t.boolean  "outdoor"
    t.boolean  "naturals"
    t.boolean  "further_info"
    t.string   "where"
  end

  create_table "news_items", :force => true do |t|
    t.string   "headline"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "doc_file_name"
    t.string   "doc_content_type"
    t.integer  "doc_file_size"
    t.datetime "doc_updated_at"
  end

  create_table "product_attribute_fields", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_attributes", :force => true do |t|
    t.integer "product_id",                 :null => false
    t.integer "product_attribute_field_id", :null => false
    t.string  "value",                      :null => false
  end

  create_table "product_fabrics", :force => true do |t|
    t.integer  "product_id"
    t.integer  "fabric_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_range_translations", :force => true do |t|
    t.integer  "product_range_id"
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_range_translations", ["product_range_id"], :name => "index_1f4c5fe30f9a73007afa41cfd020814bab7978c6"

  create_table "product_ranges", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
  end

  create_table "product_weaves", :force => true do |t|
    t.integer  "product_id"
    t.integer  "weave_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description",        :limit => 255
    t.integer  "width"
    t.integer  "depth"
    t.integer  "height"
    t.string   "code"
    t.integer  "product_range_id"
    t.integer  "highlighted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "preview_image_file_name"
    t.string   "preview_image_content_type"
    t.integer  "preview_image_file_size"
    t.datetime "preview_image_updated_at"
  end

  create_table "tag_translations", :force => true do |t|
    t.integer  "tag_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tag_translations", ["tag_id"], :name => "index_tag_translations_on_tag_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.string   "taggable_type", :default => ""
    t.integer  "taggable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "highlighted",   :default => 0
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string   "name",       :default => ""
    t.string   "kind",       :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name", "kind"], :name => "index_tags_on_name_and_kind"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "weaves", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort_order", :default => 0
  end

end
