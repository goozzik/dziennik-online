class CreateAbsenceReports < ActiveRecord::Migration

  def up
    create_table :absence_reports do |t|
      t.integer :student_id
      t.integer :class_id
      t.date :date
      t.float :percentage

      t.timestamps
    end
  end

  def down
    drop_table :absences_reports
  end

end
