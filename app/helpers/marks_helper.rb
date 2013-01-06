# coding: utf-8
module MarksHelper

  def link_to_delete_description(description)
    link_to(truncate(description.desc_type, :length => 4, :omission => ''),
            teacher_description_path(description),
            :method => :delete,
            :confirm => "Jesteś pewien?",
            :class => "description"
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
