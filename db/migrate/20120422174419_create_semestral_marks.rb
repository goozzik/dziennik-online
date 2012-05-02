class CreateSemestralMarks < ActiveRecord::Migration

  def up
    create_table :semestral_marks do |t|
      t.integer :student_id
      t.integer :school_class_id
      t.integer :semester_id
      t.integer :subject_id
      t.integer :mark

      t.timestamps
    end
  end

  def down
    drop_table :semestral_marks
  end

end
