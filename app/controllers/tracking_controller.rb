class TrackingController < ApplicationController
  def show
    @tracking = Tracking.find(params[:id])
  end
end
