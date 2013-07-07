require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'PG'

get '/' do
erb :home
end



get '/addfriend' do
  erb :addfriend
end

post '/addfriend' do


  @friend_name = params[:friend_name]
  @age = params[:age]
  @gender = params[:gender]
  @image=params[:image]

    query = "INSERT INTO amici (name, age, gender, image) VALUES ('#{@friend_name}','#{@age}','#{@gender}','#{@image}');"
    conn = PG.connect(:dbname => 'amis', :host => 'localhost')
    conn.exec(query)
    conn.close

  redirect '/friends'

  end

  get '/friends' do

  query = "SELECT name, age, gender, image FROM amici"
    conn = PG.connect(:dbname => 'amis', :host => 'localhost')
    @list = conn.exec(query)
    conn.close


    erb :friends
  end