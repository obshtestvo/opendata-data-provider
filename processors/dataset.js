'use strict';

var ckan = require('ckan');
var config = require('config');
var client = new ckan.Client(config.get('ckanUrl'), config.get('apiKey'));

module.exports = {
    process: function(dataset, callback) {
        client.action('dataset_show', { id: dataset.name }, function(err, result) {
            if (!err) return callback(null, result.result.id);

            console.log("Non-existing dataset. Commencing dataset_create");
            client.action('dataset_create', dataset, function(err, result) {
                if(err) callback(err);
                callback(null, result.result.id);
            });
        });
    }
};