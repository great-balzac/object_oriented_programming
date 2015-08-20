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

  end # mission_execute

  def mission_report
  
    #@current_grid.draw_grid(@mission_name)

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
  :start_heading, :rover_movts, :rover_compass

  def initialize(rover_name)
    @rover_name = rover_name.upcase
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

  attr_accessor :xmax, :ymax, :y_index, :x_width

  def set_size(xmax, ymax)
  @xmax = xmax.to_i
  @ymax = ymax.to_i
  end # set_size

  def draw_grid(mission_to_draw)
    @mission_to_draw = mission_to_draw

    # create Y index X wide

  end # end draw_grid

  def draw_yline(y_index, x_width)


  end # draw_yline

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

  cs_alpha = Rover.new("alpha")
  cs_alpha.starting_posn(rover_start_x, rover_start_y, rover_start_heading)
  cs_alpha.movt_seq(alphamove)


# Sends rovers on their Mission!
  mission_alpha = Mission.new(cs_alpha, plateau)
  mission_alpha.name("Mission 1: Alpha")
  mission_alpha.mission_execute
