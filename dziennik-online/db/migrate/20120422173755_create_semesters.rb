class CreateSemesters < ActiveRecord::Migration

  def up
    create_table :semesters do |t|
      t.integer :class_id
      t.integer :semester
      t.integer :teacher_id
      t.boolean :active

      t.timestamps
    end
  end

  def down
    drop_table :semesters
  end

end
