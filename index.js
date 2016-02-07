'use strict';

var _ = require('underscore');
var config = require('config');
var processors = require('./processors');


var datasets = config.get('datasets');
_.each(datasets, function(dataset) {
    processors.dataset.process(dataset.parameters, function(err, datasetId) {
        processors.resource.processMany(datasetId, dataset.resources, function(err) {
            if(err) return console.error(err);
        })
    })
});