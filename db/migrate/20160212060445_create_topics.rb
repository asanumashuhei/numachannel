class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.text :body

      t.timestamps
    end
  end
end
