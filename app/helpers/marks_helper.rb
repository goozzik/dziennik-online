module MarksHelper

  def subjects_navigation(school_class)
    html = ''
    school_class.subjects.each do |subject|
      html << link_to(subject.name, director_marks_path(school_class, :subject_id => subject.id))
    end
    html.html_safe
  end

end
