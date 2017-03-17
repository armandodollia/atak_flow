get '/questions' do
  @questions = Question.all
  erb :'questions/index'
end

get '/questions/:question_id' do
  @question = current_question(params[:question_id])
  erb :'/questions/show'
end

get '/questions/:question_id/comments' do
  @question = current_question(params[:question_id])
  @path = "/questions/#{@question.id}/comments/new"
  @comments = @question.comments
  erb :'/comments/index'
end

get '/questions/:question_id/comments/new' do
  @post_path = "/questions/#{params[:question_id]}/comments"
  if logged_in?
    erb :'/comments/new'
  else
    redirect "/sessions/new"
  end
end

post '/questions/:question_id/comments' do
  @post_path = "/questions/#{params[:question_id]}/comments"
  new_comment = current_question(params[:question_id]).comments.new(body: params[:body], user_id: current_user.id)

  if new_comment.save
    redirect "/questions/#{params[:question_id]}"
  else
    @errors = ["Body cannot be blankeroonie"]
    erb :'/comments/new'
  end
end

