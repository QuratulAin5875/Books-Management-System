class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author_name
      t.date :published_date
      t.string :publisher


      t.timestamps
    end
  end
end
