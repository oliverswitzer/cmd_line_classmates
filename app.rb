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

class StudentApp
  attr_accessor :students 

  def initialize url 
    student_scraper = Scraper.new(url)

    names = student_scraper.get_students_names
    twitters = student_scraper.get_student_twitter
    blogs = student_scraper.get_students_blogs
    @students = []

    28.times do |i|
      @students << Student.new(names[i], twitters[i], blogs[i])
    end
  end

  def usr_inp_filter i
    pass = true
    possible_inputs = ["l", "t", "b"]
    if i.length == 1
      if not possible_inputs.include?(i)
        puts "You're not entering the right letter"
        pass = false
      end
    end
    pass
  end

  def display_info student
    puts student.name
    puts "  Blog: #{student.blog}"
    puts "  Twitter: #{student.twitter}"
    puts "+" * 40
  end

  def greeting
    puts "Options:"
    puts "  To see all students and their blogs type 'l'"
    puts "  To open a random student's twitter type 't'"
    puts "  To open a random student's blog type 'b'"
    puts "  To get the information of a specific student, type their first name"
    i = gets.chomp.downcase
    return i
  end

  def list_student i
    if i == 'l'
      students.each { |student| display_info(student) }
    end
  end

  def random_twitter i 
    if i == 't'
      running = true
      while running
        rand_student = students.sample
        if rand_student.twitter != 'none'
          Launchy.open("#{rand_student.twitter}")
          running = false
        end
      end
    end
  end

  def random_blog i
    if i == 'b'
      running = true
      while running
        rand_student = students.sample
        if rand_student.blog != 'none'
            Launchy.open("#{rand_student.blog}")
            running = false
        end
      end
    end
  end

  def name_lookup i
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
      else 
        "The name you entered didn't return a match! Try again"
      end
    end
  end 

  def run
    inp = greeting
    filter = usr_inp_filter(inp)
    unless filter
      until filter
        inp = greeting
        filter = usr_inp_filter(inp)
      end
    end

    list_student(inp)
    random_twitter(inp)
    random_blog(inp)
    name_lookup(inp)
  end
end


app = StudentApp.new("http://flatironschool-bk.herokuapp.com/")

app.run