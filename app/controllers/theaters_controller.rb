class TheatersController < ApplicationController
  def search
    latitude = params[:latitude]
    longitude = params[:longitude]
  
    @places = Theater.all.within(10, origin: [latitude, longitude])
  end
end
