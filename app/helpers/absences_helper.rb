# coding: utf-8
module AbsencesHelper

  def months_navigation(previous_month, next_month)
    html = "<ul class='pager'>"
    html << previous_link(previous_month)
    html << next_link(next_month)
    html << "</ul>"
    html.html_safe
  end

  def previous_link(previous_month)
    case current_user.role
    when 'teacher'
      content_tag("li", link_to('&larr; Poprzedni miesiąc'.html_safe, teacher_absences_path(:date => previous_month.strftime('%Y-%m-%d'))), :class => "previous")
    when 'director'
      content_tag("li", link_to('&larr; Poprzedni miesiąc'.html_safe, director_school_class_absences_path(:date => previous_month.strftime('%Y-%m-%d'))), :class => "previous")
    end
  end

  def next_link(next_month)
    case current_user.role
    when 'teacher'
      content_tag("li", link_to('Następny miesiąc &rarr;'.html_safe, teacher_absences_path(:date => next_month.strftime('%Y-%m-%d'))), :class => "next")
    when 'director'
      content_tag("li", link_to('Następny miesiąc &rarr;'.html_safe, director_school_class_absences_path(:date => next_month.strftime('%Y-%m-%d'))), :class => "next")
    end
  end

  def school_class_semester_absences(school_class, semester_id)
    html = ''
    absences = school_class.semester_absences(semester_id)
    absences.each { |key, count| html << "<td>#{count}</td>" }
    html.html_safe
  end

  def school_class_year_absences(school_class, year)
    html = ''
    absences = school_class.year_absences(year)
    absences.each { |key, count| html << "<td>#{count}</td>" }
    html.html_safe
  end

  def absences_percentage(required, justified, unexcused)
    percentage = sprintf("%1.2f", (required - (justified + unexcused)).to_f / required * 100)
    percentage == "NaN" ? "--" : percentage
  end

  def date_by_month(month, school_year)
    index = School::MONTHS.index(month)
    Absence.parse_first_monday(Time.parse("#{index >= 8 ? school_year[0..3] : school_year[5..8]}-#{index+1}-01")).strftime("%Y-%m-%d")
  end

end
