get '/answers/:answer_id/comments' do
  @answer = Answer.find(params[:answer_id])
  @comments = @answer.comments
  @path = "/answers/#{@answer.id}/comments/new"
  if request.xhr?
    erb :'/comments/_index', layout: false, locals: {comments: @comments, path: @path}
  else
    erb :'/comments/index'
  end
end

before '/answers/:answer_id/comments/new' do
  return redirect "/sessions/new" if !logged_in?
end

get '/answers/:answer_id/comments/new' do
  @post_path = "/answers/#{params[:answer_id]}/comments"
  if request.xhr?
    erb :'/comments/_new', locals: {post_path: @post_path}, layout: false
  else
    erb :'/comments/new'
  end
end

post '/answers/:answer_id/comments' do
  return redirect "/sessions/new" if !logged_in?
  new_comment = Answer.find(params[:answer_id]).comments.new(body: params[:body], user_id: current_user.id)
  if request.xhr?
    if new_comment.save
      erb :'/comments/_show', layout: false, locals: {comment: new_comment}
    else
      status 422
      erb :_errors, layout: false, locals: {errors: ["Body cannot be blank"]}
    end
  else
    if new_comment.save
      redirect "/questions/#{params[:answer_id]}"
    else
      @errors = ["Body cannot be blankeroonie"]
      erb :'/comments/new'
    end
  end
end
