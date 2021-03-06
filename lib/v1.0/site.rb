class ExercismV1p0 < Sinatra::Base
  get '/' do
    haml :"site/index"
  end

  get '/about' do
    current = App::Site::Languages.new(Exercism.current)
    upcoming = App::Site::Languages.new(Exercism.upcoming)
    haml :"site/about", locals: {current: current, upcoming: upcoming}
  end

  get '/getting-started' do
    languages = App::Site::Languages.new(Exercism.current)
    code_dir = File.join('./lib', Exercism::App.root, 'site', 'carousel')
    slides = App::Site::Carousel.slides(code_dir)
    haml :"site/getting_started", locals: {languages: languages, slides: slides}
  end

  get '/ohai' do
    haml :"site/temporary_landing_page"
  end
end
