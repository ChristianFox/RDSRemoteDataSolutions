# RDSRemoteDataSolutions

[![Version](https://img.shields.io/cocoapods/v/RDSRemoteDataSolutions.svg?style=flat)](http://cocoapods.org/pods/RDSRemoteDataSolutions)
[![License](https://img.shields.io/cocoapods/l/RDSRemoteDataSolutions.svg?style=flat)](http://cocoapods.org/pods/RDSRemoteDataSolutions)
[![Platform](https://img.shields.io/cocoapods/p/RDSRemoteDataSolutions.svg?style=flat)](http://cocoapods.org/pods/RDSRemoteDataSolutions)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

RDSRemoteDataSolutions is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RDSRemoteDataSolutions"
```

## Submissions and the SubmissionStation

The principle idea is that of Submissions and a SubmissionStation. 

A Submission is an object which encapsulates data for submission to a URL API of some description. A Submission is defined by the RDSSubmissionInterface protocol and so any object can be a Submission.

A SubmissionStation receives Submissions via the method -submitSubmission:withCompletionBlock: and accepts any object that conforms to the RDSSubmissionInterface protocol.
The SubmissionStation will attempt to unpack the data in the Submission object and send the appropriate data to the destinationURL specified in a fairly standard manner - by default using NSURLSession etc. Once the process is complete the completionBlock will be called and the standard NSData, NSURLResponse and NSError objects will be made available to the SubmissionStation's client.

What makes the SubmissionStation cool is what happens when the submission fails to send for any reason for example a lack of network connectivity. In this circumstance the SubmissionStation will still call the completionBlock and provide the client with the NSError etc but it will also archive the Submission object and fire up a Scheduler object which will periodically attempt to submit the data again until it succeeds.

## Network Connector
Another cool feature is the RDSNetworkConnectorInterface protocol. This defines the interface for an object which will do the final sending of data to the URL. By default RDS uses an  RDSNetworkConnector object which uses the standard NSURLSession block based API for sending data but if you prefer to use something like AFNetworking you can create your own class which conforms to RDSNetworkConnectorInterface and uses that as an argument when creating the RDSSubmissionStation instance.


## Author

Christian Fox, christianfox@kfxtech.com

## License

RDSRemoteDataSolutions is available under the MIT license. See the LICENSE file for more info.
