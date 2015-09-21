require "bundler"
require 'rack-flash'

Bundler.require(:default)

if development?
  require 'dotenv'
  Dotenv.load
end

configure do
  set :haml, :format => :html5
  enable :sessions
  use Rack::Flash

  if production?
    set :scss, :style => :compressed, :debug_info => false
  end
end

helpers do
  def partial(page, options={})
    haml "_#{page}".to_sym, options.merge!(:layout => false)
  end

  def development?
    settings.development?
  end

  def production?
    settings.production?
  end
end

get '/main.css' do
  scss :'/stylesheets/main'
end

get '/' do
  haml :index
end

post '/signup' do
  success_message = "Thanks for signing up!"
  fail_message = "That didn't work for some reason, please try again."

  begin
    Gibbon::Request.new(
      api_key: ENV['MAILCHIMP_API']
    ).lists(ENV['MAILCHIMP_LIST_ID']).members
    .create(body: {
      email_address: params[:email],
      status: "subscribed"
    })
    flash[:notice] = success_message
  rescue Gibbon::MailChimpError => e
    if e.raw_body.include? 'is already a list member'
      flash[:notice] = success_message
    else
      flash[:notice] = fail_message
    end
  end

  redirect '/'
end

get '/:name' do
  haml :"#{params['name']}"
end