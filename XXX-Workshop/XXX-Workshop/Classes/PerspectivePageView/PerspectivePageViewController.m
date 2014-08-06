//
//  PerspectivePageViewController.m
//  XXX-Workshop
//
//  Created by XXX on 8/5/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "PerspectivePageViewController.h"
#import "PerspectivePageView.h"

@interface PerspectivePageViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation PerspectivePageViewController

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
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)btnAirbnbEffectTouchUpInside:(id)sender
{
    [perspectiveView showRearViewWithAnimation:PERSPECTIVE_VIEW_TYPE_AIRBNB_EFFECT];
}

-(IBAction)btnNoEffectTouchUpInside:(id)sender
{
    [perspectiveView showRearViewWithAnimation:PERSPECTIVE_VIEW_TYPE_NO_ANIMATION];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        
        cell.textLabel.textColor=[UIColor blackColor];
    }
    
    cell.textLabel.text=tableView==tableFront?[NSString stringWithFormat:@"front %02i",indexPath.row]:[NSString stringWithFormat:@"rear %02i",indexPath.row];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectZero];
    lbl.backgroundColor=[UIColor whiteColor];
    lbl.textColor=[UIColor blackColor];
    lbl.text=tableView==tableRear?[NSString stringWithFormat:@"rear section %02i",section]:[NSString stringWithFormat:@"front section %02i",section];
    return lbl;
}

@end
