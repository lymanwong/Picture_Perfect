get '/' do
  erb :index
end

post '/' do
  require 'pony'
  name = params[:name]
  email = params[:email]
  phone = params[:phone]
  message = params[:message]
  Pony.mail({
    :from => params[:name] + "<" + params[:email] + ">",
    :to => 'lymanwong@gmail.com',
    :subject => params[:name] + " has contacted you from Perfect Picture Artistry",
    :html_body =>
    '<h4>Name: #{name}</h4><h4>Phone number: #{phone}</h4><h4>Email: #{email}</h4><h4>Message: #{message}</h4>',
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


  #    get('/success') do
  # @notification = "Thanks for your email. I'll be in touch soon."
  # erb :index, :layout => :layout
# end


# Pony.mail(:to => 'you@example.com', :html_body => '<h1>Hello there!</h1>', :body => "In case you can't read html, Hello there.")
