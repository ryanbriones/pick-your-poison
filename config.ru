require 'bundler'
Bundler.require :default

base = File.dirname(__FILE__)
$:.unshift File.join(base, 'lib')

require 'pick_your_poison'

Sinatra::Base.set(:root) { base }
run PickYourPoison::Application
