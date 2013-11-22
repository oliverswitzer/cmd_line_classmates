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
    all_the_h3s = @html.search("h3").to_s.gsub(" ", "*").gsub("</h3>", "<h3>").gsub("<h3>", " ").split
    all_the_h3s.collect do |name|
      name.gsub("*", " ")
    end
  end

  def get_student_twitter
    all_the_social_ul = @html.search("ul.social")
    regex = /(@\w+\b)/
    twitter_handles_and_other_crap = all_the_social_ul.text.gsub(/\s+/, " ").scan(regex).flatten
  end

  def get_students_blogs
    #href attribute <html element attributes (=)
    
    blog_url = html.search("ul.social a.blog")
    blog_url_array = []
    
    debugger
    blog_url.each do |index|
            blog_url_array << index["href"]
            debugger
    end
    debugger
    blog_url_array
  end


  def get_names_3
    face = html.search(".student .card")
    students = []
    face.collect do |element|
      students << element.text
    end
    debugger
    puts "asdfas"
  end


  def get_names_2
    facefront = html.search(".student .front")
    students = []
    facefront.collect do |element|
      students << element.text.gsub("\n", " ").strip
    end
    debugger
    puts "asdfas"
  end

end

my_scraper = Scraper.new("http://flatironschool-bk.herokuapp.com/")

# p my_scraper.get_students_names
# puts
# puts "-" *50
# p my_scraper.get_student_twitter
# puts 
# puts "-" *50
my_scraper.get_names_3
# p my_scraper.get_students_blogs
