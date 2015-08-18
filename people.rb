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


class Person

	def initialize
		attr_accessor :name
	end

	def greeting
		puts "Hi, my name is #{@name}!"
	end

end
