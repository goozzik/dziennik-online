class CreateAbsences < ActiveRecord::Migration

  def up
    create_table :absences do |t|
      t.integer :student_id
      t.integer :school_class_id
      t.integer :semester_id
      t.integer :absence_report_id
      t.integer :required
      t.integer :justified
      t.integer :unexcused
      t.integer :late
      t.integer :month
      t.integer :week
      t.time :end_time

      t.timestamps
    end
  end

  def down
    drop_table :absences
  end

end
