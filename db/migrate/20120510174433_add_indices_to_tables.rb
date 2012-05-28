class AddIndicesToTables < ActiveRecord::Migration

  def change
    add_index :absences, :school_class_id
    add_index :absences, :semester_id
    add_index :bells, :school_id
    add_index :descriptions, :subject_id
    add_index :descriptions, :semester_id
    add_index :documents, :school_class_id
    add_index :documents, :semester_id
    add_index :lessons, :subject_id
    add_index :lessons, :time_table_id
    add_index :marks, :school_class_id
    add_index :marks, :semester_id
    add_index :marks, :subject_id
    add_index :marks, :description_id
    add_index :notes, :user_id
    add_index :notes, :school_class_id
    add_index :school_classes, :school_id
    add_index :schools, :user_id
    add_index :semesters, :school_class_id
    add_index :semestral_marks, :school_class_id
    add_index :semestral_marks, :semester_id
    add_index :semestral_marks, :subject_id
    add_index :subjects, :school_class_id
    add_index :subjects, :subject_template_id
    add_index :time_tables, :school_class_id
    add_index :users, :school_class_id
    add_index :users, :school_id
    add_index :users, :semester_id
  end

end
