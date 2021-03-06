

/**********************************************************************
 *
 Copyright (c) 2016 Christian Fox <christianfox890@icloud.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 *
 **********************************************************************/




#import "KFXLogFilesMasterTVC.h"
// Pods
#import <KFXLog/KFXLog.h>
#import <KFXLog/KFXLogConfigurator.h>
#import <KFXLog/KFXFileLogDescriptor.h>
// VCs
#import "KFXLogFileDetailVC.h"
// Cells
#import "KFXLogFileTVCell.h"

@interface KFXLogFilesMasterTVC ()
@property (strong,nonatomic) NSArray *tableData;

@end

@implementation KFXLogFilesMasterTVC


//======================================================
#pragma mark - ** Public Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - UIViewController
//--------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Log Files";
    [self configureTableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.tableData = nil;
}

//--------------------------------------------------------
#pragma mark - Actions
//--------------------------------------------------------





//======================================================
#pragma mark - ** Protocol Methods **
//======================================================

//--------------------------------------------------------
#pragma mark - UITableViewDataSource
//--------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KFXLogFileTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogFileNameCell" forIndexPath:indexPath];
    
    // Work out file path of log file
    KFXFileLogDescriptor *fileLogDescriptor = [KFXLogConfigurator sharedConfigurator].fileLogDescriptor;
    NSString *fileName = self.tableData[indexPath.row];
    NSString *filePath = [fileLogDescriptor.directoryPath stringByAppendingPathComponent:fileName];
    NSFileManager *fileMan = [NSFileManager defaultManager];
    if ([fileMan fileExistsAtPath:filePath]) {
        NSDictionary *attributes = [fileMan attributesOfItemAtPath:filePath error:nil];
        NSDate *creationDate = attributes[NSFileCreationDate];
        NSDate *modificationDate = attributes[NSFileModificationDate];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterMediumStyle];
        
        cell.fileNameLabel.text = fileName;
        cell.creationDateLabel.text = [NSString stringWithFormat:@"Created: %@",[formatter stringFromDate:creationDate]];
        cell.modificationDateLabel.text = [NSString stringWithFormat:@"Modified: %@",[formatter stringFromDate:modificationDate]];
    }
    
    return cell;
}

//--------------------------------------------------------
#pragma mark - UITableViewDelegate
//--------------------------------------------------------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // Work out file path of log file
    KFXFileLogDescriptor *fileLogDescriptor = [KFXLogConfigurator sharedConfigurator].fileLogDescriptor;
    NSString *fileName = self.tableData[indexPath.row];
    NSString *filePath = [fileLogDescriptor.directoryPath stringByAppendingPathComponent:fileName];
    
    // pass path to dest
    KFXLogFileDetailVC *dest = [[KFXLogFileDetailVC alloc]init];
    [dest injectLogFilePath:filePath];
    
    [self.navigationController showViewController:dest sender:self];
    

}




//======================================================
#pragma mark - ** Private Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - Configure
//--------------------------------------------------------
-(void)configureTableView{
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.0f;
    
    [self.tableView registerClass:[KFXLogFileTVCell class]
           forCellReuseIdentifier:@"LogFileNameCell"];
}



//--------------------------------------------------------
#pragma mark - Lazy Load
//--------------------------------------------------------
-(NSArray *)tableData{
    if (!_tableData) {
        
        NSFileManager *fileMan = [NSFileManager defaultManager];
        KFXFileLogDescriptor *fileLogDescriptor = [KFXLogConfigurator sharedConfigurator].fileLogDescriptor;
        BOOL isDir;
        if ([fileMan fileExistsAtPath:fileLogDescriptor.directoryPath isDirectory:&isDir]) {
            if (isDir) {
                
                NSError *error;
                NSArray *contents = [fileMan contentsOfDirectoryAtPath:fileLogDescriptor.directoryPath
                                                                 error:&error];
                if (contents.count == 0) {
                    if (error != nil) {
                        [KFXLog logError:error sender:self];
                    }
                }else{
                    
                    NSMutableArray *mutContents = [NSMutableArray arrayWithCapacity:contents.count ];
                    
                    for (NSString *fileName in contents.reverseObjectEnumerator.allObjects) {
                        if (![fileName containsString:@"sqlite"]) {
                            [mutContents addObject:fileName];
                        }
                    }
                    
                    _tableData = [mutContents copy];
                }
            }
        }else{
            [KFXLog logFail:@"No directory found for file logs at path : %@",fileLogDescriptor.directoryPath];
        }
        
        
    }
    return _tableData;
}




//======================================================
#pragma mark - ** Navigation **
//======================================================
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

@end
