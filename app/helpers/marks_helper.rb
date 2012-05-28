# coding: utf-8
module MarksHelper

  def director_subjects_navigation(school_class)
    html = "<ul class='nav nav-tabs'>"
    school_class.subjects.each do |subject|
      html << nav_link_to(subject.name, director_marks_path(school_class, subject))
    end
    html << "</ul>"
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

  def add_description_button
    link_to(image_tag("plus.gif"),
            "#new_description",
            :id => "add_description",
            "data-toggle" => "modal",
            "data-original-title" => "Dodaj nowy typ oceny",
            "data-content" => "Kliknij aby dodać nową ocenę dla klasy."
           )
  end

end
