get '/answers/:answer_id/comments' do
  @answer = Answer.find(params[:answer_id])
  @path = "/questions/#{@answer.id}/comments/new"
  @comments = @answer.comments
  erb :'/comments/index'
end

get '/answers/:answer_id/comments/new' do
  @post_path = "/answers/#{params[:answer_id]}/comments"
  if logged_in?
    erb :'/comments/new'
  else
    redirect "/sessions/new"
  end
end

post '/answers/:answer_id/comments' do
  new_comment = Comment.new(body: params[:body],
                            user_id: current_user.id,
                            commentable_id: params[:answer_id],
                            commentable_type: "Answer")

  if new_comment.save
    redirect "/answers/#{params[:answer_id]}"
  else
    @errors = ["Body cannot be blankeroonie"]
    status 422
  end
end
