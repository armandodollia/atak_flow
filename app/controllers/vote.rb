put '/comments/:comment_id/votes' do
  return redirect back if !logged_in?
  # finds the comment and passes it to the helper
  update_vote(Comment.find_by(id: params[:comment_id].to_i))

  redirect back
  end

put '/answers/:answer_id/votes' do
  return redirect back if !logged_in?
  update_vote(Answer.find_by(id: params[:answer_id].to_i))

  redirect back
end

put '/questions/:question_id/votes' do
  return redirect back if !logged_in?
  update_vote(Question.find_by(id: params[:question_id].to_i))
  
  redirect back
end