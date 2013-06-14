require 'httparty'
require 'JSON'

key = {
  my_first_name: '',
  my_last_name: '',
  my_email: '',
  my_company: '',
  my_address: '',
  my_address2: '',
  my_city: '',
  my_state: '',
  my_zip: '',
  my_country: '',
  my_phone: ''
}

state = 'Georgia'
yml = YAML.load_file("post_yml/#{state.downcase}.yml")

key[:country] = 'US' if yml['country_form'] == 'abbr'
key[:state] = 'KY' if yml['state_form'] == 'abbr'

json_options = yml['options'].to_json
key.each do |k,v|
  json_options[k.to_s] = v if json_options.match(k.to_s)
end

if HTTParty.post(yml['url'], options).body.match(yml['success'])
  p "#{state}: success!"
else
  p "#{state}: failed :("
end
