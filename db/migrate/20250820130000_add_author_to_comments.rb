class AddAuthorToComments < ActiveRecord::Migration[8.0]
  def change
    add_reference :comments, :author, foreign_key: true, null: true
  end
end


