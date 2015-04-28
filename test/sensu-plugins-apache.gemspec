PROJECTDIR = File.expand_path( '.')
lib = File.expand_path("#{ PROJECTDIR }/lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'date'

if RUBY_VERSION < '2.0.0'
  require 'sensu-plugins-apache'
else
  require_relative 'lib/sensu-plugins-apache'
end

Gem::Specification.new do |s|
  s.authors                = ['Sensu-Plugins and contributors']
  s.date                   = Date.today.to_s
  s.description            = 'Sensu plugins for the apache webserver'
  s.email                  = '<sensu-users@googlegroups.com>'
  s.executables            = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.files                  = Dir.glob('{bin,lib}/**/*') + %w(LICENSE README.md CHANGELOG.md)
  s.homepage               = 'https://github.com/sensu-plugins/sensu-plugins-apache'
  s.license                = 'MIT'
  s.metadata               = { 'maintainer'         => '',
                               'development_status' => 'unmaintained',
                               'production_status'  => 'unstable - testing reccomended'
                               }
  s.name                   = 'sensu-plugins-apache'
  s.platform               = Gem::Platform::RUBY
  s.require_paths          = ['lib']
  s.required_ruby_version  = '>= 1.9.3'
  s.summary                = 'Sensu plugins for the apache webserver'
  s.test_files             = s.files.grep(%r{^(test|spec|features)/})
  s.version                = SensuPluginsApache::Version::VER_STRING

  s.add_runtime_dependency 'sensu-plugin', '1.1.0'

  s.add_development_dependency 'codeclimate-test-reporter', '~> 0.4'
  s.add_development_dependency 'rubocop',                   '0.30.0'
  s.add_development_dependency 'rspec',                     '~> 3.1'
  s.add_development_dependency 'bundler',                   '~> 1.7'
  s.add_development_dependency 'rake',                      '~> 10.0'
  s.add_development_dependency 'github-markup',             '~> 1.3'
  s.add_development_dependency 'redcarpet',                 '~> 3.2'
  s.add_development_dependency 'yard',                      '~> 0.8'
  s.add_development_dependency 'pry',                       '~> 0.10'
end