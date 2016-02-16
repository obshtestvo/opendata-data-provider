'use strict';

var mysql = require('mysql');

var MySQLSource = function(params) {
    var mysqlConnection = mysql.createConnection({
        host     : params.host,
        user     : params.username,
        password : params.password,
        database : params.database
    });
    mysqlConnection.connect();

    this.getData = function(callback) {
        mysqlConnection.query(params.query, function(err, rows, fields) {
            if (err) throw err;
            callback(null, rows);
        });
        mysqlConnection.end();
    };
};

module.exports = MySQLSource;