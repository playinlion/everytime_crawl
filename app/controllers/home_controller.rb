class HomeController < ApplicationController
  def index
  end

  def login
    session[:id] = params[:id]
    session[:pw] = params[:pw]

    redirect_to '/output'
  end

  def output
    # 세션으로 로그인
    @use_id = session[:id]
    @use_pw = session[:pw]

    # 크롬 드라이버 환경설정
    Selenium::WebDriver::Chrome.driver_path = '/Users/p/Desktop/private/chromedriver'
    driver = Selenium::WebDriver.for :chrome
    driver.navigate.to "http://everytime.kr/timetable"

    # 로그인
    id = driver.find_element(name: 'userid').send_keys @use_id
    pw = driver.find_element(name: 'password')
    pw.send_keys @use_pw
    pw.submit

    # 팝업 정리
    sleep(3)
    close = driver.find_element(xpath: "//*[@id='sheet']/ul/li[3]/a").click
    sleep(3)
    btn = driver.find_element(xpath: "//*[@id='container']/ul/li[1]").click
    sleep(3)

    # college, major 경로 설정
    x = 1
    y = 1
    z = 1
    info = Info.new

    college_xpath = "//*[@id='subjects']/form/ol[2]/li[#{x}]"
    major_xpath = "//*[@id='subjects']/form/ol[3]/li[#{y}]"

    college_btn = driver.find_element(xpath: college_xpath)
    college_btn.click
    sleep(1)
    major_btn = driver.find_element(xpath: major_xpath)

    college_size = driver.find_elements(xpath: "//*[@id='subjects']/form/ol[2]/li").size

    # 데이터 추출 loop
    while x <= college_size
      college_btn.click
      y=1
      major_xpath = "//*[@id='subjects']/form/ol[3]/li[#{y}]"
      major_btn = driver.find_element(xpath: major_xpath)

      major_size = driver.find_elements(xpath: "//*[@id='subjects']/form/ol[3]/li").size
      while y <= major_size
        major_btn.click
        sleep(3)
        z=1

        tr_size = driver.find_elements(xpath: "//*[@id='subjects']/div/table/tbody/tr").size
        while z <= tr_size
          info_xpath = "//*[@id='subjects']/div/table/tbody/tr[#{z}]/"

          info = Info.new

          info.subject_name = driver.find_element(xpath:info_xpath + "td[2]").text
          info.professor = driver.find_element(xpath:info_xpath + "td[3]").text
          info.time = driver.find_element(xpath:info_xpath + "td[4]").text
          info.place = driver.find_element(xpath:info_xpath + "td[5]").text

          info.save

          if z < tr_size
            info_xpath = "//*[@id='subjects']/div/table/tbody/tr[#{z+=1}]/"
          else
            z+=1
          end
        end

        if y < major_size
          major_xpath = "//*[@id='subjects']/form/ol[3]/li[#{y+=1}]"
          major_btn = driver.find_element(xpath: major_xpath)
        else
          y+=1
        end
        sleep(3)
      end
      if x < college_size
        college_xpath = "//*[@id='subjects']/form/ol[2]/li[#{x+=1}]"
        college_btn = driver.find_element(xpath: college_xpath)
      else
        x+=1
      end
      sleep(3)
    end

    driver.quit
    @all_info = Info.all
  end
end
