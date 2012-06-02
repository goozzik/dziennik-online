# coding: utf-8

module NavigationHelper

  def navigation
    if current_user.student
      student_navigation
    elsif current_user.teacher
      teacher_navigation
    elsif current_user.admin
      admin_navigation
    elsif current_user.director
      director_navigation
    elsif current_user.superadmin
      superadmin_navigation
    end
  end

  def nav_link_to(name, path)
    content_tag("li", link_to(name, path), :class => nav_link_html_class(path))
  end

  def teacher_navigation
     html = nav_link_to("Oceny", teacher_subjects_path)
     html << nav_link_to("Frekwencja", teacher_absences_path)
     html << nav_link_to("Raporty", teacher_raports_path)
     html << nav_link_to("Wiadomości", teacher_messages_path)
     html << nav_link_to("Dokumenty", teacher_documents_path)
     html << nav_link_to("Plan lekcji", teacher_time_tables_path)
     html << nav_link_to("Uczniowie", teacher_students_path)
     #html << nav_link_to("Nauczyciele", "#")
     html.html_safe
  end

  def director_navigation
     html = nav_link_to("Klasy", director_school_classes_path)
     html << nav_link_to("Raporty", director_reports_path)
     html.html_safe
  end

  def admin_navigation
     html = nav_link_to("Ustawienia szkoły", admin_school_path)
     html.html_safe
  end

  def student_navigation
    html = nav_link_to("Oceny", student_marks_path)
    html << nav_link_to("Frekwencja", student_absences_path)
    html << nav_link_to("Wiadomości", student_messages_path)
    html << nav_link_to("Plan lekcji", student_time_tables_path)
    html.html_safe
  end

  def account_dropdown_navigation
    html = "<li class='dropdown'>"
    html << link_to("Konto <b class='caret'></b>".html_safe, "#", :class => "dropdown-toggle", "data-toggle" => "dropdown")
    html << "<ul class='dropdown-menu'>"
    html << nav_link_to("Ustawienia klas", teacher_school_classes_path) if user_type == "teacher"
    html << nav_link_to("Ustawienia konta", edit_user_registration_path)
    html << content_tag("li", link_to("Wyloguj", destroy_user_session_path, :method => :delete))
    html << "</ul>"
    html << "</li>"
    html.html_safe
  end

  private

    def nav_link_html_class(path)
      request.env['PATH_INFO'] == path ? "active" : nil
    end

end
