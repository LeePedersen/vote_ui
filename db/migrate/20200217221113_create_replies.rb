class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.string :name
      t.string :title
      t.string :content
      t.integer :post_id
      t.timestamps
    end
  end
end
