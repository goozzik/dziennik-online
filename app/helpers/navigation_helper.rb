# coding: utf-8

module NavigationHelper

  def navigation
    case current_user.role
    when 'student'
      student_navigation
    when 'teacher'
      teacher_navigation
    when 'admin'
      admin_navigation
    when 'director'
      director_navigation
    when 'superadmin'
      superadmin_navigation
    end
  end

  def nav_link_to(name, path)
    content_tag("li", link_to(name, path), :class => nav_link_html_class(path))
  end

  def teacher_navigation
    if current_teacher.school_class
      html = nav_link_to("Oceny", teacher_subject_path(current_teacher.subjects.first))
      html << nav_link_to("Frekwencja", teacher_absences_path)
      html << nav_link_to("Raporty", teacher_reports_path)
      html << nav_link_to("Wiadomości", teacher_messages_path)
      html << nav_link_to("Dokumenty", teacher_documents_path)
      html << nav_link_to("Plan lekcji", teacher_time_tables_path)
      html << nav_link_to("Uczniowie", teacher_students_path)
      html.html_safe
    end
  end

  def director_reports_dropdown
    html = "<li class='dropdown'>
              <a href='#' class='dropdown-toggle' data-toggle='dropdown'>
                Raporty
                <b class='caret'></b>
              </a>
              <ul class='dropdown-menu'>"
    html << nav_link_to("Raport frekwencji klas", director_reports_absences_path)
    if school_class = current_director.school_classes.first
      html << nav_link_to("Raporty klas", director_school_class_report_path(school_class))
    end
    html << "</ul></li>"
    html.html_safe
  end

  def director_students_dropdown
    html = "<li class='dropdown'>
              <a href='#' class='dropdown-toggle' data-toggle='dropdown'>
                Uczniowie
                <b class='caret'></b>
              </a>
              <ul class='dropdown-menu'>"
    html << nav_link_to("z najwyższą średnią", director_students_top_path)
    html << nav_link_to("do egzaminów poprawkowych", director_students_resit_path)
    html << nav_link_to("do egzaminów klasyfikacyjnych", director_students_classification_path)
    html << "</ul></li>"
    html.html_safe
  end

  def director_navigation
     html = nav_link_to("Klasy", director_school_classes_path)
     html << director_reports_dropdown
     html << director_students_dropdown
     html << nav_link_to("Dokumenty", director_documents_path)
     html.html_safe
  end

  def admin_navigation
     html = nav_link_to("Użytkownicy", admin_users_path)
     html << nav_link_to("Ustawienia szkoły", admin_school_path)
     html.html_safe
  end

  def student_navigation
    html = nav_link_to("Oceny", student_marks_path)
    html << nav_link_to("Frekwencja", student_absences_path)
    html << nav_link_to("Raporty", student_reports_path)
    html << nav_link_to("Wiadomości", student_messages_path)
    html << nav_link_to("Plan lekcji", student_time_tables_path)
    html.html_safe
  end

  def account_dropdown_navigation
    html = "<li class='dropdown'>"
    html << link_to("Konto <b class='caret'></b>".html_safe, "#", :class => "dropdown-toggle", "data-toggle" => "dropdown")
    html << "<ul class='dropdown-menu'>"
    html << nav_link_to("Ustawienia klas", teacher_school_classes_path) if current_user.role == "teacher"
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
