# Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format laid out [here](https://github.com/sensu-plugins/community/blob/master/HOW_WE_CHANGELOG.md)

## [Unreleased]

## [2.0.0] - 2017-12-21
### Security
- updated rubocop dependency to `~> 0.51.0` per: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-8418. (@majormoses)

### Breaking Changes
- removed < ruby 2.1 support which was pulled as part of security updates (@majormoses)

### Changed
- updated Changelog guidelines location (@majormoses)
- bin/metrics-apache-graphite.rb: remove magic comment for utf8 as that is the default in ruby as of ruby 2.0. See https://github.com/bbatsov/rubocop/issues/4767 for more information (@majormoses)

### Removed
- Ruby 1.9.3 from deploy-time testing (@eheydrick)

## [1.0.0] - 2017-07-01
#### Breaking Changes
- remove ruby 1.9 support

### Changed
- rubocop bump
- adding ruby 2.3 and 2.4 testing

## [0.0.5] - 2016-02-18
### Fixed
- cert issue

## [0.0.4] - 2015-08-04
### Changed
- general cleanup, no code changes

## [0.0.3] - 2015-07-14
### Changed
- updated sensu-plugin gem to 1.2.0

## [0.0.2] - 2015-06-02
### Fixed
- added binstubs

## 0.0.1 - 2015-04-30
### Added
- initial release

[Unreleased]: https://github.com/sensu-plugins/sensu-plugins-apache/compare/2.0.0...HEAD
[2.0.0]: https://github.com/sensu-plugins/sensu-plugins-apache/compare/1.0.0...2.0.0
[1.0.0]: https://github.com/sensu-plugins/sensu-plugins-apache/compare/0.0.5...1.0.0
[0.0.5]: https://github.com/sensu-plugins/sensu-plugins-apache/compare/0.0.4...0.0.5
[0.0.4]: https://github.com/sensu-plugins/sensu-plugins-apache/compare/0.0.3...0.0.4
[0.0.3]: https://github.com/sensu-plugins/sensu-plugins-apache/compare/0.0.2...0.0.3
[0.0.2]: https://github.com/sensu-plugins/sensu-plugins-apache/compare/0.0.1...0.0.2
