class AmendWeaves < ActiveRecord::Migration
  def self.up

    drop_table :weaves

    create_table :weaves do |t|
      t.string :name
      t.string :url
      t.timestamps
    end
    

    Weave.create(:name => "Standard Colours", :url => "/standard" )
    Weave.create(:name => "Naturals Colours", :url => "/naturals" )
    Weave.create(:name => "Loomtex Colours", :url => "/loomtex" )
    Weave.create(:name => "Outdoor Colours", :url => "/outdoor" )
    Weave.create(:name => "Farrow and Ball", :url => "/farrow-and-ball" )

  end

  def self.down
    drop_table :weaves
  end
end
