class CreateBehaviorMarks < ActiveRecord::Migration

  def change
    create_table :behavior_marks do |t|
      t.integer :semester_id
      t.integer :school_class_id
      t.integer :student_id
      t.string :mark

      t.timestamps
    end
  end

end
