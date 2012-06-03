class CreateMessages < ActiveRecord::Migration

  def up
    create_table :messages do |t|
      t.integer :school_class_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end

  def down
    drop_table :messages
  end

end
