class CreateProfileTemplatesSubjectTemplates < ActiveRecord::Migration
  def up
     create_table :profile_templates_subject_templates, :id => false do |t|
      t.integer :profile_template_id
      t.integer :subject_template_id
    end
  end

  def down
    drop_table :profile_templates_subject_templates
  end
end
