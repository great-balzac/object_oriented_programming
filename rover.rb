# UPDATED CODE

class Mission
  attr_accessor :rover_on_mission, :current_grid, :mission_name

  def initialize(rover_on_mission, current_grid)
    @rover_on_mission = rover_on_mission
    @current_grid = current_grid
  end
  
  def name(mission_name)
    @mission_name = mission_name.upcase
  end

  def mission_execute
   
    @rover_on_mission.rover_movts.each {
      |order|

      # self.mission_control  <------ to detect if rover goes off plataeu
      if order == "L"
        @rover_on_mission.turn("L")
      elsif order == "R"
        @rover_on_mission.turn("R")
      elsif order == "M"
        @rover_on_mission.move
      end

      self.mission_control
    }

    self.mission_report

  end # mission_execute

  def mission_report
  
    @current_grid.draw_grid(@rover_on_mission)
    # GENERATE REPORT
    puts "#{@mission_name} is complete!"
    puts "Final rover position:"
    puts "X: #{@rover_on_mission.rover_compass[:current_x]}, Y: #{@rover_on_mission.rover_compass[:current_y]}."

  end # mission_report

  def mission_control

    @off_grid = false
    if @rover_on_mission.rover_compass[:current_x] < 0
     @off_grid = true
     elsif @rover_on_mission.rover_compass[:current_x] > @current_grid.xmax
     @off_grid = true
     elsif @rover_on_mission.rover_compass[:current_y] < 0
      @off_grid = true
     elsif @rover_on_mission.rover_compass[:current_y] > @current_grid.ymax
      @off_grid = true
     else
      @off_grid = false
    end

    if @off_grid == true
      puts "ALERT!!! Rover #{@rover_on_mission.rover_name} is off of the plateau!"
    else
    end

  end # mission_control

end # Mission class


class Rover

  attr_accessor :rover_name, :start_x, :start_y,
  :start_heading, :rover_movts, :rover_compass, :cs

  def initialize(rover_name, cs)
    @rover_name = rover_name.upcase
    @cs = cs.upcase
  end # initialize

  def starting_posn(start_x, start_y, start_heading)
    @start_x = start_x.to_i
    @start_y = start_y.to_i
    @start_heading = start_heading.upcase

    @rover_compass = {}

    @rover_compass[:current_heading] = @start_heading.upcase

    if @start_heading == "N"
      @rover_compass[:bearing] = 0
    elsif @start_heading == "E"
      @rover_compass[:bearing] = 1600
    elsif @start_heading == "S"
      @rover_compass[:bearing] = 3200
    elsif @start_heading == "W"
      @rover_compass[:bearing] = 4800
    end

    @rover_compass[:current_x] = @start_x
    @rover_compass[:current_y] = @start_y

  end

  def movt_seq(rover_movts)
    @rover_movts = rover_movts.upcase
    @rover_movts = @rover_movts.split("",)
  end

  def move

    if @rover_compass[:bearing] == 0
      @rover_compass[:current_y] += 1
      puts "Advances 1 move North"
    elsif @rover_compass[:bearing] == 1600
      @rover_compass[:current_x] += 1
      puts "Advances 1 move East"
    elsif @rover_compass[:bearing] == 3200
      @rover_compass[:current_y] -= 1
      puts "Advances 1 move South"
    elsif @rover_compass[:bearing] == 4800
      @rover_compass[:current_x] -= 1
      puts "Advances 1 move West"
    end

  end # move

  def turn(wheel)
    
    # Detects if rover faces North for left calculation
    if wheel == "L" && @rover_compass[:bearing] == 0
      @rover_compass[:bearing] = 4800
      puts "Turns #{wheel} to bearing #{@rover_compass[:bearing]}"
    # Detects if rover faces other than North for left calculation
    elsif wheel == "L" && @rover_compass[:bearing] >= 1600
      @rover_compass[:bearing] -= 1600
      puts "Turns #{wheel} to bearing #{@rover_compass[:bearing]}"
    # Detects if rover faces West for right calculation
    elsif wheel == "R" && @rover_compass[:bearing] == 4800
      @rover_compass[:bearing] = 0
      puts "Turns #{wheel} to bearing #{@rover_compass[:bearing]}"
    elsif wheel == "R" && rover_compass[:bearing] < 4800
      @rover_compass[:bearing] += 1600
      puts "Turns #{wheel} to bearing #{@rover_compass[:bearing]}"
    end

  end # wheel

end # Rover class

