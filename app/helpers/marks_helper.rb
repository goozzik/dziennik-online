# coding: utf-8
module MarksHelper

  def subjects_navigation(school_class)
    html = ''
    school_class.subjects.each do |subject|
      html << link_to(subject.name, director_marks_path(school_class, :subject_id => subject.id))
    end
    html.html_safe
  end

  def link_to_delete_description(description)
    link_to(truncate(description.desc_type, :length => 4, :omission => ''),
            teacher_description_path(description),
            :method => :delete,
            :confirm => "Jesteś pewien?",
            :class => "description",
            "data-original-title" => description.desc_type,
            "data-content" => description.description,
           )
  end

end
