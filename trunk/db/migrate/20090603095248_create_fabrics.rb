class CreateFabrics < ActiveRecord::Migration
  def self.up
    create_table :fabrics do |t|
      t.string :name
      t.string :url

      t.timestamps
    end

    Fabric.create(:name => "Fabric", :url => "/fabric")
  end

  def self.down
    drop_table :fabrics
  end
end
