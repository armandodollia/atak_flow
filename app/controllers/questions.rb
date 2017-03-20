get '/questions' do
  @questions = Question.all
  erb :'/questions/index'
end

get '/questions/new' do
  if logged_in?
    erb :'/questions/new'
  else
    redirect back
  end
end

post '/questions' do
  redirect back if !logged_in?
  new_question = Question.new(title: params[:title], body: params[:body], user_id: current_user.id)
  if new_question.save
    redirect "/questions"
  else
    @errors = new_question.errors.full_messages
    erb :'/question/new'
  end
end

get '/questions/:question_id' do
  @question = current_question(params[:question_id])
  erb :'/questions/show'
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
