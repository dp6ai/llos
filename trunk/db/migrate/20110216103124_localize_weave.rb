class LocalizeWeave < ActiveRecord::Migration
  def self.up
    Weave.create_translation_table! :name => :string
  end

  def self.down
    Weave.drop_translation_table!
  end
end
