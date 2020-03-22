import pandas as pd
from bs4 import BeautifulSoup
import time, re, requests,sys
import datetime

class Daily_boxoffice():
  """
  # Crawling the box office data in Korea Film Council class
  # Author : Gwangjin jeong
  # Modified Date : 20.03.22
  # Description
  - input 
  -- year, month, day, mode
  --- mode = 1 : 전체를 다 불러온다.
  --- mode = 2 : top 10만 불러온다.
  - output
  -- tupel (date,[[Information of ranking 1], [Information of ranking 2] ... ])   
  """
  def __init__(self, year,month,day,mode):
    self.year = year
    self.month = month
    self.day = day
    self.mode = mode
    self.base_url = "http://www.kobis.or.kr/kobis/business/stat/boxs/findDailyBoxOfficeList.do?loadEnd=0&searchType=search&sSearchFrom="
    self.all_data = []
    
    if (now.year == year) & (now.month == month) & (now.day == day):
      return 'error'
    elif now.year == year:
      self._mon_range = range(1,now.month)
    else:
      self._mon_range = range(1,13)

  def cleanText(self,text):
    remove_space = re.sub(re.compile(r'\s+'), '', text)
    remove_word1 = re.sub('[동일,New]','',remove_space)
    remove_word2 = re.sub('([0-9]+)상승','',remove_word1)
    remove_word3 = re.sub('([0-9]+)하락','',remove_word2)
    return remove_word3

  def get_movie_data(self):
    tag_body_top10 = self.soup.find('tbody', attrs={'id': 'tbody_0'})
    tag_body_else = self.soup.findAll('tbody')
    if self.mode == 1: # Top 110
      for tbody in tag_body_else:
        for value in tbody.findAll('td'):
          self.all_data.append(self.cleanText(value.text))
    elif self.mode == 2: # Top 10
      for value in tag_body_top10.findAll('td'):
        self.all_data.append(self.cleanText(value.text))

  def slicing_list(self,lst,n):
    divide = int(len(lst)/n)
    return [lst[start:start+divide] for start in range(0,len(lst),divide)]

  def getWebPage(self):
    url = base_url+str(self.year)+"-" + str(self.month).zfill(2)+"-" + str(self.day).zfill(2) + "&sSearchTo="+str(self.year)+"-"+str(self.month).zfill(2)+"-" + str(self.day).zfill(2)    
    source_code = requests.get(url)
    plain_text = source_code.text
    self.soup = BeautifulSoup(plain_text, 'html.parser' )
    date = str(self.year)+"-" + str(self.month).zfill(2)+"-" + str(self.day).zfill(2)
    # daily
    print(f'Downloading boxoffice at {date}....') # 일자
    # movie ranking
    self.get_movie_data()
    if self.mode == 1:
      return (date, self.slicing_list(self.all_data,110))
    elif self.mode == 2:
      return (date, self.slicing_list(self.all_data,10))
