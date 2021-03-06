put '/comments/:comment_id/votes' do
  return redirect back if !logged_in?
  # finds the comment and passes it to the helper
  comment = Comment.find_by(id: params[:comment_id])
  #thank you helpy helperton.
  vote_request(comment)
end

put '/answers/:answer_id/votes' do
  return redirect back if !logged_in?
  answer = Answer.find_by(id: params[:answer_id])

  vote_request(answer)
end

put '/questions/:question_id/votes' do
  # design choice: should we redirect user to login page if they try this path?
  return redirect back if !logged_in?
  question = Question.find_by(id: params[:question_id])

  vote_request(question)
end
