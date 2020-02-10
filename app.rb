#encoding UTF-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'net/smtp'
require 'sqlite3'
require 'sinatra/activerecord'

set :database, "sqlite3:home_accounting.db"

class Debit < ActiveRecord::Base
validates :user, presence: true, length: {minimum: 3}
validates :category_debit, presence: true
validates :amount, numericality: true
validates :comment, presence: true, length: {minimum: 3}
end

class Credit < ActiveRecord::Base

end 

configure do

  enable :sessions
end

get '/statistics' do

    
 
  erb :statistics
end


get '/credit' do
  erb :credit
end

post '/credit' do

  
   credit = Credit.new params[:element]
   credit.save
  erb :statistics
end

get '/debit' do
  @c = Debit.new
  erb :debit
end

post '/debit' do

  @c = Debit.new params[:element]
  @c.save
  if @c.save
    @error = "Сохранение удачное!"
    erb :statistics
  else
    @error = "Не сохранилось ошибка: #{@c.errors.full_messages.first}"
    erb :debit
  end
end

get '/info/:id' do
   de = Debit.all
   info_id = params[:id]
   @deb = de.find_by(id: "#{info_id}")
   
  erb :info
end


post '/info/:id' do
    deb = Debit.all
    info_id = params[:id]
   @deb = deb.find_by(id: "#{info_id}")
   @deb.update params[:element]
   @deb.save
  erb :info
end








helpers do
  def username
    session[:identity] ? session[:identity] : 'Авторизуйтесь!'
  end
end

before '/secure/*' do
   # @credit = Credit.all
   # @debit = Debet.all
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
