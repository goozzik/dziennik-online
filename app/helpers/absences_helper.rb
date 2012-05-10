# coding: utf-8
module AbsencesHelper

  def months_navigation(prev_month, next_month, user_type)
    html = ''
    html << '<div class="navigation">'
    if user_type == 'teacher'
      html << link_to('<< Poprzedni miesiąc', teacher_absences_path(:date => prev_month.strftime('%Y-%m-%d')))
      html << ' | '
      html << link_to('Następny miesiąc >>', teacher_absences_path(:date => next_month.strftime('%Y-%m-%d')))
    elsif  user_type == 'director'
      html << link_to('<< Poprzedni miesiąc', actual_director_absences_path(:date => prev_month.strftime('%Y-%m-%d')))
      html << ' | '
      html << link_to('Następny miesiąc >>', actual_director_absences_path(:date => next_month.strftime('%Y-%m-%d')))
    end
    html << '</div>'
    html.html_safe
  end

  def percentage_frequency(required_month, justified_month, unexcused_month)
    percentage = sprintf("%1.2f", (required_month - (justified_month + unexcused_month)).to_f / required_month * 100)
    percentage == "NaN" ? "--" : percentage
  end

end
