ENV["PGPASSWORD"] = "xxxxxxxxx"
PRODUCTION_TEST=!ENV["PRODUCTION_TEST"].nil?
if PRODUCTION_TEST
  SQL_PARAMS="-h host database"
  THE_HTTP_HOST="http_host"
  THE_HTTP_HOST_WITHOUT_PORT="http_host"
else
  SQL_PARAMS="-h db_host database"
  THE_HTTP_HOST="http_host:3000"
  THE_HTTP_HOST_WITHOUT_PORT="http_host"
end
UNAME=`uname`.strip

# RSpec
require 'rspec/expectations'

# Webrat
require 'webrat'

module Webrat #:nodoc:
  class MechanizeAdapter #:nodoc:
    def mechanize
      @mechanize ||= begin
        mechanize = Mechanize.new
        mechanize.redirect_ok = true
        mechanize
      end
    end
  end
end

require 'test/unit/assertions'
World(Test::Unit::Assertions)

Webrat.configure do |config|
  config.mode = :selenium
  config.application_framework = :external
  config.application_address = THE_HTTP_HOST_WITHOUT_PORT
  config.application_port = "80"
  config.selenium_browser_startup_timeout = "500"
end

World do
  session = Webrat::Session.new
  session.extend(Webrat::Methods)
  session.extend(Webrat::Matchers)
  session
end

# Helper method for running shell commands
def run(command, verbose = false, message = nil)
  if verbose then
    puts "#{message}"
    puts command
    result = `#{command}`
    puts result
    return result
  else
    `#{command}`
  end
end

module Webrat
  # For some reason we are getting duplicated GET params on the current_url, so monkeypatch to fix it
  class Link
    def absolute_href
      if href =~ /^\?/
        "#{@session.current_url.gsub(/\?.*/,"")}#{href}"
      elsif href !~ %r{^https?://} && (href !~ /^\//)
        "#{@session.current_url}/#{href}"
      else
        href
      end
    end
  end

  # For extra debug info we monkeypatch this in
  module Locators
    class Locator # :nodoc:
      def locate!
        locate || raise(NotFoundError.new(error_message))
      rescue Webrat::NotFoundError => e
        filepath = '/tmp/webrat_debug.html'
        File.open(filepath, "w") do |file|
          file.puts @session.send(:response_body)
        end
        #output = `echo #{@session.send(:response_body)} | lynx -stdin -dump`
        output = ""
        raise "#{e.message}\n#{output}\nURL: #{@session.current_url}\nResponse saved: #{filepath}"
        #raise "#{e.message}\n#{@session.send(:response_body).gsub(/\n/, "\n  ")}\nURL: #{@session.current_url}\nResponse saved: #{filepath}"
      end
    end
  end
end

Before do
  When "I am logged out"
  sleep 2 if PRODUCTION_TEST
end

After do
  Then "I should not see forbidden texts"
  sleep 5 if PRODUCTION_TEST
end

After('@download') do
  system('rm ~/Downloads/????????.pdf.part 2>/dev/null') if UNAME == 'Darwin'
end
