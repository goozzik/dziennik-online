class CreateNotes < ActiveRecord::Migration

  def up
    create_table :schools do |t|
      t.integer :user_id
      t.integer :class_id
      t.integer :teacher_id
      t.string :description

      t.timestamps
    end
  end

  def down
    drop_table :schools
  end

end
