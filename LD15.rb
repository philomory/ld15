#!/usr/bin/env ruby
require 'rubygems'
gem 'gosu'
require 'gosu'

#require 'MainWindow'
require 'require_all'
require_all (Dir.glob("*.rb") + Dir.glob("**/*.rb") - ['./LD15.rb','LD15.rb'])



$window = LD15::MainWindow.instance
$window.show