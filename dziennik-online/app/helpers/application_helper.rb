# coding: utf-8
module ApplicationHelper

  def navigation
    html = ''
    html << "<div id='navigation'>"
    if current_user.student
      html << student_navigation
    elsif current_user.teacher
      html << teacher_navigation
    elsif current_user.admin
      html << admin_navigation
    elsif current_user.director
      html << director_navigation
    elsif current_user.superadmin
      html << superadmin_navigation
    end
    html << "</div>"
    html.html_safe
  end

  def teacher_navigation
    '<center>
       <ul>
         <li class="first"><a href="/">Strona główna</a></li>' +
         '<li><a href="/teacher/students">Uczniowie</a></li>' +
         '<li><a href="/teacher/subjects">Oceny</a></li>' +
         '<li><a href="/teacher/documents">Dokumenty</a></li>' +
         '<li><a href="/teacher/time_tables">Plan lekcji</a></li>' +
         '<li><a href="/teacher/subject_teachers">Nauczyciele</a></li>' +
         '<li><a href="">Raporty</a></li>' +
         '<li><a href="/teacher/absences">Frekwencja</a></li>' +
         '<li><a href="/users/edit">Ustawienia</a></li>' +
         '<li><a href="/teacher/school_classes">Ustawienia klas</a></li>' +
         '<li class="last"><a href="/users/logout">Wyloguj</a></li>' +
       '</ul>
     </center>'
  end

  def flash_messages
    flash[:notice] if flash[:notice]
  end

end
