class CreateSchoolClasses < ActiveRecord::Migration

  def up
    create_table :school_classes do |t|
      t.integer :school_id
      t.integer :teacher_id
      t.integer :semester_id
      t.integer :yearbook
      t.integer :grade
      t.integer :period
      t.string :profile
      t.string :letter
      t.boolean :active

      t.timestamps
    end
    add_index :school_classes, [:teacher_id, :active], :unique => true 
  end

  def down
    drop_table :school_classes
  end

end
