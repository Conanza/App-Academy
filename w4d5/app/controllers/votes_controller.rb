class VotesController < ApplicationController
  def create
    vote = Vote.new(
      votable_id: params[:votable_id],
      votable_type: params[:votable_type],
      value: params[:value]
    )
    vote.save
    redirect_to :back
  end
end
