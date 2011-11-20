# Sinatra application with server-sent events

Use Celluloid thread objects that block receiving events.
Distribute the events to subscribers using Server-sent events.

## Tested on Linux with the thin http server

~~~~~~~
thin --debug -R config.ru start
~~~~~~~

Test with Firefox 7.01 browser.

## Demo page, if you are running the application

[The demo page](/simple)

## Grab the code at github

[Github Repo](https://github.com/CootCraig/sinatra_stream_sse_01)

## Todo

* Run on Windows/JRuby - Would like to use Trinidad

## Links

* [Server-sent events at w3.org](http://dev.w3.org/html5/eventsource/)
* [thin - a Ruby web server](http://code.macournoyer.com/thin/)
* [Sinatra DSL for web applications](http://www.sinatrarb.com/intro)
* [Celluloid concurrent threaded objects](http://celluloid.github.com/)
* [Trinidad - Rackup applications run with Apache Tomcat](https://github.com/trinidad/trinidad)
