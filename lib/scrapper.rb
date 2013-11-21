#require the libraries that we need

require 'open-uri'  #supplies open() method to open a URL
require 'nokogiri'  #line12 --
require 'debugger'

class Scraper
  attr_reader :html

  def initialize(url)
    download = open(url)
    @html = Nokogiri::HTML(download)
  end

  def get_students_names
    all_the_h3s = @html.search("h3")
  end

  def get_student_twitter
    all_the_social_ul = @html.search("ul.social")
    regex = /(@\w+\b)/
    twitter_handles_and_other_crap = all_the_social_ul.text.gsub(/\s+/, " ").scan(regex).flatten
  end

  def get_student_blogs
  end

end

my_scraper = Scraper.new("http://flatironschool-bk.herokuapp.com/")

puts my_scraper.get_students_names   

p my_scraper.get_student_twitter
