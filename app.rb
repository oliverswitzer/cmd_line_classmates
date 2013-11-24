require './lib/new_scraper'  #require everything in the library folder
require './lib/student'
require 'launchy'


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
  students << Student.new(names[i], twitters[i], blogs[i])
end


def display_info(student)
  puts student.name
  puts "  Blog: #{student.blog}"
  puts "  Twitter: #{student.twitter}"
  puts "+" * 40
end


puts "Options:"
puts "  To see all students and their blogs type 'l'"
puts "  To open a random student's twitter type 't'"
puts "  To open a random student's blog type 'b'"
puts "  To get the information of a specific student, type their first name"
i = gets.chomp.downcase

if i == 'l'
  students.each do |student|
    display_info(student)
  end
elsif i == 't'
  running = true
  while running
    rand_student = students.sample
    if rand_student.twitter != 'none'
      Launchy.open("#{rand_student.twitter}")
      running = false
    end
  end
elsif i == 'b'
  running = true
  while running
    rand_student = students.sample
    if rand_student.blog != 'none'
        Launchy.open("#{rand_student.twitter}")
        running = false
    end
  end
  rand_student = students.sample
  Launchy.open("#{rand_student.blog}")
else
  students.each do |student|
    m = /^\w+\b/.match(student.name)
    if m[0].downcase == i
      puts "+" * 40
      display_info(student)
      puts "Would you like to visit their twitter or blog?\n  Type 't' for their twitter and 'b' for their blog"
      inp = gets.chomp.downcase
      case inp
      when 't'
        Launchy.open("#{student.twitter}")
      when 'b' 
        Launchy.open("#{student.blog}")
      end
    end
  end
end