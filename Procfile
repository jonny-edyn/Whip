web: bundle exec puma -C config/puma.rb
resque: env TERM_CHILD=1 COUNT=1 QUEUE=* RESQUE_TERM_TIMEOUT=30 VVERBOSE=1 bundle exec rake resque:work