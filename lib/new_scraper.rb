#new_scraper.rb
require 'open-uri'  #supplies open() method to open a URL
require 'nokogiri' 
require 'debugger'


class Scraper
  attr_reader :html

  def initialize(url)
    download = open(url)
    @html = Nokogiri::HTML(download)
  end

  def get_students_names
    html.search("h3").collect { |h3| h3.text }
  end


  def get_student_twitter
  student_html = html.search(".student")
    twitter_url_array = []
    student_html.each do |twitter_almost|
      if twitter_almost.search(".twitter")[0].nil?
        twitter_url_array << "none"
      else
        twitter_url_array << twitter_almost.search(".twitter")[0]["href"]
      end        
    end
    twitter_url_array
  end

  def get_students_blogs
    student_html = html.search(".student")
    blog_url_array = []
    student_html.each do |blog_almost|
      if blog_almost.search(".blog")[0].nil?
        blog_url_array << "none"
      else
        blog_url_array << blog_almost.search(".blog")[0]["href"]
      end        
    end
    blog_url_array
  end

end

   

# my_scraper = Scraper.new("http://flatironschool-bk.herokuapp.com/")
# puts my_scraper.get_student_twitter
# puts my_scraper.get_students_names
# puts my_scraper.get_students_blogs
