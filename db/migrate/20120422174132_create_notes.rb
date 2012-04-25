class CreateNotes < ActiveRecord::Migration

  def up
    create_table :notes do |t|
      t.integer :user_id
      t.integer :school_class_id
      t.integer :teacher_id
      t.string :description

      t.timestamps
    end
  end

  def down
    drop_table :notes
  end

end
