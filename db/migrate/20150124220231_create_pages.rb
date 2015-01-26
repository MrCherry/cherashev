class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title, nil: false
      t.text :text
      t.integer :category, default: 0
      t.integer :state, default: 0

      t.timestamps null: false
    end

    add_index :pages, :title
    add_index :pages, :category
    add_index :pages, :state
  end
end
