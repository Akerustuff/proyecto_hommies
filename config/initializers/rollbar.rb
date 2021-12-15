# frozen_string_literal: true

Rollbar.configure do |config|
  # Without configuration, Rollbar is enabled in all environments.
  # To disable in specific environments, set config.enabled=false.

  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']

  # Here we'll disable in 'test':
  config.enabled = false if Rails.env.test?
  config.enabled = %w[production staging].include?(Rails.env)
  config.async_handler = nil
  config.before_process = []
  config.capture_uncaught = nil
  config.code_version = nil
  config.custom_data_method = nil
  config.logger_level = :info
  config.delayed_job_enabled = true
  config.disable_monkey_patch = false
  config.disable_core_monkey_patch = false
  config.disable_rack_monkey_patch = false
  config.dj_threshold = 0
  config.enabled = nil # set to true when configure is called
  config.endpoint = DEFAULT_ENDPOINT
  config.environment = nil
  config.exception_level_filters = {
    'ActiveRecord::RecordNotFound' => 'warning',
    'AbstractController::ActionNotFound' => 'warning',
    'ActionController::RoutingError' => 'warning'
  }
  config.failover_handlers = []
  config.framework = 'Plain'
  config.ignored_person_ids = []
  config.payload_options = {}
  config.person_method = 'current_user'
  config.person_id_method = 'id'
  config.person_username_method = nil
  config.person_email_method = nil
  config.project_gems = []
  config.populate_empty_backtraces = false
  config.report_dj_data = true
  config.open_timeout = 3
  config.request_timeout = 3
  config.net_retries = 3
  config.js_enabled = false
  config.js_options = {}
  config.locals = {}
  config.scrub_fields = %i[passwd password password_confirmation secret
                           confirm_password password_confirmation secret_token
                           api_key access_token accessToken session_id]
  config.scrub_user = true
  config.scrub_password = true
  config.randomize_scrub_length = false
  config.scrub_whitelist = []
  config.uncaught_exception_level = 'error'
  config.scrub_headers = ['Authorization']
  config.sidekiq_threshold = 0
  config.safely = false
  config.transform = []
  config.use_async = false
  config.use_eventmachine = false
  config.verify_ssl_peer = true
  config.web_base = DEFAULT_WEB_BASE
  config.write_to_file = false
  config.send_extra_frame_data = :none
  config.project_gem_paths = []
  config.use_exception_level_filters_default = false
  config.proxy = nil
  config.raise_on_error = false
  config.transmit = true
  config.log_payload = false
  config.collect_user_ip = true
  config.anonymize_user_ip = false
  config.backtrace_cleaner = nil
  config.hooks = {
    on_error_response: nil, # params: response
    on_report_internal_error: nil # params: exception
  }

  config.configured_options = ConfiguredOptions.new(self)
  # By default, Rollbar will try to call the `current_user` controller method
  # to fetch the logged-in user object, and then call that object's `id`
  # method to fetch this property. To customize:
  # config.person_method = "my_current_user"
  # config.person_id_method = "my_id"

  # Additionally, you may specify the following:
  # config.person_username_method = "username"
  # config.person_email_method = "email"

  # If you want to attach custom data to all exception and message reports,
  # provide a lambda like the following. It should return a hash.
  # config.custom_data_method = lambda { {:some_key => "some_value" } }

  # Add exception class names to the exception_level_filters hash to
  # change the level that exception is reported at. Note that if an exception
  # has already been reported and logged the level will need to be changed
  # via the rollbar interface.
  # Valid levels: 'critical', 'error', 'warning', 'info', 'debug', 'ignore'
  # 'ignore' will cause the exception to not be reported at all.
  # config.exception_level_filters.merge!('MyCriticalException' => 'critical')
  #
  # You can also specify a callable, which will be called with the exception instance.
  # config.exception_level_filters.merge!('MyCriticalException' => lambda { |e| 'critical' })

  # Enable asynchronous reporting (uses girl_friday or Threading if girl_friday
  # is not installed)
  # config.use_async = true
  # Supply your own async handler:
  # config.async_handler = Proc.new { |payload|
  #  Thread.new { Rollbar.process_from_async_handler(payload) }
  # }

  # Enable asynchronous reporting (using sucker_punch)
  # config.use_sucker_punch

  # Enable delayed reporting (using Sidekiq)
  # config.use_sidekiq
  # You can supply custom Sidekiq options:
  # config.use_sidekiq 'queue' => 'default'

  # If your application runs behind a proxy server, you can set proxy parameters here.
  # If https_proxy is set in your environment, that will be used. Settings here have precedence.
  # The :host key is mandatory and must include the URL scheme (e.g. 'http://'), all other fields
  # are optional.
  #
  # config.proxy = {
  #   host: 'http://some.proxy.server',
  #   port: 80,
  #   user: 'username_if_auth_required',
  #   password: 'password_if_auth_required'
  # }

  # If you run your staging application instance in production environment then
  # you'll want to override the environment reported by `Rails.env` with an
  # environment variable like this: `ROLLBAR_ENV=staging`. This is a recommended
  # setup for Heroku. See:
  # https://devcenter.heroku.com/articles/deploying-to-a-custom-rails-environment
  config.environment = ENV['ROLLBAR_ENV'].presence || Rails.env
end
