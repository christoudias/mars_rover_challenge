#############################################
#  Mars::Rover - Takes a rovers transmission and moves the rover. Returns the final position and orientation
#  CGC 5/26/2017
#
#
#############################################

module Mars


  class Rover

    def initialize(maxx = 0, maxy =0, rover = ["",""])
      first_line = rover.first.split(" ")
      @instructions = rover.last
      @orientation = first_line.last
      @positionx = first_line.first.to_i
      @positiony = first_line[1].to_i
      @maxx = maxx
      @maxy = maxy
    end

    def response
      "#{@positionx} #{@positiony} #{@orientation}"
    end

    def run
      @instructions.split("").each do |i|
        move(i)
      end
      response
    end

    def move(instruction)
      case instruction
        when "M"
          advance
        when "R"
          turn_right
        when "L"
          turn_left
      end
    end


    def turn_right
      case @orientation
        when "N"
          @orientation = "E"
        when "E"
          @orientation = "S"
        when "S"
          @orientation = "W"
        when "W"
          @orientation = "N"
      end
    end


    def turn_left
      case @orientation
        when "N"
          @orientation = "W"
        when "W"
          @orientation = "S"
        when "S"
          @orientation = "E"
        when "E"
          @orientation = "N"
      end
    end


    def advance
      case @orientation
        when "N"
          @positiony += 1 unless @positiony >= @maxy
        when "W"
          @positionx -= 1 unless @positionx <= 0
        when "S"
          @positiony -= 1 unless @positiony <= 0
        when "E"
          @positionx += 1 unless @positionx >= @maxx

      end
    end


  end


end