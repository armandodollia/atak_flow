get '/questions' do
  @questions = Question.all
  erb :'questions/index'
end

get '/questions/:question_id' do
  @question = Question.find_by(id: params[:question_id])
  erb :'/questions/show'
end

