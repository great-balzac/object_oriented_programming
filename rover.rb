class Rover
  attr_accessor :xstart, :ystart, :dir, :cs
  def initialize(params = {})
    @xstart = params.fetch(:xstart)
    @ystart = params.fetch(:ystart)
    @dir = params.fetch(:dir)
    @cs = params.fetch(:cs)
    puts "Rover callsign #{@cs.upcase} initialized at starting position:\nx = #{@xstart}, y = #{@ystart}, bearing = #{@dir}."
  end

# Define rover behaviours.

  def readinst
  end

  def move
  end

  def turn
  end

end

# ACCEPT ROVER INSTRUCTIONS
# =========================

# First line of input: define plateau size
  puts "Define plateau size (x y)"
  puts "Example: 10 10"
  puts "========================="
  gridsize = gets.chomp
# Splits input into x and y co-ords and puts into a hash.
  gridsize = gridsize.split(" ",)
  plateau = {:xmax => 0, :ymax => 0}
  plateau[:xmax] = gridsize[0]
  plateau[:ymax] = gridsize[1]
  puts "Gridsize set at x = #{plateau[:xmax]}, y = #{plateau[:ymax]}."

# ROVER ALPHA
# ===========
#   Second & Third lines of input:
#   Define initial start pos'n & header
#   Define sequence of turn and advance
  puts "ROVER ALPHA:"
  puts "Define start position and header (x y direction)"
  puts "Example: 5 3 N"
  puts "================================================"
  roverstart = gets.chomp

# Splits input into x and y and direction and puts into a hash.

  roverstart = roverstart.split(" ",)
  alpha = { 
    :xstart => roverstart[0],
    :ystart => roverstart[1],
    :dir => roverstart[2],
    :cs => "ALPHA"
  }

# Display input for rover position.
  puts ""
  puts "Rover #{alpha[:cs]} start position: x = #{alpha[:xstart]}, y = #{alpha[:ystart]}, bearing = #{alpha[:dir]}."
  puts ""

# Accept rover movements.
  puts "Define sequence of rover movements (L/R/M)"
  puts "Example: LMRMRMMMLMRM"
  puts "=========================================="

  alphamove = gets.chomp
# Splits input into an array of movement sequences.
  alphamove.upcase!
  alphamove = alphamove.split("",)
  puts ""
  print "#{alpha[:cs]} rover movements sequenced: "
  alphamove.each {
    |x|
    print x
  }
  puts ""
  puts ""

# ROVER BRAVO
# ===========
#   Second & Third lines of input:
#   Define initial start pos'n & header
#   Define sequence of turn and advance

  puts "ROVER BRAVO:"
  puts "Define start position and header (x y direction)"
  puts "Example: 5 3 N"
  puts "================================================"
  roverstart = gets.chomp

# Splits input into x and y and direction and puts into a hash.

  roverstart = roverstart.split(" ",)
  bravo = {
    :xstart => roverstart[0],
    :ystart => roverstart[1],
    :dir => roverstart[2],
    :cs => "BRAVO",
  }

# Display input for rover position.

  puts ""
  puts "Rover #{bravo[:cs]} start position: x = #{bravo[:xstart]}, y = #{bravo[:ystart]}, bearing = #{bravo[:dir]}."
  puts ""

# Accept rover movements.
  puts "Define sequence of rover movements (L/R/M)"
  puts "Example: LMRMRMMMLMRM"
  puts "=========================================="

  bravomove = gets.chomp
# Splits input into an array of movement sequences.
  bravomove.upcase!
  bravomove = bravomove.split("",)
  puts ""
  print "#{bravo[:cs]} rover movements sequenced: "
  bravomove.each {
    |x|
    print x
  }
  puts ""
  puts ""
  
# Test initialization of rover data.
  csa = Rover.new(alpha)
  csb = Rover.new(bravo)
  