require 'selenium-webdriver'
driver = Selenium::WebDriver.for :chrome
wait = Selenium::WebDriver::Wait.new(timeout: 80)
driver.navigate.to 'https://filmarks.com/list/genre/8'
  
# driver.find_elements(:xpath, '//img')
element=driver.find_element(:xpath, '/html/body/div[4]/div[2]/div[2]/div[1]/div[2]/div[1]/div[2]/div[4]/a').click
  detail = driver.find_element(:xpath, '//*[@id="js-content-detail-synopsis"]/div/div/button').click
  more_detail = driver.find_element(:id, 'js-content-detail-synopsis').text
 puts more_detail


# detail = driver.find_elements(:class,'p-content-detail__synopsis-desc is-show-all')
# elements.each do |element|
#   puts element.text
# end
# puts element
# puts detail
# puts detail




