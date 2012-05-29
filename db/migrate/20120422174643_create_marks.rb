class CreateMarks < ActiveRecord::Migration

  def up
    create_table :marks do |t|
      t.integer :student_id
      t.integer :description_id
      t.string :mark

      t.timestamps
    end
  end

  def down
    drop_table :marks
  end

end
