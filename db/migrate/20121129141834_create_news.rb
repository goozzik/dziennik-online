class CreateNews < ActiveRecord::Migration

  def up
    create_table :news do |t|
      t.string :title
      t.text :body
      t.boolean :teacher, default: false
      t.boolean :admin, default: false
      t.boolean :director, default: false
      t.boolean :student, default: false

      t.timestamps
    end
  end

  def drop
    drop_table :news
  end

end
