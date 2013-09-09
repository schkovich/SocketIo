
/**
 * Module dependencies.
 */
'use strict';

(function () {
    var express = require('express'),
        routes = require('./routes'),
        user = require('./routes/user'),
        http = require('http'),
        path = require('path'),
        webServer = express();

    webServer.configure(function () {
        webServer.set('port', process.env.PORT || 80);
        webServer.set('views', __dirname + '/views');
        webServer.set('view engine', 'jade');
        webServer.use(express.favicon());
        webServer.use(express.logger('dev'));
        webServer.use(express.bodyParser());
        webServer.use(express.methodOverride());
        webServer.use(webServer.router);
        webServer.use(express.static(path.join(__dirname, 'public')));
    });

    webServer.configure('development', function () {
        webServer.use(express.errorHandler());
    });

    webServer.get('/', routes.index);
    webServer.get('/users', user.list);

    http.createServer(webServer).listen(webServer.get('port'), function () {
        console.log("Express server listening on port "
            + webServer.get('port'));
    });
}());