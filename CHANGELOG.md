# Change Log #

## 0.9.2 & 0.9.3
- replaces use of deprecated method with new version

## 0.9.1
- Updates Licence file

## 0.9.0
- Updates Licence file
- Fixes a few issues with tests. Now 58 tests passing, 0 failing but may are disabled because they need to connect to a local host which is not set up on this machine
- Adds a bunch of documenting comments

## 0.8.0
- Adds +(NSDictionary*)parseQueryString:(NSString*)query to RDSHelper
- Refactors RDSHelper to be more class method focused. Adds class method versions of all methods, marks instance methods as deprecated
- Adds +(NSString*)wwwFormURLEncodedStringFromParameters:(NSDictionary*)params withOrderedKeys:(NSArray*)orderedKeys

## 0.7.0
- Adds additional methods to RDSNetworkConnectorInterface and implements then in RDSNetworkConnector. Methods are duplicates of the 3 existing methods with an additional parameter for specifying additionalHeaderFields
- Refactors RDSNetworkConnector so new methods are called by old methods with nil passed for additionalHeaderFields 
- Fixes some bugs

## [0.6.0]
- Add concrete RDSSubmission class

#### Example Project
- Add UI for trying out the library



## [0.5.0](https://bitbucket.org/kfxteam/rdsremotedatasolutions/commits/tag/0.5.0) 2016/...


## [0.4.0](https://bitbucket.org/kfxteam/rdsremotedatasolutions/commits/tag/0.4.0) 2016/10/30

#### Fixed 


#### Changes

#### Enhancements
- Add class RDSSubmissionStation
- Add class RDSScheduler
- Add class RDSResubmissionOperation
