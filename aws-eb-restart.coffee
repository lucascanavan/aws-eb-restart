AWS = require 'aws-sdk'
config = require './config.json'
###
config.json "schema" needs to be as per the following example:
{ 
  "credentials": { "region": "ap-southeast-2", "accessKeyId": "", "secretAccessKey": "" },
  "sites": [ { "EnvironmentName": "" } ]
}
###

AWS.config.region = config.credentials.region
AWS.config.accessKeyId = config.credentials.accessKeyId
AWS.config.secretAccessKey = config.credentials.secretAccessKey

for site in config.sites
    elasticbeanstalk = new AWS.ElasticBeanstalk
    elasticbeanstalk.restartAppServer site, (err, data) =>
        console.log err, err.stack if err?
        console.log data if data?