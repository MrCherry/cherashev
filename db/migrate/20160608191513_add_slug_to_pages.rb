class AddSlugToPages < ActiveRecord::Migration
  def up
    add_column :pages, :slug, :string
    add_index :pages, :slug, unique: true

    from_alias_to_slug

    remove_index :pages, :alias
    remove_column :pages, :alias
  end

  def down
    add_column :pages, :alias, :string
    add_index :pages, :alias, unique: true

    from_slug_to_alias

    remove_index :pages, :slug
    remove_column :pages, :slug, :string
  end

  private

  def from_alias_to_slug
    if class_exists?('Page')
      Page.where('alias IS NOT NULL AND LENGTH(alias) > 0').each do |page|
        page.slug = page.alias
        page.save
      end
    end
  end

  def from_slug_to_alias
    if class_exists?('Page')
      Page.where('slug IS NOT NULL AND LENGTH(slug) > 0').each do |page|
        page.alias = page.slug
        page.save
      end
    end
  end

  def class_exists?(class_name)
    klass = Module.const_get(class_name)
    return klass.is_a?(Class)
  rescue NameError
    return false
  end
end
