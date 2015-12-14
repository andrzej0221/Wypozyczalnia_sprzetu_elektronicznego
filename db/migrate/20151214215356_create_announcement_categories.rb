class CreateAnnouncementCategories < ActiveRecord::Migration
  def up
    create_table :announcement_categories do |t|
      t.string "names", :null=>false
      t.integer "position"
      t.boolean "visible", :default=>true
      t.timestamps null: false
    end
  end

  def down
    drop_table :announcement_categories
  end
end
