class CreatePhotos < ActiveRecord::Migration
  def up
    create_table :photos do |t|
      t.integer "announcement_id", :null => false
      t.attachment :image,    :null=>false
      t.timestamps :null=>false
    end
    add_foreign_key :photos, :announcements, on_delete: :cascade
    add_index("photos", "announcement_id")
  end

  def down
    drop_table :photos
  end
end
