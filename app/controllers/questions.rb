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
  @comments = @question.comments
  erb :'/comments/index'
end


post '/questions/:question_id/answers' do
  if logged_in?
    current_question(params[:question_id]).answers.create(body: params[:answer], user_id: current_user.id)
    redirect back
  else
    redirect back
  end
end