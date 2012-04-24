class CreateDocuments < ActiveRecord::Migration

  def up
    create_table :documents do |t|
      t.integer :school_class_id
      t.integer :semester_id
      t.string :name
      t.string :description
      t.string :path
      t.string :type
      t.integer :size

      t.timestamps
    end
  end

  def down
    drop_table :documents
  end

end
