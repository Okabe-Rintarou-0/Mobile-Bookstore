import random
from time import sleep
from typing import List

import requests
from bs4 import BeautifulSoup

USER_AGENTS = [
    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; AcooBrowser; .NET CLR 1.1.4322; .NET CLR 2.0.50727)",
    "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; Acoo Browser; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.04506)",
    "Mozilla/4.0 (compatible; MSIE 7.0; AOL 9.5; AOLBuild 4337.35; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)",
    "Mozilla/5.0 (Windows; U; MSIE 9.0; Windows NT 9.0; en-US)",
    "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Win64; x64; Trident/5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET CLR 2.0.50727; Media Center PC 6.0)",
    "Mozilla/5.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET CLR 1.0.3705; .NET CLR 1.1.4322)",
    "Mozilla/4.0 (compatible; MSIE 7.0b; Windows NT 5.2; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.2; .NET CLR 3.0.04506.30)",
    "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN) AppleWebKit/523.15 (KHTML, like Gecko, Safari/419.3) Arora/0.3 (Change: 287 c9dfb30)",
    "Mozilla/5.0 (X11; U; Linux; en-US) AppleWebKit/527+ (KHTML, like Gecko, Safari/419.3) Arora/0.6",
    "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.2pre) Gecko/20070215 K-Ninja/2.1.1",
    "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9) Gecko/20080705 Firefox/3.0 Kapiko/3.0",
    "Mozilla/5.0 (X11; Linux i686; U;) Gecko/20070322 Kazehakase/0.4.5",
    "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.8) Gecko Fedora/1.9.0.8-1.fc10 Kazehakase/0.5.6",
    "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.56 Safari/535.11",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) AppleWebKit/535.20 (KHTML, like Gecko) Chrome/19.0.1036.7 Safari/535.20",
    "Opera/9.80 (Macintosh; Intel Mac OS X 10.6.8; U; fr) Presto/2.9.168 Version/11.52",
    "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.11 TaoBrowser/2.0 Safari/536.11",
    "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.71 Safari/537.1 LBBROWSER",
    "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; LBBROWSER)",
    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; QQDownload 732; .NET4.0C; .NET4.0E; LBBROWSER)",
    "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.84 Safari/535.11 LBBROWSER",
]


class BookInfo:
    covers: List[str] = []
    title: str = ""
    author: str = ""
    price: int = 0
    org_price: int = 0
    sales: int = 0

    def to_sql(self) -> str:
        return f"insert into book (title, author, sales, covers, price, orgPrice) VALUES ('{self.title}', '{self.author}', {self.sales}, '{str.join(' ', self.covers)}', {self.price}, {self.org_price});"

    def __repr__(self):
        return f'covers: {self.covers}\ntitle: {self.title}\nauthor: {self.author}\nprice: {self.price}\noriginal' \
               f'price: {self.org_price}'


def crawl_for_keyword(keyword: str, sql_list: List[str]):
    try:
        urls = get_book_urls_by_keyword(keyword)
    except Exception as e:
        print(e)
        return
    print(urls)
    for url in urls:
        try:
            sleep(2)
            b = get_book_info(url)
            print(f"crawl book: {b}")
            sql_list.append(b.to_sql())
        except Exception as e:
            print(e)


def get_book_urls_by_keyword(keyword: str) -> List[str]:
    headers = {
        'User-Agent': random.choice(USER_AGENTS),
        'Connection': 'keep-alive',
        'Accept-Language': 'zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2',
    }
    url = f"http://search.dangdang.com/?key={keyword}&act=input"
    response = requests.get(url, headers=headers)
    bs = BeautifulSoup(response.text, features='lxml')
    results = bs.find_all(attrs={"class": "pic", "dd_name": "单品图片"})

    return [f'http:{result.get("href")}' for result in results]


def get_book_infos_by_keyword(keyword: str) -> List[BookInfo]:
    books = []
    headers = {
        'User-Agent': random.choice(USER_AGENTS),
        'Connection': 'keep-alive',
        'Accept-Language': 'zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2',
    }
    url = f"http://search.dangdang.com/?key={keyword}&act=input"
    response = requests.get(url, headers=headers)
    bs = BeautifulSoup(response.text, features='lxml')
    bs.prettify()
    # print(bs)
    results = bs.find_all(attrs={"class": "pic", "dd_name": "单品图片"})
    # print(results)
    for result in results:
        try:
            li = result.parent
            b = BookInfo()
            cover_ele = li.find("img")
            cover = cover_ele.get("src")
            if cover == "images/model/guan/url_none.png":
                cover = cover_ele.get("data-original")
            b.covers = [f'http:{cover}']

            title_ele = li.find("a", attrs={"dd_name": "单品标题"})
            b.title = title_ele.get("title").strip().replace("'", r"\'")

            price_ele = li.find("span", attrs={"class": "search_now_price"})
            b.price = int(float(price_ele.getText().strip().replace('¥', '')) * 100)

            org_price_ele = li.find("span", attrs={"class": "search_pre_price"})
            b.org_price = int(
                float(org_price_ele.getText().strip().replace('¥', '')) * 100) if org_price_ele is not None else b.price

            author_ele = li.find("a", attrs={"dd_name": "单品作者"})
            b.author = author_ele.get("title").strip().replace("'", r"\'")
            books.append(b)
            print(f'save book:\n{b}')
        except Exception as e:
            print(e)
    return books


def get_book_info(url: str) -> BookInfo:
    headers = {
        'Referer': url,
        'User-Agent': random.choice(USER_AGENTS),
        'Connection': 'keep-alive',
        'Accept-Language': 'zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2',
    }
    b = BookInfo()
    response = requests.get(url, headers=headers)
    bs = BeautifulSoup(response.text, features='lxml')
    author_ele = bs.find("a", attrs={"dd_name": "作者"})
    b.author = author_ele.getText()

    price_ele = bs.find("p", attrs={"id": "dd-price"})
    price_txt: str = price_ele.getText()
    price_txt = price_txt.replace('¥', '').strip()
    b.price = int(float(price_txt) * 100)

    org_price_ele = bs.find("div", attrs={"class": "price_m", "id": "original-price"})
    org_price_txt: str = org_price_ele.getText()
    org_price_txt = org_price_txt.replace('¥', '').strip()
    b.org_price = int(float(org_price_txt) * 100)

    title_ele = bs.find("h1", attrs={"title": True})
    b.title = title_ele.get("title")
    slider_ele = bs.find("ul", attrs={"id": "main-img-slider"})
    results = slider_ele.find_all("a", attrs={"data-imghref": True})
    b.covers = str.join(" ", [f'http:{result.get("data-imghref")}' for result in results])

    return b


if __name__ == '__main__':
    sql_list = []
    for keyword in ["flutter", "Python", "Golang", "C++", "C", "Rust", "Java", "Javascript", "Typescript", "C#",
                    "Docker"]:
        print(f'crawl for keyword: {keyword}...')
        sleep(0.5)
        books = get_book_infos_by_keyword(keyword)
        for b in books:
            sql_list.append(b.to_sql())
    sql = str.join("\n", sql_list)
    with open("result.sql", 'w', encoding='utf-8') as f:
        f.write(sql)
