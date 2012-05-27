# coding: utf-8
module ApplicationHelper

  def user_type
    if current_user.student
      'student'
    elsif current_user.teacher
      'teacher'
    elsif current_user.admin
      'admin'
    elsif current_user.director
      'director'
    elsif current_user.superadmin
      'superadmin'
    end
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

end
