class CreateSubjectTemplates < ActiveRecord::Migration

  def up
    create_table :subject_templates do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :subjects
  end

end
