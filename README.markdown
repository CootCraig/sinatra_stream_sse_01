# Sinatra application with server-sent events

One set of Celluloid thread objects generates events.
Another set of Celluloid thread objects pushes server-sent events.
A demo page shows live event streams.

## Tested on Linux/thin http/MRI Ruby 1.9.3p0/Firefox 7.01

~~~~~~~
thin --debug -R config.ru start
~~~~~~~

## Demo page, if you are running the application

[The demo page](/simple)

## Grab the code at github

[Github Repo](https://github.com/CootCraig/sinatra_stream_sse_01)

## Todo

* Run on Windows/JRuby - Would like to use Trinidad
* Test subscribers closing the event stream
* Host on Heroku

## Links

* [Server-sent events at w3.org](http://dev.w3.org/html5/eventsource/)
* [Using server-sent events at MDN](https://developer.mozilla.org/en/Server-sent_events/Using_server-sent_events)
* [thin - a Ruby web server](http://code.macournoyer.com/thin/)
* [Sinatra DSL for web applications](http://www.sinatrarb.com/intro)
* [Celluloid concurrent threaded objects](http://celluloid.github.com/)
* [Trinidad - Rackup applications run with Apache Tomcat](https://github.com/trinidad/trinidad)
