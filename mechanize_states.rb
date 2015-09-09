require 'rubygems'
require 'mechanize'
require 'carmen'
require './open_in_browser.rb'
include Carmen

agent = Mechanize.new
us = Country.named('United States')

firstname = ''
lastname = ''
address1 = ''
address2 = ''
city = ''
# Two Char Abbr
state = ''
zip = ''
country = 'United States'
email = ''

=begin
p 'Maine'
page = agent.get('https://1004-webprd.mpxhosting.com/landing/?_ga=1.156422777.377718317.1433393336')

form = page.form('travelform')
form.firstname = firstname
form.lastname = lastname
form.street = address1
form.city = city
form.state = state
form.zipcode = zip
form.country = country
form.checkbox_with(name: 'emailspecialoffers').uncheck
form.checkbox_with(name: 'emailoptin').uncheck

page = agent.submit(form)

p page.body.include?('THANK YOU!') ? 'SUCCESS' : 'FAIL'
=end

=begin
# Maryland
# struggling with ajax
page = agent.get('http://www.visitmaryland.org/brochure')

# add guide to cart
agent.click(page.link_with(href: '/ajax/brochure/nojs/package/32'))

form = page.form_with(id: 'views-form-brochure-list-block-1')
page = agent.submit(form)

pp page.forms

#form = page.form('travelform')
#form.firstname = firstname
#form.lastname = lastname
#form.street = address1
#form.city = city
#form.state = state
#form.zipcode = zip
#form.country = country
#form.checkbox_with(name: 'emailspecialoffers').uncheck
#form.checkbox_with(name: 'emailoptin').uncheck

#page = agent.submit(form)

# Mail Order Form Complete
# Thank you for ordering official Maryland travel planning information. Please expect 7-10 days for delivery.
=end

p 'Michigan'
page = agent.get('http://www.michigan.org/travel-guide/')
form = page.form('aspnetForm')
form['ctl00$DefaultCPH$Dz2$columnDisplay$ctl00$controlcolumn$ctl01$WidgetHost$WidgetHost_widget$ctl00$FirstName'] = firstname
form['ctl00$DefaultCPH$Dz2$columnDisplay$ctl00$controlcolumn$ctl01$WidgetHost$WidgetHost_widget$ctl00$LastName'] = lastname
form['ctl00$DefaultCPH$Dz2$columnDisplay$ctl00$controlcolumn$ctl01$WidgetHost$WidgetHost_widget$ctl00$Address1'] = address1
form['ctl00$DefaultCPH$Dz2$columnDisplay$ctl00$controlcolumn$ctl01$WidgetHost$WidgetHost_widget$ctl00$txtAddress2'] = address2
form['ctl00$DefaultCPH$Dz2$columnDisplay$ctl00$controlcolumn$ctl01$WidgetHost$WidgetHost_widget$ctl00$City'] = city
form['ctl00$DefaultCPH$Dz2$columnDisplay$ctl00$controlcolumn$ctl01$WidgetHost$WidgetHost_widget$ctl00$UsStateList'] = state #us.subregions.coded(state).name
form['ctl00$DefaultCPH$Dz2$columnDisplay$ctl00$controlcolumn$ctl01$WidgetHost$WidgetHost_widget$ctl00$Zip'] = zip
form['ctl00$DefaultCPH$Dz2$columnDisplay$ctl00$controlcolumn$ctl01$WidgetHost$WidgetHost_widget$ctl00$EmailAddr'] = email
pp form
page.open_in_browser

page = agent.submit(form)

#link = page.link_with(text: 'Sign Me Up')
#pp link
#page = link.click
#page.open_in_browser

p page.body.include?('The Pure Michigan Travel Guide is being shipped to the mailing address you provided.') ? 'SUCCESS' : 'FAIL'
