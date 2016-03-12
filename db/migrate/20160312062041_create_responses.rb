class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :topic_id
      t.text :res_content


      t.timestamps
    end
  end
end
