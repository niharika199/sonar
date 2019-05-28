
# Cookbook:: sonarqube
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

#include_recipe 'zipfile'

user 'sonar' do
  manage_home  true
  home '/home/sonar'
  system true
end

group 'sonar' do
  members 'sonar'
  system true
end

#download_sonar()
remote_file 'sonarqube.zip' do
  source 'https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.7.zip'
  owner 'sonar'
  group 'sonar'
  mode '0777'
  action :create_if_missing
end


bash 'extract_module' do
  code <<-EOH
    unzip sonarqube.zip  -d  /opt/
    chown -R sonar:sonar /opt/sonarqube-7.7
    EOH
  not_if { ::File.exist?('/opt/sonarqube-7.7') }
end

template '/opt/sonarqube-7.7/conf/sonar.properties' do 
   source 'sonar.erb'
   owner     'sonar'
   group     'sonar'
   mode      '0755' 
   variables( 
      user: 'sonar', 
      password: 'sonar', 
      url: 'jdbc:postgresql://localhost/sonar'
   ) 
end 

template '/opt/sonarqube-7.7/conf/wrapper.conf' do
   source 'wrapper.conf.erb'
   owner     'sonar'
   group     'sonar'
   mode      '0755'
   variables(
      java: '/usr/lib/jvm/java-8-openjdk-amd64/bin/java'
   )
end



execute 'Start the sonarqube' do
  cwd '/opt/sonarqube-7.7/bin/linux-x86-64'
  command './sonar.sh start'
  user 'sonar'
end
