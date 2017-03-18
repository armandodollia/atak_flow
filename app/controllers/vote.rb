post '/comments/:comment_id/votes' do
  update_vote(Comment.find_by(id: params[:comment_id].to_i))

  redirect back
  end

post '/answers/:answer_id/votes' do
  update_vote(Answer.find_by(id: params[:answer_id].to_i))

  redirect back
end

post '/questions/:question_id/votes' do
  update_vote(Question.find_by(id: params[:question_id].to_i))
  
  redirect back
end