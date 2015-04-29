require 'json'

# encoding: utf-8
module SensuPluginsApache
  # This defines the version of the gem
  module Version
    MAJOR = 0
    MINOR = 0
    PATCH = 11

    VER_STRING = [MAJOR, MINOR, PATCH].compact.join('.')

    NAME   = 'sensu-plugins-apache'
    BANNER = "#{NAME} v%s"

    module_function

    def version
      format(BANNER, VER_STRING)
    end

    def json_version
      {
        'version' => VER_STRING
      }.to_json
    end
  end
end
