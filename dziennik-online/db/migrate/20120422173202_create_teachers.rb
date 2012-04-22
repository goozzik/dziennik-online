class CreateTeachers < ActiveRecord::Migration

  def up
    create_table :teachers do |t|
      t.integer :class_id
      t.integer :subject_id
      t.string :first_name
      t.string :last_name
      t.string :work_hours
      t.string :telephone
      t.string :mail

      t.timestamps
    end
  end

  def down
    drop_table :teachers
  end

end
