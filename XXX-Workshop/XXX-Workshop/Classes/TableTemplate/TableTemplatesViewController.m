//
//  TableTemplatesViewController.m
//  XXX-Workshop
//
//  Created by XXX on 8/14/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "TableTemplatesViewController.h"
#import "TableTemplates.h"

@interface TableTemplatesViewController ()<TableTemplateDataSource, UITableViewDelegate>

@end

@implementation TableTemplatesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    table.canLoadMore=true;
    table.canRefresh=true;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
