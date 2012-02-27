package com.fgm.testing.selenium;

import java.net.URL;
import java.util.Properties;
import java.util.regex.Pattern;
import java.util.concurrent.TimeUnit;
import org.junit.*;
import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;
import org.openqa.selenium.*;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.Select;

public class TestEbay {
		private final Properties properties = new Properties(); 
        private WebDriver driver;
        private String baseUrl;
        private StringBuffer verificationErrors = new StringBuffer();
        @Before
        public void setUp() throws Exception {
        	properties.load(getClass().getResourceAsStream("/webdriver.properties"));
            driver = new RemoteWebDriver( new URL(properties.getProperty("webdriver.remoteUrl")), 
            			 	DesiredCapabilities.firefox());
            baseUrl = "http://www.ebay.com/";
            driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
        }

        @Test
        public void testEbay() throws Exception {
                driver.get(baseUrl + "/");
                driver.findElement(By.id("_nkw")).clear();
                driver.findElement(By.id("_nkw")).sendKeys("bmw");
                driver.findElement(By.id("ghSearch")).click();
                assertTrue(isElementPresent(By.linkText("eBay Motors")));
        }

        @After
        public void tearDown() throws Exception {
                driver.quit();
                String verificationErrorString = verificationErrors.toString();
                if (!"".equals(verificationErrorString)) {
                        fail(verificationErrorString);
                }
        }

        private boolean isElementPresent(By by) {
                try {
                        driver.findElement(by);
                        return true;
                } catch (NoSuchElementException e) {
                        return false;
                }
        }
}