# coding: utf-8
module TeachersHelper

  def link_to_semester_meeting_cards
     link_to("ocenami semestralnymi", meeting_cards_teacher_students_path + ".pdf?show_semester=1")
  end

  def link_to_meeting_cards
     link_to(image_tag("filetype_pdf.png") + "Kartki z ocenami cząstkowymi", meeting_cards_teacher_students_path + ".pdf")
  end

  def links_to_meeting_cards
    link_to_meeting_cards + " / " + link_to_semester_meeting_cards
  end

end
