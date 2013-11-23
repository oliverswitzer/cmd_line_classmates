require './lib/new_scraper'  #require everything in the library folder
require './lib/student'

# # 1. make a new scraper
# my_scrapper = Scraper.new()
# # 2. get student names from the scraper
# names = my_scrapper.get_student_names
# # 3. get the blogs
# # 4. get the twitter
# # 5. make a new student object for each one

student_scraper = Scraper.new("http://flatironschool-bk.herokuapp.com/")

names = student_scraper.get_students_names
twitters = student_scraper.get_student_twitter
blogs = student_scraper.get_students_blogs

students = []

28.times do |i|
  students << Student.new(names[i], twitters[i], "N/A")
end



puts students.inspect


#write a scrapper that retrieves name of a pokemon from bulbapeida.com
#create a Pokemon class object, with namem and method called say_name
#create an app like this one that calls the say_name