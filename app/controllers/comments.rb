get '/questions/:question_id/comments' do
  @question = current_question(params[:question_id])
  @comments = @question.comments
  @path = "/questions/#{params[:question_id]}/comments/new"
  if request.xhr?
    erb :'/comments/_index', layout: false, locals: {comments: @comments, path: @path}
  else
    erb :'/comments/index'
  end
end

before '/questions/:question_id/comments/new' do
  redirect "/sessions/new" if !logged_in?
end

get '/questions/:question_id/comments/new' do
  @post_path = "/questions/#{params[:question_id]}/comments"
  if request.xhr?
    erb :'/comments/_new', layout: false, locals: {post_path: @post_path}
  else
    erb :'/comments/new'
  end
end

post '/questions/:question_id/comments' do
  return redirect "/sessions/new" if !logged_in?
  @post_path = "/questions/#{params[:question_id]}/comments"
  new_comment = current_question(params[:question_id]).comments.new(body: params[:body], user_id: current_user.id)
  if request.xhr?
    if new_comment.save
      erb :'/comments/_show', layout: false, locals: {comment: new_comment}
    else
      status 422
      erb :_errors, layout: false, locals: {errors: ["Body cannot be blank"]}
    end
  else
    if new_comment.save
      redirect "/questions/#{params[:question_id]}"
    else
      @errors = ["Body cannot be blankeroonie"]
      erb :'/comments/new'
    end
  end
end
