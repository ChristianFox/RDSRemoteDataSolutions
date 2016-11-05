


#import "DEMOViewController.h"
// Pods
#import <RDSRemoteDataSolutions/RDSRemoteDataSolutions.h>
#import <KFXAdditions/UIAlertController+KFXAdditions.h>
// Demo classes
#import "DEMOLoggingDelegate.h"


@interface DEMOViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *paramKeyTextField;
@property (weak, nonatomic) IBOutlet UITextField *paramValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *URLTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *contentTypeSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *HTTPMethodSegmentedControl;
@property (weak, nonatomic) IBOutlet UISwitch *shouldRescheduleSwitch;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *submissionResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *pendingSubmissionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastResubmissionAttemptLabel;
@property (strong,nonatomic) RDSSubmissionStation *submissionStation;
@property (strong,nonatomic) DEMOLoggingDelegate *loggingDelegate;
@end

@implementation DEMOViewController



//======================================================
#pragma mark - ** Public Methods **
//======================================================

//--------------------------------------------------------
#pragma mark - Inject Dependencies
//--------------------------------------------------------


//--------------------------------------------------------
#pragma mark - Actions
//--------------------------------------------------------
- (IBAction)contentTypeSegmentedControlDidChange:(id)sender {
    
    
}

- (IBAction)HTTPMehtodSegmentedControlDidChange:(id)sender {
}


- (IBAction)submitSubmissionButtonTapped:(id)sender {
    
    self.submissionResultLabel.text = @"Submission Result";
    
    NSString *key = self.paramKeyTextField.text;
    NSString *value = self.paramValueTextField.text;
    NSDictionary *params;
    
    RDSSubmissionContentType contentType = RDSSubmissionContentTypeUndefined;
    if (key.length == 0 || value.length == 0) {
        contentType = RDSSubmissionContentTypeNone;
    }else if (self.contentTypeSegmentedControl.selectedSegmentIndex == 0){
        contentType = RDSSubmissionContentTypeWWWURLEncodedString;
        params = @{key:value};
    }else if (self.contentTypeSegmentedControl.selectedSegmentIndex == 1){
        contentType = RDSSubmissionContentTypeJSONData;
        params = @{key:value};
    }
    
    NSString *HTTPMethod;
    if (self.HTTPMethodSegmentedControl.selectedSegmentIndex == 0) {
        HTTPMethod = @"POST";
        if (params == nil) {
            UIAlertController *alert = [UIAlertController kfx_alertControllerWithTitle:@"ERROR"
                                                                               message:@"You need to send some paramters for a POST request - try using GET or adding a key and a value!"
                                                                     singleButtonTitle:@"Yeah I know!"];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    }else{
        HTTPMethod = @"GET";
        if (params != nil) {
            UIAlertController *alert = [UIAlertController kfx_alertControllerWithTitle:@"ERROR"
                                                                               message:@"You cannot send parameters for a GET request - try using POST or removing deleting the key & value."
                                                                     singleButtonTitle:@"Yeah I know!"];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    }
    
    NSURL *url = [NSURL URLWithString:self.URLTextField.text];
    if (url == nil) {
        
        UIAlertController *alert = [UIAlertController kfx_alertControllerWithTitle:@"ERROR"
                                                                           message:@"You need to enter a valid URL"
                                                                 singleButtonTitle:@"Yeah I know!"];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    RDSSubmission *submission = [RDSSubmission submission];
    submission.parameters = params;
    submission.submissionContentType = contentType;
    submission.HTTPMethod = HTTPMethod;
    submission.destinationURL = url;
    submission.shouldScheduleForResubmissionOnFailure = self.shouldRescheduleSwitch.isOn;
    
    
    NSLog(@"*****************************\n Will submit submission with Content-Type: %ld, HTTP Method: %@, URL: %@, Params: %@, \n Will reschedule: %d",(long)submission.submissionContentType,submission.HTTPMethod,submission.destinationURL,submission.parameters,submission.shouldScheduleForResubmissionOnFailure);
    
    [self.submissionStation submitSubmission:submission
                              withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        
        NSString *resultMessage;
        if ([(NSHTTPURLResponse*)response statusCode] != 200) {
            if (error != nil) {
                resultMessage = [NSString stringWithFormat:@"ERROR: status code is %ld with Error: %@",(long)[(NSHTTPURLResponse*)response statusCode],error.localizedDescription];
            }else{
                resultMessage = [NSString stringWithFormat:@"FAIL: status code is %ld ",(long)[(NSHTTPURLResponse*)response statusCode]];
            }
        }else{
            
            if (data == nil) {
                if (error != nil) {
                    resultMessage = [NSString stringWithFormat:@"ERROR: Data is nil with error %@",error.localizedDescription];
                }else{
                    resultMessage = @"No data was received but status code == 200 & no error was received";
                }
            }else{
                
                NSString *dataString = [[NSString alloc]initWithData:data
                                                            encoding:NSUTF8StringEncoding];
                if (dataString != nil) {
                    resultMessage = [NSString stringWithFormat:@"SUCCESS: %@",dataString];
                }else{
                    
                    NSError *jsonError;
                    @try {
                    
                        id json = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&jsonError];
                        if (json == nil) {
                            if (jsonError != nil) {
                                resultMessage = [NSString stringWithFormat:@"ERROR: Failed to read json from data with error: %@",jsonError.localizedDescription];
                            }else{
                                resultMessage = @"FAIL: Failed to read json from data for unknown reason";
                            }
                        }else{
                            resultMessage = [NSString stringWithFormat:@"SUCCESS: %@",json];

                        }
                        
                    } @catch (NSException *exception) {
                        
                        resultMessage = @"FAIL: Caught exception thrown by NSJSONSerialization";
                        
                    } @finally {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.submissionResultLabel.text = resultMessage;
                        });
                    }
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.submissionResultLabel.text = resultMessage;
        });

    
    }];
    
    
    
}



