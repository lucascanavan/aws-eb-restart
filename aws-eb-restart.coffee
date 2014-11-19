AWS = require 'aws-sdk'
config = require './config.json'
###
config.json "schema" needs to be as per the following example:
{ 
  "credentials": { "region": "ap-southeast-2", "accessKeyId": "", "secretAccessKey": "" },
  "applications": [ { "ApplicationName": "" } ]
}
###

AWS.config.region = config.credentials.region
AWS.config.accessKeyId = config.credentials.accessKeyId
AWS.config.secretAccessKey = config.credentials.secretAccessKey

elasticbeanstalk = new AWS.ElasticBeanstalk
for application in config.applications
    console.log "About to restart application #{application.ApplicationName}..."
    elasticbeanstalk.describeEnvironments application, (err, response) =>
        console.log err, err.stack if err?
        if response?
            for environment in response.Environments
                console.log "About to restart environment #{environment.EnvironmentName}..."
                elasticbeanstalk.restartAppServer { EnvironmentName: environment.EnvironmentName }, (err, response) =>
                    console.log err, err.stack if err?
                    console.log response if response?