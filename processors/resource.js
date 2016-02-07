'use strict';

var _ = require('underscore');
var ckan = require('ckan');
var config = require('config');
var sources = require('../sources');

var client = new ckan.Client(config.get('ckanUrl'), config.get('apiKey'));

var processMany = function (datasetId, resources, callback) {
    client.action('dataset_show', { id: datasetId }, function(err, response) {
        if (err) return callback(err);

        _.each(resources, function(resource) {
            var remoteResource = _.findWhere(response.result.resources, {name: resource.name});
            var Source = sources[resource.source];
            var source = new Source(resource);
            source.getData(function(err, records) {
                if(remoteResource) {
                    console.log("Existing resource. Commencing datastore_upsert.");
                    client.action('datastore_upsert', {
                        resource_id: remoteResource.id,
                        name: resource.name,
                        method: 'upsert',
                        records: records
                    }, function(err, response) {
                        callback();
                    });
                } else {
                    console.log("Non-existing resource. Commencing resource_create.");
                    client.action('resource_create', {
                        package_id: datasetId,
                        name: resource.name,
                        url: "http://ckan.org/",
                        url_type: "datastore"
                    }, function(err, response) {
                        if (err) return callback(err);

                        console.log("Resource created. Commencing datastore_create.");
                        var resourceId = response.result.id;
                        client.action('datastore_create', {
                            resource_id: resourceId,
                            records: records
                        }, function (err, result) {
                            callback();
                        })
                    });
                }
            })
        });
    });
};

module.exports = {
    processMany: processMany
};