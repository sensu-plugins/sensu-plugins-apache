#! /usr/bin/env ruby
#
#   check-apache-status
#
# DESCRIPTION:
#   Test whether apache is up and functional by using mod_status
#
# OUTPUT:
#   plain text
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
# check-apache-status.rb --help
# NOTES:
#
# LICENSE:
# Magic Online http://www.magic.fr  @2016
# Released under the same terms as Sensu (the MIT license); see LICENSE  for details.
#

require 'sensu-plugin/check/cli'
require 'open3'
require 'net/http'
require 'net/https'

#
# Check  Apache Status
#
class CheckApacheStatus < Sensu::Plugin::Check::CLI
  option :busy, long: '--busy BUSYWORKERS', short: '-b BusyWorkers', description: 'Busy workers threshold', proc: proc(&:to_i), default: 150, required: false
  option :uptime, long: '--uptime UPTIME', short: '-u UPTIME', description: 'UPTIME threshold in seconds', proc: proc(&:to_i), default: 60, required: false
  option :load, long: '--load LOAD', short: '-l LOAD', description: 'CPU Load threshold.', proc: proc(&:to_f), default: 80, required: false
  option :debug, long: '--debug', short: '-d', description: 'Debug output', boolean: true, default: false, required: false
  option :host, short: '-h HOST', long: '--host HOST', description: 'HOST to check mod_status output', default: '127.0.0.1'
  option :port, short: '-p PORT', long: '--port PORT', description: 'Port to check mod_status output', default: '80'
  option :secureport, long: '--secureport PORT', description: 'SSL Port to check mod_status output', default: '443'
  option :path, short: '-path PATH', long: '--path PATH', description: 'PATH to check mod_status output', default: '/server-status?auto'
  option :user, short: '-user USER', long: '--user USER', description: 'User if HTTP Basic is used'
  option :password, short: '-password USER', long: '--password USER', description: 'Password if HTTP Basic is used'
  option :secure, short: '-s', long: '--secure', description: 'Use SSL'

  # Acquire Apache mod_status
  def acquire_mod_status
    http = Net::HTTP.new(config[:host], config[:port])
    if config[:secure]
      http = Net::HTTP.new(config[:host], config[:secureport])
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.use_ssl = true
    end
    req = Net::HTTP::Get.new(config[:path])
    if !config[:user].nil? && !config[:password].nil?
      req.basic_auth config[:user], config[:password]
    end
    res = http.request(req)
    case res.code
    when '200'
      res.body
    else
      unknown "Unable to get Apache metrics, unexpected HTTP response code: #{res.code}"
    end
  rescue
    critical 'Apache Status failure!'
  end

  def run
    stats = {}
    acquire_mod_status.split("\n").each do |line|
      name, value = line.split(': ')
      case name
      when 'Total Accesses'
        stats['total_accesses'] = value.to_i
      when 'Uptime'
        stats['uptime'] = value.to_i
      when 'Total kBytes'
        stats['total_bytes'] = (value.to_f * 1024).to_i
      when 'CPULoad'
        stats['cpuload'] = value.to_f * 1
      when 'BusyWorkers'
        stats['busy_workers'] = value.to_i
      when 'IdleWorkers'
        stats['idle_workers'] = value.to_i
      when 'ReqPerSec'
        stats['requests_per_sec'] = value.to_f
      when 'BytesPerSec'
        stats['bytes_per_sec'] = value.to_f
      when 'BytesPerReq'
        stats['bytes_per_req'] = value.to_f
      when 'Scoreboard'
        value = value.strip
        stats['open'] = value.count('.')
        stats['waiting'] = value.count('_')
        stats['starting'] = value.count('S')
        stats['reading'] = value.count('R')
        stats['sending'] = value.count('W')
        stats['keepalive'] = value.count('K')
        stats['dnslookup'] = value.count('D')
        stats['closing'] = value.count('C')
        stats['logging'] = value.count('L')
        stats['finishing'] = value.count('G')
        stats['idle_cleanup'] = value.count('I')
        stats['total'] = value.length
      end
    end
    if stats['cpuload'].to_f > config[:load] && !stats['cpuload'].nil?
      warning "CPU Load #{stats['cpuload']} % > #{config[:load]}"
    elsif stats['uptime'].to_i < config[:uptime] && !stats['uptime'].nil?
      warning "Uptime #{stats['uptime']} seconds < #{config[:uptime]}"
    elsif stats['busy_workers'].to_i > config[:busy] && !stats['bisy_workers'].nil?
      warning "#{stats['busy_workers']} busy workers > #{config[:busy]}"
    elsif !stats['cpuload'].nil? || !stats['uptime'].nil? || !stats['busy_workers'].nil?
      ok "CPULoad #{stats['cpuload']} - Uptime: #{stats['uptime']} - Busy workers: #{stats['busy_workers']} "
    end
    critical 'Apache status failure!'
  end
end
