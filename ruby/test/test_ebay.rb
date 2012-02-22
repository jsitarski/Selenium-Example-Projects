require "selenium-webdriver"
require "test/unit"

class TestEbay < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for(:firefox)
    @base_url = "http://www.ebay.com/"
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end
  
  def test_ebay
    @driver.get(@base_url + "/")
    @driver.find_element(:id, "_nkw").click
    @driver.find_element(:id, "_nkw").clear
    @driver.find_element(:id, "_nkw").send_keys "bmw"
    @driver.find_element(:id, "ghSearch").click
    assert element_present?(:link, "eBay Motors")
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
