require 'rubygems'
require 'mechanize'
require 'yaml'

@first_name = ''
@last_name = ''
@email = ''
@company = ''
@address = ''
@address2 = ''
@city = ''
@state = ''
@zip = ''
@country = 'United States'

state = YAML.load_file('yml/arizona.yml')
agent = Mechanize.new

@state = 'KY' if state['state_form'] == 'abbr'
@country = 'US' if state['country_form'] == 'abbr'

page = agent.get(state['url'])
form = page.form_with(id: state['form_id'])
state['attrs'].each do |attr|
  form[attr.last] = instance_variable_get("@#{attr.first}")
end

if state['check']
  state['check'].split(',').each do |check|
    form.checkbox_with(name: check).check
  end
end

#page = agent.submit(form)
#pp form
success = page.body.include? state['success']
p "Success: #{success}" 
