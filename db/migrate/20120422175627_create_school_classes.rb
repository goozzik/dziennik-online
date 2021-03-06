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
      t.integer :profile_template_id

      t.timestamps
    end
  end

  def down
    drop_table :school_classes
  end

end
