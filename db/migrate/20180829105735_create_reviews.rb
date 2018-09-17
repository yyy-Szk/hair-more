class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.float :star
      t.integer :teacher_id
      t.integer :user_id
      t.text :content
      t.timestamps
    end
  end
end
