class CreateBells < ActiveRecord::Migration

  def up
    create_table :bells do |t|
      t.integer :school_id
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end

  def down
    drop_table :bells
  end

end
