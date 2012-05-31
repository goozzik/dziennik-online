class CreateMarks < ActiveRecord::Migration

  def up
    create_table :marks do |t|
      t.integer :semester_id
      t.integer :student_id
      t.integer :subject_id
      t.integer :description_id
      t.string :mark

      t.timestamps
    end
  end

  def down
    drop_table :marks
  end

end
