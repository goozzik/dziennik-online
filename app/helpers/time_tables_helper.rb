module TimeTablesHelper

  def link_to_add_lesson(name, f, subjects)
    new_object = f.object.class.reflect_on_association(:lessons).klass.new
    fields = f.fields_for(:lessons, new_object, :child_index => "new_#{:lessons}") do |lesson|
      render(partial_lesson_path, :lessons_form => lesson, :subjects => subjects)
    end
    link_to_function(name, "add_fields(this, \"#{:lessons}\", \"#{escape_javascript(fields)}\")", :class => "btn")
  end

  private

    def partial_lesson_path
      "teacher/time_tables/form/lesson_form"
    end

end
