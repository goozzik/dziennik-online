module HelperMethods
  # Put helper methods you need to be available in all acceptance specs here.

  def assert_alert_box(alert)
    page.should have_xpath "//div[@class='alert fade in']"
    page.should have_xpath "//h4[@class='alert-heading'][contains(text(), '#{alert}')]"
  end

  def assert_info_box(info)
    page.should have_xpath "//div[@class='alert alert-info fade in']"
    page.should have_xpath "//h4[@class='alert-heading'][contains(text(), '#{info}')]"
  end

  def assert_page_header(header)
    page.should have_xpath "//div[@class='page-header']/h1[contains(text(), '#{header}')]"
  end

  def reload_page
    visit(current_path)
  end

end

RSpec.configuration.include HelperMethods, :type => :acceptance
