class CreatePapers < ActiveRecord::Migration[7.1]
  def change
    create_table :papers do |t|
      t.string :title
      t.string :author
      t.string :arxiv_identifier
      t.string :url
      t.string :text
      t.integer :user_id
      t.integer :papertopics_count

      t.timestamps
    end
  end
end
