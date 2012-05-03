# coding: utf-8
module AbsencesHelper

  def months_navigation(prev_month, next_month)
    html = ''
    html << '<div class="navigation">'
      html << link_to('<< Poprzedni miesiąc', teacher_absences_path(:date => prev_month.strftime('%Y-%m-%d')))
      html << ' | '
      html << link_to('Następny miesiąc >>', teacher_absences_path(:date => next_month.strftime('%Y-%m-%d')))
    html << '</div>'
    html.html_safe
  end

end
