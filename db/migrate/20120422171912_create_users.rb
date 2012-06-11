class CreateUsers < ActiveRecord::Migration

  def up
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :pesel
      t.integer :niu
      t.string :street
      t.string :city
      t.string :zip_code
      t.string :province
      t.string :telephone
      t.boolean :individual
      t.boolean :boarding_school
      t.integer :school_class_id
      t.integer :school_id
      t.integer :semester_id
      t.integer :teacher_id
      t.string :role
      t.boolean :deleted # I don't realy know why we need this? #goozzik

      t.timestamps
    end
  end

  def down
    drop_table :users
  end

end
