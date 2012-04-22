class CreateAbsences < ActiveRecord::Migration

  def up
    create_table :absences do |t|
      t.integer :student_id
      t.integer :class_id
      t.integer :absence_report_id
      t.date :date
      t.boolean :required
      t.boolean :justified
      t.boolean :unexcused
      t.boolean :late
      t.time :end_time

      t.timestamps
    end
  end

  def down
    drop_table :absences
  end

end
