//
//  BSTDemoViewController.m
//  Demo
//
//  Created by Ben Thomas on 10/05/13.
//  Copyright (c) 2013 Ben Thomas. All rights reserved.
//

#import "BSTDemoViewController.h"
#import "BSTSharingMenu.h"

@interface BSTDemoViewController ()

@property (nonatomic, strong) BSTSharingMenu *sharingMenuVC;

@end

@implementation BSTDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.sharingMenuVC = [[BSTSharingMenu alloc] initWithNibName:nil bundle:nil];
    
    [self addChildViewController:self.sharingMenuVC];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor darkGrayColor];
  
  [self.view addSubview:self.sharingMenuVC.view];
}

@end
