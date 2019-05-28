current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
#node_name                'node_name'
#client_key               "#{current_dir}/USER.pem"
#validation_client_name   'ORG_NAME-validator'
#validation_key           "#{current_dir}/ORGANIZATION-validator.pem"
#chef_server_url          'https://api.chef.io/organizations/ORG_NAME'
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
