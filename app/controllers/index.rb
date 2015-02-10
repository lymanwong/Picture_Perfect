require 'dotenv'
Dotenv.load

get '/' do
  erb :index
end

post '/' do
  require 'pony'
  Pony.mail({
    name = params[:name]
    phone = params[:phone]
    email = params[:email]
    message = params[:message]
    :from => params[:name] + "<" + params[:email] + ">",
    :to => 'lymanwong@gmail.com',
    :subject => params[:name] + " has contacted you from Perfect Picture Artistry",
    :html_body =>
    '<h4>Name: params[:name]</h4><br>
    <h4>Phone number: params[:phone]</h4><br>
    <h4>Email: params[:email]</h4><br>
    <h4>Message: params[:message]</h4><br>',
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
