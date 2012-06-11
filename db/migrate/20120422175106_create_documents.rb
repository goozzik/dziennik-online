class CreateDocuments < ActiveRecord::Migration

  def up
    create_table :documents do |t|
      t.integer :school_class_id
      t.integer :school_id
      t.string :name
      t.string :description
      t.string :document
      t.integer :user_id
      t.string :user_type

      t.timestamps
    end
  end

  def down
    drop_table :documents
  end

end
