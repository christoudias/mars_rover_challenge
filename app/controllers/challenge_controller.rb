class ChallengeController < ActionController::Base

  def index
    if request.post?
      trans = request[:transmission]

      @response = Mars::Communication.new(trans).send_transmission

    end




    render 'index', :layout => 'layouts/application'
  end

end