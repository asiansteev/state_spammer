begin
  require 'launchy'

  class Mechanize::Page
    def open_in_browser
      if body
        file = File.new("/tmp/#{Time.now.to_i}.html", 'w')
        file.write body
        Launchy.open "file://#{file.path}"
        system "sleep 2 && rm #{file.path} &"
      end
    end
  end
rescue LoadError
end
