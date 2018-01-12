require 'rubygems'
require 'selenium-webdriver'
require 'minitest/autorun'

class XCartTest < Minitest::Test

  def assert_equal_fun(expected_title='',actual_title='')
    assert_equal(expected_title, actual_title)
  end

  def test_name1
    driver = Selenium::WebDriver.for(:chrome)
    driver.manage.window.maximize
    driver.navigate.to "http://demostore.x-cart.com"

    # открыть главную страницу магазина, проверить что это главная страница магазина (выбрать признак который соответствует главной странице магазина)
    assert_equal_fun("X-Cart Demo store company > Catalog",driver.title)

    # открыть первую категорию, проверить, что это нужная категория (выбрать нужный уникальный признак)
    driver.find_element(:xpath,'.//*[@id=\'header-area\']//span[text()=\'Catalog\']').click
    driver.find_element(:xpath,'.//*[@id=\'header-area\']//span[text()=\'Apparel\']').click

    # checking that page title contains word 'Apparel'
    assert_equal_fun("X-Cart Demo store company > Apparel",driver.title)

    # открыть первый продукт со страницы категории, проверить что это нужный продукт(выбрать нужный уникальный признак).
    driver.find_element(:xpath,'.//*[@class=\'block block-block\']//a[text() ="Mordorable! Fitted Ladies\' Tee"]').click

    # checking that page title contains word 'Mordorable! Fitted Ladies' Tee'
    assert_equal_fun("X-Cart Demo store company > Apparel > Mordorable! Fitted Ladies' Tee",driver.title)

    # Добавить продукт в карту, проверить что продукт успешно добавился в карту
    driver.find_element(:xpath,'.//*[ @type=\'submit\' and span=\'Add to cart\']').click

    sleep 3

    search4 = driver.find_element(:xpath,'.//*[@id=\'ui-id-4\']').attribute('innerHTML')

    # checking that page contains word 'You have just added'
    assert_equal_fun("You have just added",search4)
  end
end