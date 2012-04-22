class CreateSchoolClasses < ActiveRecord::Migration

  def up
    create_table :school_classes do |t|
      t.integer :school_id
      t.integer :teacher_id
      t.integer :yearbook
      t.integer :year
      t.string :profile
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end

  def down
    drop_table :school_classes
  end

end