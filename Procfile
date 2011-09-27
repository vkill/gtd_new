thin: bundle exec thin start -p 3000
resque_scheduler: bundle exec rake resque:scheduler INITIALIZER_PATH=config/initializers/resque.rb
resque_workers: bundle exec rake resque:workers QUEUE=* COUNT=2
resque-web: bundle exec resque-web --foreground --server thin --port $PORT --no-launch config/initializers/resque.rb

