# coding: utf-8
module AbsencesHelper

  def months_navigation(previous_month, next_month, user_type)
    html = "<ul class='pager'>"
    html << previous_link(previous_month)
    html << next_link(next_month)
    html << "</ul>"
    html.html_safe
  end

  def previous_link(previous_month)
    case user_type
    when 'teacher'
      content_tag("li", link_to('&larr; Poprzedni miesiąc'.html_safe, teacher_absences_path(:date => previous_month.strftime('%Y-%m-%d'))), :class => "previous")
    when 'director'
      content_tag("li", link_to('&larr; Poprzedni miesiąc'.html_safe, actual_director_absences_path(:date => previous_month.strftime('%Y-%m-%d'))), :class => "previous")
    end
  end

  def next_link(next_month)
    case user_type
    when 'teacher'
      content_tag("li", link_to('Nestępny miesiąc &rarr;'.html_safe, teacher_absences_path(:date => next_month.strftime('%Y-%m-%d'))), :class => "next")
    when 'director'
      content_tag("li", link_to('Nestępny miesiąc &rarr;'.html_safe, actual_directio_absences_path(:date => next_month.strftime('%Y-%m-%d'))), :class => "previous")
    end
  end

  def percentage_frequency(required_month, justified_month, unexcused_month)
    percentage = sprintf("%1.2f", (required_month - (justified_month + unexcused_month)).to_f / required_month * 100)
    percentage == "NaN" ? "--" : percentage
  end

  def semester_absences(student, semester_id)
    html = ''
    absences = student.semester_absences(semester_id)
    absences.each { |key, count| html << "<td>#{count}</td>" }
    html.html_safe
  end

  def semesters_navigation(school_class, semesters)
    html = ''
    semesters.each do |semester|
      html << link_to("Semestr #{semester.semester}", general_director_absences_path(school_class, :semester_id => semester.id))
    end
    html.html_safe
  end

end
