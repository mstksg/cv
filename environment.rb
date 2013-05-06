#!/usr/bin/env ruby

require 'sinatra/base' unless defined?(Sinatra)

require 'haml'
require 'yaml'
require 'pathname'
require 'json'
require 'logger'

require_relative 'helpers/init'

if __FILE__ == $0
  require 'pry'
  binding.pry
  exit 1
end
