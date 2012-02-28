require "selenium-webdriver"
require "test/unit"
require "yaml"
require "user_util"

class TestEbayWithYml < Test::Unit::TestCase
  include UserUtil

  def setup
    @config = YAML::load(File.open('config/endpoint.yml'))
    @driver = Selenium::WebDriver.for(@config['browser'].to_sym)
    #@driver = Selenium::WebDriver.for(:remote, :url => ENV['WEBDRIVER_URL'])
    @base_url = "http://www.ebay.com/"
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @form_data = YAML::load(File.open('test/form_data/ebay_search.yml'))
  end
  
  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end
  
  def test_ebay
    @driver.get(@base_url + "/")
    @driver.find_element(:id, "_nkw").click
    @driver.find_element(:id, "_nkw").clear
    @driver.find_element(:id, "_nkw").send_keys @form_data['search_value']
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
