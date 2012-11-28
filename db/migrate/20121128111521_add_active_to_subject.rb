class AddActiveToSubject < ActiveRecord::Migration

  def change
    change_table(:subjects) { add_column :subjects, :active, :boolean, default: true }
  end

end
