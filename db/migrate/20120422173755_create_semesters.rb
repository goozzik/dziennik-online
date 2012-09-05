class CreateSemesters < ActiveRecord::Migration

  def up
    create_table :semesters do |t|
      t.integer :school_id
      t.integer :semester
      t.integer :start_year
      t.integer :end_year
      t.boolean :active, default: false
      t.boolean :archived, default: false

      t.timestamps
    end
  end

  def down
    drop_table :semesters
  end

end
