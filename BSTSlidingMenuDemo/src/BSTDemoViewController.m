//
//  BSTDemoViewController.m
//  Demo
//
//  Created by Ben Thomas on 10/05/13.
//  Copyright (c) 2013 Ben Thomas. All rights reserved.
//

#import "BSTDemoViewController.h"
#import "BSTMenuPinnedLeftTopVC.h"
#import "BSTMenuPinnedRightTopVC.h"
#import "BSTMenuPinnedLeftBottomVC.h"
#import "BSTMenuPinnedRightBottomVC.h"

@interface BSTDemoViewController ()

@property (nonatomic, strong) BSTMenuPinnedLeftBottomVC *leftBottomVC;
@property (nonatomic, strong) BSTMenuPinnedLeftTopVC *leftTopVC;
@property (nonatomic, strong) BSTMenuPinnedRightBottomVC *rightBottomVC;
@property (nonatomic, strong) BSTMenuPinnedRightTopVC *rightTopVC;

@end

@implementation BSTDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.leftBottomVC = [[BSTMenuPinnedLeftBottomVC alloc] initWithNibName:nil bundle:nil];
    self.leftTopVC = [[BSTMenuPinnedLeftTopVC alloc] initWithNibName:nil bundle:nil];
    self.rightBottomVC = [[BSTMenuPinnedRightBottomVC alloc] initWithNibName:nil bundle:nil];
    self.rightTopVC = [[BSTMenuPinnedRightTopVC alloc] initWithNibName:nil bundle:nil];
    
    [self addChildViewController:self.leftBottomVC];
    [self addChildViewController:self.leftTopVC];
    [self addChildViewController:self.rightBottomVC];
    [self addChildViewController:self.rightTopVC];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor colorWithRed:.08f green:.11f blue:.20f alpha:1.f];
  
  UILabel *title = [[UILabel alloc] initWithFrame:self.view.bounds];
  title.text = @"BSTSlidingMenu";
  title.font = [UIFont fontWithName:@"AmericanTypewriter-Light" size:30.f];
  title.textAlignment = NSTextAlignmentCenter;
  title.backgroundColor = [UIColor clearColor];
  title.textColor = [UIColor colorWithRed:1.f green:.97f blue:.98f alpha:1.f];
  title.shadowColor = [UIColor blackColor];
  title.shadowOffset = CGSizeMake(0, -1);
  [self.view addSubview:title];
  
  [self.view addSubview:self.leftBottomVC.view];
  [self.view addSubview:self.leftTopVC.view];
  [self.view addSubview:self.rightBottomVC.view];
  [self.view addSubview:self.rightTopVC.view];

  CGRect leftBottomFrame = self.leftBottomVC.view.frame;
  leftBottomFrame.origin.y = CGRectGetMaxY(self.view.bounds) - self.leftBottomVC.buttonSize.height;
  self.leftBottomVC.view.frame = leftBottomFrame;

  CGRect rightBottomFrame = self.rightBottomVC.view.frame;
  rightBottomFrame.origin.y = CGRectGetMaxY(self.view.bounds) - CGRectGetHeight(rightBottomFrame);
  rightBottomFrame.origin.x = CGRectGetMaxX(self.view.bounds) - CGRectGetWidth(rightBottomFrame);
  self.rightBottomVC.view.frame = rightBottomFrame;
  
  CGRect rightTopFrame = self.rightTopVC.view.frame;
  rightTopFrame.origin.x = CGRectGetMaxX(self.view.bounds) - CGRectGetWidth(rightTopFrame);
  self.rightTopVC.view.frame  = rightTopFrame;
}
@end
