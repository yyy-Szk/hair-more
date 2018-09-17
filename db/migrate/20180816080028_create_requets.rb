class CreateRequets < ActiveRecord::Migration[5.2]
  def change
    create_table :requets do |t|
      t.integer :user_id
      t.string :name
      t.integer :topic_id
      t.string :description
      t.timestamps
    end
  end
end
