class CreateTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :topics do |t|
      t.string :topic
      t.integer :papertopics_count

      t.timestamps
    end
  end
end
