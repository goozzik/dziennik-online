class CreateSchools < ActiveRecord::Migration

  def up
    create_table :schools do |t|
      t.integer :user_id
      t.string :name
      t.string :address

      t.timestamps
    end
  end

  def down
    drop_table :schools
  end

end
