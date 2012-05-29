# coding: utf-8
module SemestersHelper

  def semester_dropdown_link(semester, school_class)
    content_tag("li", link_to(semester.fullname, set_school_class_semester_path(semester)), :class => ("active" if semester.is_active_in_school_class?(school_class)))
  end

  def semester_dropdown_button
    link_to "Wybierz semestr <span class='caret'></span>".html_safe, "#", :class => "btn btn-primary dropdown-toggle", "data-toggle" => "dropdown"
  end

end
