class CreateSubjects < ActiveRecord::Migration

  def up
    create_table :subjects do |t|
      t.integer :school_class_id
      t.integer :subject_template_id
      t.boolean :deleted # For what is it?

      t.timestamps
    end
  end

  def down
    drop_table :subjects
  end

end
