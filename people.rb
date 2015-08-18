class Student < Person

  def learn
  	"I get it!"
  end

end


class Instructor < Person

  def teach
  	"Everything in Ruby is an object."
  end

end


class Person

	def initialize
		attr_accessor :name
	end

end
