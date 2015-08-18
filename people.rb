class Person
  attr_accessor :name

	def greeting
		puts "Hi, my name is #{@name}!"
	end

end

class Student < Person

  def learn
  	puts "I get it!"
  end

end


class Instructor < Person

  def teach
  	puts "Everything in Ruby is an object."
  end

end


# Create an instance of an instructor named Chris.
chris = Instructor.new
chris.name = "Chris"
chris.greeting

# Create an instance of a student named Cristina.
cristina = Student.new
cristina.name = "Cristina"
cristina.greeting

# Call the teach method on Chris and the learn method
# on Cristina.
chris.teach
cristina.learn

