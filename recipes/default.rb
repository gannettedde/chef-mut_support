# Cookbook Name:: mut_support
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'yum-epel'
include_recipe 'build-essential'
include_recipe 'python'
include_recipe 'nodejs'
include_recipe 'git'

%w(inherits methods grunt grunt-init grunt-cli).each do |pkg|
  nodejs_npm pkg do
    action :install
  end
end

%w(mocha web-mocha mocha-phantomjs mocha-server).each do |pkg|
  nodejs_npm pkg do
    action :install
  end
end

%w(bluebird lodash must noder.io should sinon supertest).each do |pkg|
  nodejs_npm pkg do
    action :install
  end
end

git '/home/vagrant/unit.js' do
  repository 'https://github.com/unitjs/unit.js'
  revision 'master'
  user 'vagrant'
  action :sync
end

execute 'npm install' do
  command 'npm install'
  cwd '/home/vagrant/unit.js'
  only_if { ::File.exist?('/home/vagrant/unit.js') }
end

execute 'make test' do
  command 'make test'
  user 'vagrant'
  cwd '/home/vagrant/unit.js'
  returns 2
  only_if { ::File.exist?('/home/vagrant/unit.js') }
end
