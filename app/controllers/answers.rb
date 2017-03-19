get '/answers/:answer_id/comments' do
  @answer = Answer.find(params[:answer_id])
  @path = "/questions/#{@answer.id}/comments/new"
  @comments = @answer.comments
  if request.xhr?
    erb :'/comments/_index', locals: {comments: @comments}, layout: false
  else
    erb :'/comments/index'
  end
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
  new_comment = Answer.find(params[:answer_id]).comments.new(body: params[:body], user_id: current_user.id)
   if new_comment.save
    redirect "/questions/#{params[:answer_id]}"
  else
    @errors = ["Body cannot be blankeroonie"]
    erb :'/comments/new'
  end
end
