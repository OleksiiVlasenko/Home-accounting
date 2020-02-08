#encoding UTF-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'net/smtp'
require 'sqlite3'
require 'sinatra/activerecord'

set :database, "sqlite3:home_accounting.db"

class Debet < ActiveRecord::Base

end

class Credit < ActiveRecord::Base

end 

configure do

  enable :sessions
end



get '/credit' do
  erb :credit
end

post '/credit' do
  "Hello World"
end

get '/debit' do
  erb :debit
end

post '/debit' do
  "Hello World"
end








helpers do
  def username
    session[:identity] ? session[:identity] : 'Авторизуйтесь!'
  end
end

before '/secure/*' do
  credit = Credit.new
  debet = Debet.new
  unless session[:identity]
    session[:previous_url] = request.path
    @error = 'Sorry, you need to be logged in to visit ' + request.path
    halt erb(:login_form)
  end
end

get '/' do
  erb 'Can you handle a <a href="/secure/place">secret</a>?'
end

get '/login/form' do
  erb :login_form
end

post '/login/attempt' do
  session[:identity] = params['username']
  where_user_came_from = session[:previous_url] || '/'
  redirect to where_user_came_from
end

get '/logout' do
  session.delete(:identity)
  erb "<div class='alert alert-message'>Logged out</div>"
end

get '/secure/place' do
  erb 'This is a secret place that only <%=session[:identity]%> has access to!'
end