//======================================================
#pragma mark - ** Inherited Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - UIViewController
//--------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.submissionStation.loggingDelegate = self.loggingDelegate;
    [self registerForNotifications];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.shouldRescheduleSwitch.on = NO;
    NSString *urlString;
//#if DEBUG
//    urlString = @"http://localhost/~leu/rds_pod_backend_proxy/rds_main.php";
//#else
    urlString = @"http://kfxtech.com/appdata/rds_pod_backend_proxy/rds_main.php";
//#endif

    self.URLTextField.text = urlString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//--------------------------------------------------------
#pragma mark - UIResponder
//--------------------------------------------------------
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


//======================================================
#pragma mark - ** Protocol Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - UITextFieldDelegate
//--------------------------------------------------------
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}





//======================================================
#pragma mark - ** Private Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - Lazy Load
//--------------------------------------------------------
-(RDSSubmissionStation *)submissionStation{
    if (!_submissionStation) {
        _submissionStation = [RDSSubmissionStation defaultSubmissionStation];
    }
    return _submissionStation;
}

-(DEMOLoggingDelegate *)loggingDelegate{
    if (!_loggingDelegate) {
        _loggingDelegate = [[DEMOLoggingDelegate alloc]init];
    }
    return _loggingDelegate;
}


//--------------------------------------------------------
#pragma mark - Notifications
//--------------------------------------------------------
-(void)registerForNotifications{
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(didReceiveSubmissionStoredNotification:)
                                                name:kRDSSubmissionStoredForResubmissionNOTIFICATION
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(didReceiveShouldAttemptResubmissionNotification:)
                                                name:kRDSShouldAttemptResubmissionNOTIFICATION
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(didReceiveResubmissionProcessCompleteNotification:)
                                                name:kRDSResubmissionProcessCompleteNOTIFICATION
                                              object:nil];
    
}

-(void)didReceiveSubmissionStoredNotification:(NSNotification*)note{
    NSLog(@"<NOTE_RECEIVED>: %@",note.name);
    dispatch_async(dispatch_get_main_queue(), ^{
       
        NSUInteger count = [note.userInfo[kRDSPendingSubmissionsCountKEY]unsignedIntegerValue];
        self.pendingSubmissionsLabel.text = [NSString stringWithFormat:@"Pending Submissions: %lu",(unsigned long)count];
    });
}

-(void)didReceiveShouldAttemptResubmissionNotification:(NSNotification*)note{
 
    NSLog(@"<NOTE_RECEIVED>: %@",note.name);
}

-(void)didReceiveResubmissionProcessCompleteNotification:(NSNotification*)note{
    NSLog(@"<NOTE_RECEIVED>: %@",note.name);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        BOOL success = [note.userInfo[kRDSResubmissionResultKEY] boolValue];
        self.lastResubmissionAttemptLabel.text = [NSString stringWithFormat:@"Last Attempt: %@ at %@",
                                                  success?@"SUCCESS":@"FAILURE",[NSDate date]];
    });

}


//======================================================
#pragma mark - ** Navigation **
//======================================================
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}






@end


































