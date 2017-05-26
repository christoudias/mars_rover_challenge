#############################################
#  Mars::Communication - Takes a transmission, validates it and sends it to a group of rovers
#  CGC 5/26/2017
#
#
#############################################


module Mars
  class Communication


    def initialize(transmission = nil)
      @transmission = transmission
      @transmission_errors = []
      @rovers = [] # array of rover transmissions. Each rover transmission is an array of 2
      @orientations = ["N", "E", "W", "S"]
      @moves = ["M", "L", "R"]
      @response = [] # the response from the rovers.
      @maxx = 0
      @maxy = 0
    end


    def validate_transmission
      cleanup_transmission
      validate_total_lines
      validate_plateau

      # At this point in validation, we can ignore the first line and parse the rest of the array in to subarray pairs
      # We store the array pairs in the @rovers array
      if !@transmission_errors.present?
        rovers_t = @transmission
        rovers_t.delete_at(0)
        @rovers = rovers_t.each_slice(2).to_a
        @rovers.each do |rover|
          validate_rover(rover)
        end

      end
      !@transmission_errors.present?
    end



    def cleanup_transmission
      @transmission = @transmission.split("\n")
      @transmission.each_with_index  do |t, index|
        @transmission[index] = t.strip # remove trailing or leading spaces
      end
      @transmission.delete("") # remove any blank lines
    end


    def validate_total_lines
      if @transmission.size % 2 != 1
        @transmission_errors << "There should be an odd number of lines"
      end
    end


    def validate_plateau
      plateau = @transmission[0].split(" ")
      if plateau.size != 2
        @transmission_errors << "First line should have two values representing the X and Y of the plateau"
      elsif !((Integer(plateau[0]) rescue nil) and (Integer(plateau[1]) rescue nil))
        @transmission_errors << "First line should have numbers for first two values"
      else
        @maxx = plateau.first.to_i
        @maxy = plateau.last.to_i
      end
    end


    # validates the instructions sent to each rover.
    def validate_rover(rover_transmission = [])
      if rover_transmission.size != 2
        @transmission_errors << "#{rover_transmission.to_s} should be two lines"
      else
        first_line = rover_transmission.first.split(" ")
        if first_line.size != 3
          @transmission_errors << "First line of #{rover_transmission.to_s} should have three entries"
        elsif !(Integer(first_line.first) rescue nil) and (Integer(first_line[1]) rescue nil)
          @transmission_errors << "First two entries of #{rover_transmission.first.to_s} should be integers"
        else
          startx = Integer(first_line.first)
          starty = Integer(first_line[1])
          if startx > @maxx or startx < 0 or starty > @maxy or starty < 0
            @transmission_errors << "Starting position of #{rover_transmission.first.to_s} must be in bounds."
          end
          if !@orientations.include?(first_line.last)
            @transmission_errors << "Last entry of #{rover_transmission.first.to_s} should be a direction"
          end
          #@transmission_errors << "#{rover_transmission[1].gsub("M", "")}"
          if rover_transmission.last.gsub("M", "").gsub("R","").gsub("L", "").size > 0
            @transmission_errors << "#{rover_transmission.last.to_s} should only contain L, M, or R characters"
          end
        end
      end
    end


    def send_to_rovers
      @rovers.each do |rover|
        @response << Mars::Rover.new(@maxx, @maxy, rover).run
      end


    end


    def send_transmission
      if validate_transmission
        send_to_rovers
        @response.join("\n")
      else
        "TRANSMISSION FAILURE: #{@transmission_errors.join(",")}"
      end
    end



  end
end