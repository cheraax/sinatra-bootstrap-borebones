require 'sinatra'
require 'sinatra/reloader'
require 'rubygems'

configure do
  enable :sessions
end

helpers do
  def username
    session[:identity] ? session[:identity] : 'Anonymus'
  end
  # формирование меню ( layout.erb - menu ), берем все роуты ГЕТ
  # и формируем по ним меню, c подсветкой активной страницы
  # если использовать вложенные роуты /страница/еще_одна,
  # то необходимо переписать
  def menu
    active = request.path.gsub("/","").to_sym
    pages = Sinatra::Application.routes["GET"].map { |route| route[0].to_s.gsub("/","").to_sym}
    html = []
    pages.each do |page|
      li_class = page == active ? 'class="active"' : ''
      html << "<li #{li_class}> <a href=/#{page}>#{page.capitalize}</a></li>"
    end
    html.join
  end
  # сообщение, которое можно выводить на странице,
  # так же можно использовать для отладки
  def default_message
        "<p>Use this document as a way to quick start any new project.
        <br>All you get is this message and a barebones HTML document.</p>
        #{session.inspect} #{request.inspect}"
  end
end

before '/secure*' do
  unless session[:identity]
      session[:previous_url] = request.path
      @error = 'Sorry, you need to be logged in to visit ' + request.path
      halt erb(:login_form)
  end
end

get '/' do
  # вывод шаблона welcome.erb внутри шаблона layout.erb
  erb :welcome, :layout => :layout
end

get '/home' do
  # вывод шаблона welcome.erb внутри шаблона layout.erb
  erb :home, :layout => :layout
end

get '/about' do
  # вывод шаблона about.erb внутри шаблона layout.erb
  erb :about, :layout => :layout
end

get '/contact' do
  # вывод шаблона contact.erb внутри шаблона layout.erb
  erb :contact, :layout => :layout
end

#  обработка "залогинивания"
post '/login/attempt' do
  session[:identity] = params['username']
  where_user_came_from = session[:previous_url] || '/'
  redirect to where_user_came_from
end

get '/secure' do
  erb 'This is a secret place that only <strong><%=session[:identity]%></strong> has access to!'
end
