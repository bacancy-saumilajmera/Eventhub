# frozen_string_literal: true

set :output, { error: 'log/cron_error_log.log', standard: 'log/cron_log.log' }
set :bundle_command, '/usr/local/bin/bundle'

set :environment, 'development'
set :env_path, '"/usr/share/rvm/rubies/ruby-2.6.3/bin/ruby"'
job_type :rake, ' cd :path && PATH=:env_path:"$PATH" RAILS_ENV=:environment bin/rake :task --silent :output '
job_type :runner, %q( cd :path && PATH=:env_path:"$PATH" bin/rails runner -e :environment ':task' :output )
job_type :script, ' cd :path && PATH=:env_path:"$PATH" RAILS_ENV=:environment bundle exec bin/:task :output '
every 1.day, at: '12:00am' do
  runner 'Event.delete_event'
end

every 1.minute do
  runner 'Registration.delete_record'
end
