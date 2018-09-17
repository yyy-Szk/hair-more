class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :email, unique: true
      t.string :image
      t.string :introduce
      t.string :password_digest
      t.timestamps
    end
  end
end
