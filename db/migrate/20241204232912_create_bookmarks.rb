class CreateBookmarks < ActiveRecord::Migration[7.1]
  def change
    create_table :bookmarks do |t|
      t.integer :paper_id
      t.integer :user_id
      t.string :comment

      t.timestamps
    end
  end
end
