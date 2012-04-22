class CreateSubjects < ActiveRecord::Migration

  def up
    create_table :subjects do |t|
      t.integer :school_id
      t.integer :teacher_id
      t.integer :class_id
      t.string :name
      t.boolean :deleted # For what is it?

      t.timestamps
    end
  end

  def down
    drop_table :subjects
  end

end
