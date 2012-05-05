class CreateLessons < ActiveRecord::Migration

  def up
    create_table :lessons do |t|
      t.integer :subject_id
      t.integer :time_table_id
      t.integer :number

      t.timestamps
    end
  end

  def down
    drop_table :lessons
  end

end
