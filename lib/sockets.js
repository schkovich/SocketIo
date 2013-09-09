/**
 * Short description of
 * Version: $Id$
 * Author: Goran Miskovic <goran.miskovic at orchard-software.net>
 */
"use strict";

exports.init = function (server, conncet, config) {
    var io = require('socket.io'),
        onConnection,
        onRequests,
        authorization,
        listener;

    onConnection = function (client) {
        console.info('connection created.');
    };
    onRequests = function () {
        console.info('request event');
    };
    authorization = function () {
        console.info('handle connection');
    };

    listener = io.listent(server);

    listener.sockets.on('connection', onConnection);
    listener.set('request', onRequests);
    listener.set('authorization', authorization);
};