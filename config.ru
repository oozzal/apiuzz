require 'rubygems'
require 'bundler'

Bundler.require

require File.expand_path 'web.rb', File.dirname(__FILE__)

run App

