module Mars
  class Communication


    def initialize(transmission = nil)
      @transmission = transmission
      @transmission_errors = []
    end


    def validate_transmission
      cleanup_transmission
      validate_total_lines
      validate_plateau
      if !@transmission_errors.present?

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
        @transmission_errors << "There should be an odd number of lines."
      end
    end


    def validate_plateau
      plateau = @transmission[0].split(" ")
      if plateau.size != 2
        @transmission_errors << "First line should have two values representing the X and Y of the plateau."
      else
        if !((Integer(plateau[0]) rescue nil) and (Integer(plateau[1]) rescue nil))
          @transmission_errors << "First line should have numbers for first two values."
        end
      end
    end

    
    def validate_instructions

    end




    def send_transmission
      if validate_transmission
        "GOOD Transmission"
      else
        "TRANSMISSION FAILURE: #{@transmission_errors.join(",")}"
      end


    end



  end
end