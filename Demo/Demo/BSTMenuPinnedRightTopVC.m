//
//  BSTMenuPinnedRightTop.m
//  Demo
//
//  Created by Ben Thomas on 11/05/13.
//  Copyright (c) 2013 Ben Thomas. All rights reserved.
//

#import "BSTMenuPinnedRightTopVC.h"

@interface BSTMenuPinnedRightTopVC ()

@end

@implementation BSTMenuPinnedRightTopVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    self.pinLocation = BSTMenuPinLocationRight;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
