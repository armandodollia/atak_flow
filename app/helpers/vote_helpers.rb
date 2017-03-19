helpers do
  def update_vote(votables)
    # looks at the votable object passed and either returns the previopus vote made by the logged in user or creates one
    vote = votables.votes.find_or_initialize_by(user_id: session[:user_id].to_i)
    vote.value = params[:value].to_i
    vote.save!
  end
  
  def vote_request(votable)
    update_vote(votable)
  
    if request.xhr?
      content_type :json
      { points: points(votable).to_s}.to_json
    else
      redirect back
    end
  end
end