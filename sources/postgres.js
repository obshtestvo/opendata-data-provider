'use strict';

var postgres = require('pg');

var PostgreSQLSource = function(params) {
    this.getData = function(callback) {
        var postgresDsn = "postgres://" + params.username + ":" + params.password + "@" + params.host + "/" + params.database;
        var client = new postgres.Client(postgresDsn);
        client.connect(function(err) {
            if(err) return callback(err);

            client.query(params.query, function(err, result) {
                if(err) return callback(err);

                callback(null, result.rows);
                client.end();
            });
        });
    };
};

module.exports = PostgreSQLSource;