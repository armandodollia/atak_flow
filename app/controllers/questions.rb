get '/questions/:question_id' do
  @question = Question.find_by(id: params[:question_id])
  p @question
  erb :'/questions/show'
end
