# Java Crawler

**java-crawler**

Tool to use selenium to crawl the web pages. Push helping JavaScript to browser that helps to collect data.
Collect data (mostly text, their 2D location at page, ...)

Uses (depends on) Selenium HUB and FF as node.

Some helper scripts were made in setmy-info-scripts project, to help inside running Docker container download soft,
install it under root and drop sudo possibility and run under restricted user.

The Goal is to get text data with coordinates and send it to API/microservice to be saved in DB.

Consider to use:

* [mitmproxy](https://mitmproxy.org/)
* [BrowserMob Proxy - looks old](https://github.com/lightbody/browsermob-proxy)
