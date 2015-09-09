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
@phone = ''

state = YAML.load_file('yml/florida.yml')
agent = Mechanize.new

@state = 'KY' if state['state_form'] == 'abbr'
@state = 'KY - Kentucky' if state['state_form'] == 'abbr - full'
@state = 'KENTUCKY' if state['state_form'] == 'all caps'
@country = 'US' if state['country_form'] == 'abbr'
@country = 'U.S.A.' if state['country_form'] == 'U.S.A.'
@country = 'UNITED STATES' if state['country_form'] == 'all caps'
@country = 'USA' if state['country_form'] == 'USA'

page = agent.get(state['url'])
form = page.form_with(state['form_by'].to_sym => state['form'])
state['attrs'].each do |attr|
  form[attr.last] = instance_variable_get("@#{attr.first}")
end

if state['other']
  state['other'].each do |attr|
    form[attr.first] = attr.last
  end
end

if state['check']
  state['check'].split(',').each do |check|
    form.checkbox_with(name: check).check
  end
end

if state['uncheck']
  state['uncheck'].split(',').each do |uncheck|
    form.checkbox_with(name: check).selected = false
  end
end

page = agent.submit(form)
pp form
success = page.body.include? state['success']
p "Success: #{success}"