class Grid

  attr_accessor :xmax, :ymax, :grid_name

  def set_size(xmax, ymax)
  @xmax = xmax.to_i
  @ymax = ymax.to_i

  @map_array = []

  # Inserts empty arrays representing Y index lines into main map array
  0.upto(@ymax) do
    |y_index|
      y_index = y_index.to_i # Not sure if I need this here
      y_index = Array.new
      @map_array << y_index
  end # Inserting empty arrays into map

  # Inserts string representing empty grid cells into each Y index line
  @map_array.each do
    |x_index|
      0.upto(@xmax) do
        x_index << "|--|"
      end
  end

  end # set_size

  def name(grid_name)
    @grid_name = grid_name.capitalize
  end

  def draw_grid(rover_reference)
    @width_of_grid = self.xmax
    @height_of_grid = self.ymax
    @rover_reference = rover_reference

    # Mark grid with rover icon
    final_rover_x = @rover_reference.rover_compass[:current_x]
    final_rover_y = @rover_reference.rover_compass[:current_y]

    # Insert rover icon onto appropriate array within the map array
    counter = @height_of_grid
    @map_array.each do
      |array_select|
          if counter == final_rover_y
          array_select.delete_at(final_rover_x)
          array_select.insert(final_rover_x, @rover_reference.cs)
        else
        end
      counter -= 1
    end # Marking of grid

    # Start drawing lines

    counter = @height_of_grid
    @map_array.each do
      |y_line|
        # Detects if y_index needs a 0 in front of single digit
        
        if counter == 0
          print "Y" + counter.to_s
        elsif counter.to_s.length == 1
          print "0" + counter.to_s
        else
          print counter.to_s
        end

        y_line.each do
          |x_line|
          print x_line # Prints x_line across y index
        end
        puts "\n"
        counter -= 1 # Tracks y_index
    end # grid lines

    # Print X index numbers
    counter = 0
    print "  "
    0.upto(@width_of_grid)do
      |index_num|
        if counter == 0
          print "|X0|"
        elsif counter > 0 && counter.to_s.length == 1
          print "|0" + counter.to_s + "|"
        else
          print "|" + counter.to_s + "|"
        end
      counter += 1
    end
    puts "\n"
  end # end draw_grid


end # Grid class


# ACCEPT ROVER INSTRUCTIONS
# =========================

# First line of input: define plateau size
  puts "Define plateau size (x y)"
  puts "Example: 10 10"
  puts "========================="
  puts "X: "
  gridx = gets.chomp
  puts "Y: "
  gridy = gets.chomp

  plateau = Grid.new
  plateau.set_size(gridx, gridy)
  plateau.name("North Pole of Mars")

# ROVER ALPHA
# ===========
#   Second & Third lines of input:
#   Define initial start pos'n & header
#   Define sequence of turn and advance
  puts "ROVER ALPHA:"
  puts "Define start position and header (x y direction)"
  puts "Example: 5 3 N"
  puts "================================================"
  rover_start_x = gets.chomp
  rover_start_y = gets.chomp
  rover_start_heading = gets.chomp

# Accept rover movements.
  puts "Define sequence of rover movements (L/R/M)"
  puts "Example: LMRMRMMMLMRM"
  puts "=========================================="
  alphamove = gets.chomp

  cs_alpha = Rover.new("alpha", "|RA|")
  cs_alpha.starting_posn(rover_start_x, rover_start_y, rover_start_heading)
  cs_alpha.movt_seq(alphamove)


# Sends rovers on their Mission!
  mission_alpha = Mission.new(cs_alpha, plateau)
  mission_alpha.name("Mission 1: Alpha")
  mission_alpha.mission_execute

# ROVER BRAVO
# ===========
#   Second & Third lines of input:
#   Define initial start pos'n & header
#   Define sequence of turn and advance
  puts "ROVER BRAVO:"
  puts "Define start position and header (x y direction)"
  puts "Example: 5 3 N"
  puts "================================================"
  rover_start_x = gets.chomp
  rover_start_y = gets.chomp
  rover_start_heading = gets.chomp

# Accept rover movements.
  puts "Define sequence of rover movements (L/R/M)"
  puts "Example: LMRMRMMMLMRM"
  puts "=========================================="
  bravomove = gets.chomp

  cs_bravo = Rover.new("bravo", "|RB|")
  cs_bravo.starting_posn(rover_start_x, rover_start_y, rover_start_heading)
  cs_bravo.movt_seq(bravomove)


# Sends rovers on their Mission!
  mission_bravo = Mission.new(cs_bravo, plateau)
  mission_bravo.name("Mission 2: Bravo")
  mission_bravo.mission_execute
