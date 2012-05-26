# coding: utf-8
module ApplicationHelper

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

  def icon_navigation
    if current_user.teacher
      teacher_icon_navigation
    end
  end

  def teacher_navigation
     html = ""
     html << nav_link_to("Oceny", teacher_subjects_path)
     html << nav_link_to("Frekwencja", teacher_absences_path)
     html << nav_link_to("Dokumenty", teacher_documents_path)
     html << nav_link_to("Plan lekcji", teacher_time_tables_path)
     #html << nav_link_to("Raporty", "#")
     html << nav_link_to("Uczniowie", teacher_students_path)
     html << nav_link_to("Nauczyciele", "#")
     html.html_safe
  end

  def teacher_icon_navigation
    '<div id="icon_navigation">
       <a href="teacher/subjects"><img src="/assets/menu_01.png" class="home_menu"></a>
       <a href="teacher/absences"><img src="/assets/menu_02.png" class="home_menu"></a>
       <a href="teacher/time_tables"><img src="/assets/menu_03.png" class="home_menu"></a>
       <a href="teacher/subject_teachers"><img src="/assets/menu_04.png" class="home_menu"></a>
       <a href="teacher/documents"><img src="/assets/menu_05.png" class="home_menu"></a>
       <a href="teacher/documents"><img src="/assets/menu_06.png" class="home_menu"></a>
       <a href=""><img src="/assets/menu_07.png" class="home_menu"></a>
       <a href="teacher/school_classes"><img src="/assets/menu_08.png" class="home_menu"></a>
       <a href="teacher/students"><img src="/assets/menu_09.png" class="home_menu"></a>
       <!--<a href=""><img src="/assets/menu_10.png" class="home_menu"></a>-->
       <a href=""><img src="/assets/menu_11.png" class="home_menu"></a>
    </div>'.html_safe
  end

  def director_navigation
    '<center>
       <ul>
         <li class="first"><a href="/">Strona główna</a></li>' +
         '<li><a href="/director/school_classes">Klasy</a></li>' +
         '<li><a href="/users/edit">Ustawienia</a></li>' +
         '<li class="last"><a href="/users/sign_out" data-method="delete">Wyloguj</a></li>' +
       '</ul>
     </center>'
  end

  def student_navigation
    '<center>
       <ul>
         <li class="first"><a href="/">Strona główna</a></li>' +
         '<li><a href="/student/marks">Oceny</a></li>' +
         '<li><a href="/student/absences">Frekwencja</a></li>' +
         '<li><a href="/student/time_tables">Plan lekcji</a></li>' +
         '<li><a href="/users/edit">Ustawienia</a></li>' +
         '<li class="last"><a href="/users/sign_out" data-method="delete">Wyloguj</a></li>' +
       '</ul>
     </center>'
  end

  def user_type
    if current_user.teacher
      'teacher'
    elsif current_user.director
      'director'
    end
  end

  def nav_link_to(name, path)
    content_tag("li", link_to(name, path), :class => nav_link_html_class(path))
  end

  def page_header(text)
    "<div class='page-header'><h1>#{text}</h1></div>".html_safe
  end

  def row_3(count)
    "<div class='row'>".html_safe if (count+1) % 3 == 1
  end

  def end_row_3(i, count)
    "</div>".html_safe if (i+1) % 3 == 0 || i+1 == count
  end

  def alert_box(header, text)
    "<div class='alert'>
      <button class='close' data-dismiss='alert'>×</button>
      <h4 class='alert-heading'>#{header}</h4>
      #{text}
    </div>".html_safe
  end

  private

    def nav_link_html_class(path)
      request.env['PATH_INFO'] == path ? "active" : nil
    end
end
