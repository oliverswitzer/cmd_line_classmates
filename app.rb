require './lib/*'  #require everything in the library folder

# # 1. make a new scraper
# my_scrapper = Scraper.new()
# # 2. get student names from the scraper
# names = my_scrapper.get_student_names
# # 3. get the blogs
# # 4. get the twitter
# # 5. make a new student object for each one

student_scraper = Scraper.new("http://flatironschool-bk.herokuapp.com/")

names = student_scraper.get_student_names
twitters = student_scraper.get_twitter
blogs = student_scraper.get_blogs

students = []

28.times do |i|
  students << Student.new(name[i], twitters[i], blogs[i])
end

puts students