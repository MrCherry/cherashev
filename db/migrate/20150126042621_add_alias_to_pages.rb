class AddAliasToPages < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :alias, :string, nil: false
    add_index :pages, :alias, unique: true
  end
end
