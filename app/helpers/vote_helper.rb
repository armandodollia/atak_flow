helpers do
  def update_vote(votable)
    # looks at the votable object passed and either returns the previopus vote made by the logged in user or creates one
    vote = votable.votes.find_or_initialize_by(user_id: session[:user_id].to_i)
    vote.value = params[:value].to_i
    vote.save!
  end
end