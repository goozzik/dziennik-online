class CreateProfileTemplates < ActiveRecord::Migration
  def up 
    create_table :profile_templates do |t|
      t.string :name
      t.integer :school_id
      t.integer :start_year

      t.timestamps
    end
  end

  def down
    drop_table :profile_templates
  end
end
