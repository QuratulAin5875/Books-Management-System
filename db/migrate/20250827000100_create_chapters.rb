class CreateChapters < ActiveRecord::Migration[7.1]
  def change
    return if table_exists?(:chapters)
    create_table :chapters do |t|
      t.references :book, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true
      t.string :title, null: false
      t.text :body
      t.integer :position
      t.timestamps
    end
  end
end

