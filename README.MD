# Ruby, Sinatra, Bootstrap

Минимальный шаблон, что бы развернуть свое приложение для изучения

Используется один основной шаблон ```layout.erb```
И отдельные шаблоны(!) для каждой страницы

Меню генерируется исходя из содержания:

```Sinatra::Application.routes["GET"]```

и не
умеет работать с вложенными роутами, если нужно - необходимо переписать процедуру
 в
```ruby
main.rb
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
```
## Ошибки
  Так как я только в начале пути изучения, то обязательно будут ошибки.
  Буду исправлять по мере их нахождения или получения более обширных знаний по Ruby.

## Установка
```gem install bundler```
```git clone git@github.com:cheraax/sinatra-bootstrap-borebones.git```
```cd sinatra-bootstrap-borebones```
```bundle install```

Или просто скачайте архив

## Использование
  Используйте где хотите и как хотите

## Помощь
  Пулл-реквесты приветствуются.

## License
  [MIT](https://choosealicense.com/licenses/mit/)
