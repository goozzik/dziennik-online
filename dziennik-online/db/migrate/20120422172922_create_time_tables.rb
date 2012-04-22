class CreateTimeTables < ActiveRecord::Migration

  def up
    create_table :time_tables do |t|
      t.integer :class_id
      t.integer :week_day

      t.timestamps
    end
  end

  def down
    drop_table :time_tables
  end

end
