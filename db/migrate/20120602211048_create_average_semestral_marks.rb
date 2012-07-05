class CreateAverageSemestralMarks < ActiveRecord::Migration

  def up
    create_table :average_semestral_marks do |t|
      t.integer :student_id
      t.integer :school_class_id
      t.integer :semester_id
      t.float :average

      t.timestamps
    end
    add_index :average_semestral_marks, [:student_id, :semester_id], :unique => true 
  end

  def down
    drop_table :average_semestral_marks
  end

end
