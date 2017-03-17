helpers do
  def current_question(argument_id)
    Question.find_by(id: argument_id)
  end
end
