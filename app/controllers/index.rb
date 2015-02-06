get '/' do
  erb :index
end

post '/' do
  require 'pony'
  name = params[:name]
  email = params[:email]
  message = params[:message]
  phone = params[:phone]
  Pony.override_options = { :sender => params[:email]}
  Pony.mail({
    :from => params[:name] + "<" + params[:email] + ">",
    :to => 'lymanwong@gmail.com',
    :subject => params[:name] + " has contacted you from Perfect Picture Artistry",
    :html_body => "<h4>Name: #{name}<h4>Email: #{email}</h4><h4>Phone: #{phone}</h4><h4>Message: #{message}</h4>",
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
      :user_name            => 'lymanwong@gmail.com',
      :password             => 'peanut123123123',
      :authentication       => :plain
    }
    })
  redirect '/'
end
