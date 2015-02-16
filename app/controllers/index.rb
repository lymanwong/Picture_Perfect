require 'dotenv'
Dotenv.load

get '/' do
  erb :index
end

post '/' do
  require 'pony'
  name = params[:name]
  phone = params[:phone]
  email = params[:email]
  message = params[:message]
  Pony.mail({
    :from => params[:name] + "<" + params[:email] + ">",
    :to => 'pictureperfectbyivon@gmail.com',
    :subject => params[:name] + " has contacted you from Perfect Picture Artistry",
    :html_body =>
    "<h4>Name: #{name}</h4>
    <h4>Phone number: #{phone}</h4>
    <h4>Email: #{email}</h4>
    <h4>Message: #{message}</h4>",
    :body =>
    "Name: " + params[:name] + " | " +
    "Phone number: " + params[:phone] + " | " +
    "Email: " + params[:email] + " | " +
    "Message: " + params[:message],

    :via => :smtp,
    :via_options => {
      :address              => 'smtp.gmail.com',
      :port                 => '587',
      :enable_starttls_auto => true,
      :user_name            => ENV['LOGIN'],
      :password             => ENV['PASSWORD'],
      :authentication       => :plain
    }
    })
  redirect '/'
end

after do
  ActiveRecord::Base.connection.close
end
