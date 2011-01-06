class AddDocUploadToNews < ActiveRecord::Migration
  def self.up
    add_column :news_items, :doc_file_name,    :string
    add_column :news_items, :doc_content_type, :string
    add_column :news_items, :doc_file_size,    :integer
    add_column :news_items, :doc_updated_at,   :datetime
  end

  def self.down
    add_column :news_items, :doc_file_name
    add_column :news_items, :doc_content_type
    add_column :news_items, :doc_file_size
    add_column :news_items, :doc_updated_at
  end
end
