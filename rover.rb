class Rover
  attr_accessor :xstart, :ystart, :dir, :cs
  def initialize(params = {}, moves)
    @xstart = params.fetch(:xstart)
    @ystart = params.fetch(:ystart)
    @dir = params.fetch(:dir)
    @cs = params.fetch(:cs)

    puts "Initializing rover #{@cs}:"
    puts "Starting position:\nx = #{@xstart}, y = #{@ystart}, bearing = #{@dir}."
    
    @moves = moves
    puts "Movement sequence: #{@moves}" 
    puts ""
    puts "#{@cs} rover is moving:"

    # Sets bearing from user defined direction
    @bearing = 0
    if @dir == "N"
      @bearing = 0
    elsif @dir == "E"
      @bearing = 1600
    elsif @dir == "S"
      @bearing = 3200
    elsif @dir == "W"
      @bearing = 4800
    end

    @x = @xstart.to_i
    @y = @ystart.to_i

  end


  def move
    if @bearing == 0
      @y += 1
      puts "Advances 1 move North"
    elsif @bearing == 1600
      @x += 1
      puts "Advances 1 move East"
    elsif @bearing == 3200
      @y -= 1
      puts "Advances 1 move South"
    elsif @bearing == 4800
      @x -= 1
      puts "Advances 1 move West"
    end
  end

  def turn(wheel)
    # Detects if rover faces North
    if wheel == "L" && @bearing == 0
      @bearing = 4800
      puts "Turns #{wheel} to bearing #{@bearing}"
    # Detects if rover faces other than North
    elsif wheel == "L" && @bearing >= 1600
      @bearing -= 1600
      puts "Turns #{wheel} to bearing #{@bearing}"
    # Detects if rover faces West
    elsif wheel == "R" && @bearing == 4800
      @bearing = 0
      puts "Turns #{wheel} to bearing #{@bearing}"
    elsif wheel == "R" && @bearing <= 4800
      @bearing += 1600
      puts "Turns #{wheel} to bearing #{@bearing}"
    end

  end

  def read_instruction

    @moves.each {
      |order|

      self.mission_control
      if order == "L"
        self.turn("L")
      elsif order == "R"
        self.turn("R")
      elsif order == "M"
        self.move
      end
    }

    self.mission_report
  end

  def mission_control

    # Determines whether rover left the plateau
    @off = false
    if @x < 0
      @off = true
    elsif @x > $plateau[:xmax].to_i
      @off = true
    elsif @y < 0
      @off = true
    elsif @y > $plateau[:ymax].to_i
      @off = true
    else
      @off = false
    end

    if @off == true
      puts "Rover #{@cs} is off of the plateau!"
    else
    end
  end

 #++++++++++++++++++++++++++++++++++
  def grid_draw
  @ygrid = []
  @yline = ""
  dash = "--|"
  drawline = ""
  chunk = "--|"
  leftof = ""
  rightof = ""

  if @cs == "ALPHA"
    rovericon = "RA|"
  elsif @cs == "BRAVO"
    rovericon = "RB|"
  end


 # Create Y index
    0.upto($plateau[:ymax].to_i) {
      |num|
      @ygrid << num
    }

# Creates Y line X grid spaces wide
    0.upto($plateau[:xmax].to_i) {
      |num|
      @yline += dash
    }

    @ygrid = @ygrid.reverse

    @ygrid.each {
      |num|
      numstr = " "
      
        if num < 10
          numstr += num.to_s
          else numstr = num.to_s
        end

        if num == @y
         @x.times {
           |x|
           leftof += chunk
          }

         ($plateau[:ymax].to_i - @x).times {
           |x|
           rightof += chunk
          }

         drawline = numstr + leftof + rovericon + rightof
         puts drawline

        else
         drawline = numstr << @yline
         puts drawline
        end 
      }

# Sets array for X index
    @xgrid = []
      0.upto($plateau[:xmax].to_i) {
      |num|
      @xgrid << num
    }

# Set spacer
    space = " "
    print space
# Writes X index
    @xgrid.each {
      |num|
      numstr = ""
  
      if num < 10
        numstr = space + num.to_s + space
      else numstr = space + num.to_s
      end
    print numstr
    }
    puts ""
  end

 #++++++++++++++++++++++++++++++++++

  def mission_report
   # Determines final direction from last bearing
    @fdir = ""
    if @bearing == 0
      @fdir = "N"
    elsif @bearing == 1600
      @fdir = "E"
    elsif @bearing == 3200
      @fdir = "S"
    elsif @bearing == 4800
      @fdir = "W"
    end

    # Displays final position of rover
    self.grid_draw
    puts "#{@cs} rover final position: x = #{@x}, y = #{@y}, bearing = #{@bearing} #{@fdir}."
    self.mission_control
    puts "*** #{@cs} ROVER MISSION COMPLETE ***"
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
  $plateau = {:xmax => 0, :ymax => 0}
  $plateau[:xmax] = gridsize[0]
  $plateau[:ymax] = gridsize[1]
  puts "Gridsize set at x = #{$plateau[:xmax]}, y = #{$plateau[:ymax]}."
  puts ""

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

# Sends rovers on their Mission!
  Rover.new(alpha, alphamove).read_instruction
  Rover.new(bravo, bravomove).read_instruction
