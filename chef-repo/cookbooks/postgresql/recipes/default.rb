postgresql_server_install 'My PostgreSQL Server install' do
  action :install
end

postgresql_user 'sonar' do
  password 'sonar'
  createdb true
end

postgresql_database 'sonar' do
  owner 'sonar'
end
