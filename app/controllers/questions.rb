get '/questions' do
  @questions = Question.all
  erb :'/questions/index'
end

get '/questions/:question_id' do
  @question = current_question(params[:question_id])
  erb :'/questions/show'
end

get '/questions/:question_id/comments' do
  @question = current_question(params[:question_id])
  stuff = @question.comments
  @post = "/questions/#{params[:question_id]}/comments/new"
  if request.xhr?
    erb :'/comments/_index', locals: {comments: stuff}, layout: false
  else
    erb :'/comments/index', locals: {comments: stuff}
  end
end

post '/questions/:question_id/answers' do
  return redirect "questions/#{params[:question_id]}" if !logged_in?
  new_answer = current_question(params[:question_id]).answers.new(body: params[:answer], user_id: current_user.id)

  if new_answer.save!
    if request.xhr?
      erb :'answers/_answer', locals: {answer: new_answer}, layout: false
    else
      redirect back
    end
  else
    if request.xhr?
      status 422
    else
      @errors = new_answer.errors.full_messages
      erb :'questions/show'
    end
  end
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
