class CreateSemesterMarks < ActiveRecord::Migration

  def up
    create_table :semester_marks do |t|
      t.integer :student_id
      t.integer :school_class_id
      t.integer :semester_id
      t.integer :subject_id
      t.integer :mark

      t.timestamps
    end
  end

  def down
    drop_table :semester_marks
  end

end
