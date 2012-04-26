class CreateDescriptions < ActiveRecord::Migration

  def up
    create_table :descriptions do |t|
      t.integer :subject_id
      t.integer :semester_id
      t.string :desc_type
      t.integer :colour
      t.string :description

      t.timestamps
    end
  end

  def down
    drop_table :descriptions
  end

end
