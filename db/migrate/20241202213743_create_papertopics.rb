class CreatePapertopics < ActiveRecord::Migration[7.1]
  def change
    create_table :papertopics do |t|
      t.integer :topic_id
      t.integer :paper_id

      t.timestamps
    end
  end
end
