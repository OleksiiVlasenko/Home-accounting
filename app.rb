#encoding UTF-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'net/smtp'
require 'sqlite3'
require 'sinatra/activerecord'

set :database, "sqlite3:home_accounting.db"

class Debit < ActiveRecord::Base

end

class Credit < ActiveRecord::Base

end 

configure do

  enable :sessions
end

get '/statistics' do
  credit = Debit.all do |c|

    
  end
  debit = Debit.all do |d|
    
  end
  erb :statistics
end


get '/credit' do
  erb :credit
end

post '/credit' do
 @credit = Credit.new :user=>session[:identity],:amount =>params['amount_credit'],:category_credit => params['type_credit'],:comment =>params['comment_credit']
  @credit.save
  erb :statistics
end

get '/debit' do
  erb :debit
end

post '/debit' do
  @debit = Debit.new :user=>session[:identity],:amount =>params['amount_debit'],:category_debit => params['type_debit'],:comment =>params['comment_debit']
  @debit.save
  erb :statistics
end








helpers do
  def username
    session[:identity] ? session[:identity] : 'Авторизуйтесь!'
  end
end

before '/secure/*' do
  # @credit = Credit.new
  # @debet = Debet.new
  unless session[:identity]
    session[:previous_url] = request.path
    @error = 'Sorry, you need to be logged in to visit ' + request.path
    halt erb(:login_form)
  end
end

get '/' do
  erb :statistics
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
