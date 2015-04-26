class Student
  attr_reader :firstname, :lastname, :courses

  def initialize(firstname, lastname)
    @firstname, @lastname = firstname.capitalize, lastname.capitalize
    @courses = []
  end

  def name
    "#{firstname} #{lastname}"
  end

  def enroll(course)
    return if courses.include?(course)
    unless has_conflict?(course)
      @courses << course
      course.add_student(self)
    end
  end

  def has_conflict?(course2)
    courses.any? { |course| course2.conflicts_with?(course) }
  end

  def course_load
    cl = Hash.new(0)
    @courses.each { |course| cl[course.dept] += course.credits }
    cl
  end

end

class Course
  attr_reader :name, :dept, :credits, :time_block, :days, :students

  def initialize(name, dept, credits, time_block, days)
    @name, @dept, @credits, @time_block, @days = 
      name, dept, Integer(credits), Integer(time_block), days
    @students = []
  end

  def add_student(student)
    @students << student
  end

  def conflicts_with?(course2)
    time_block == course2.time_block && 
      (days.any? { |day| course2.days.include?(day) })
  end
end
