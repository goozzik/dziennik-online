# coding: utf-8
module ApplicationHelper

  def page_header(text, small = nil)
    "<div class='page-header'><h1>#{text} <small>#{small if small}</small></h1></div>".html_safe
  end

  def second_page_header(text, small = nil)
    "<div class='page-header'><h2>#{text} <small>#{small if small}</small></h2></div>".html_safe
  end

  def row_3(count)
    "<div class='row'>".html_safe if (count+1) % 3 == 1
  end

  def end_row_3(i, count)
    "</div>".html_safe if (i+1) % 3 == 0 || i+1 == count
  end

  def alert_box(header, text)
    "<div class='alert fade in'>
      <button class='close' data-dismiss='alert'>×</button>
      <h4 class='alert-heading'>#{header}</h4>
      #{text}
    </div>".html_safe
  end

  def info_box(header, text, more = nil)
    "<div class='alert alert-info fade in'>
      <a class='close' data-dismiss='alert' href='#'>×</a>
      <div class='row'>
        <div class='span6'>
          <h4 class='alert-heading'>#{header}</h4>
          #{text}
        </div>
        #{more if more}
      </div>
    </div>".html_safe
  end

  def delete_link_content
    "<i class='icon-trash icon-white'></i> Usuń".html_safe
  end

  def action?(action)
    controller.action_name =~ action
  end

end
