class RemoveClassYearFromSchoolClasses < ActiveRecord::Migration

  def change
    remove_column :school_classes, :year
  end

end
