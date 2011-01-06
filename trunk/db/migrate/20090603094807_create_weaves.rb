class CreateWeaves < ActiveRecord::Migration
  def self.up
    create_table :weaves do |t|
      t.string :name
      t.string :url
      t.timestamps
    end

    Weave.create(:name => "Standard", :url => "/standard" )
    Weave.create(:name => "Naturals", :url => "/naturals" )
    Weave.create(:name => "Loomtex", :url => "/loomtex" )
    Weave.create(:name => "Outdoor", :url => "/outdoor" )
    Weave.create(:name => "Other", :url => "/other" )
  end

  def self.down
    drop_table :weaves
  end
end
