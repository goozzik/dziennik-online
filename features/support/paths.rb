module NavigationHelpers
  def path_to(page_name)
    the_host +
    case page_name
    
    when /a page/
      ''
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end

  def the_host
    ENV["PRODUCTION_TEST"].nil? ? "http://development_host:3000" : "http://production_host"
  end

end

World(NavigationHelpers)
