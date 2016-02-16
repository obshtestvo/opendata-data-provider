'use strict';

var fs = require('fs');
var csv = require('csv-parse');

var CsvSource = function(params) {
    this.getData = function(callback) {
        fs.readFile(params.file, 'utf8', function (err,data) {
            if (err) return callback(err);
            csv(data, {'columns':true}, function(err, data){
                if (err) return callback(err);
                callback(null, data);
            });
        });
    };
};

module.exports = CsvSource;