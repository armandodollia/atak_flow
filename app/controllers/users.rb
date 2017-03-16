#pulls up the form for posting, see create_user.rb
#alias for /register

before '/users/*' do
  if !logged_in?
    redirect "/sessions/new"
  end
end

get '/users/new' do
 erb :'/users/new'
end


#set the new user to a variable.
#If the user's data is valid, save/persist to the DB, begin a session, redirect them to their profile.
#If not, raise some erros about the attempt and stay on the same page.

post '/users' do
  user = User.new(params[:user])
  redirect "/" if logged_in?

  if user.save
    session[:user_id] = user.id
    redirect "/"
  else
    @errors = user.errors.full_messages
    erb :'users/new'
  end
end

#a more secure than not route to getting to a users page if only the currently
#logged in user is allowed to see their page.

get '/users/:user_id' do
    if authorized?(params[:user_id])
      erb :'users/show'
    else
      redirect "/users/#{current_user.id}"
    end
end
