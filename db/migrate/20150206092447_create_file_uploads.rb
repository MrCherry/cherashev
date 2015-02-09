class CreateFileUploads < ActiveRecord::Migration
  def change
    create_table :file_uploads do |t|
      t.string :original_file_name, null: false
      t.string :file_name, null: false
      t.string :file_type

      t.timestamps null: false
    end

    add_index :file_uploads, :original_file_name
    add_index :file_uploads, :file_name, unique: true
    add_index :file_uploads, :file_type
  end
end
