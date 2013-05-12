//
//  BSTSharingMenu.m
//  Demo
//
//  Created by Ben Thomas on 10/05/13.
//  Copyright (c) 2013 Ben Thomas. All rights reserved.
//
#import <Social/Social.h>

#import "BSTSharingMenu.h"

@interface BSTSharingMenu ()

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;

@property (nonatomic, strong) UITapGestureRecognizer *label1TapRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *label2TapRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *label3TapRecognizer;

@end

@implementation BSTSharingMenu

static const NSInteger kButtonWidth = 50;
static const NSInteger kButtonHeight = 44;
static const NSInteger kRowHeight = 40;
static const NSInteger kMenuPadding = 10.f;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // configure the menu button
    self.buttonTextColor = [UIColor colorWithRed:.9f green:.88f blue:.82f alpha:1.f];
    self.buttonTitle = @"Share";
    self.buttonTitleInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    self.buttonColor = [UIColor colorWithRed:.08f green:.11f blue:.20f alpha:1.f];
    self.buttonActiveColor = [UIColor colorWithRed:.21f green:.33f blue:.68f alpha:1.f];
    self.buttonActiveTextColor = [UIColor colorWithRed:1.f green:.97f blue:.98f alpha:1.f];
    self.headerBackgroundColor = [UIColor colorWithRed:.08f green:.11f blue:.20f alpha:1.f];

    self.label1TapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(facebookTapped)];
    self.label2TapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twitterTapped)];
    self.label3TapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weiboTapped)];
    
    self.timerLength = 2;
  }
  return self;
}

-(void)viewDidLoad
{
  [super viewDidLoad];

  [self.label1 addGestureRecognizer:self.label1TapRecognizer];
  [self.label2 addGestureRecognizer:self.label2TapRecognizer];
  [self.label3 addGestureRecognizer:self.label3TapRecognizer];
}

#pragma mark - BSTMenuDelegate methods

// return the number of rows in the menu
- (NSInteger)numberOfRowsInMenu
{
  return 3;
}

// return the size of the menu button
// defaults to 44 x 44
// here I'm just overriding the height but I could override the width if desired
- (CGSize)buttonSize
{
  return CGSizeMake([super buttonSize].width, kButtonHeight);
}

// return the width of the menu
// defaults to 100
- (NSInteger)menuWidth
{
  return CGRectGetWidth(self.label1.frame) + 2 * kMenuPadding;
}

// provide a view containing the row at the given index
- (UIView *)viewForRowAtIndex:(NSInteger) index
{
  if (index == 0)
  {
    if (nil == self.label1)
    {
      self.label1 = [[UILabel alloc] initWithFrame:CGRectZero];
      self.label1.userInteractionEnabled = YES;
      self.label1.text = @"Facebook";
      [self.label1 sizeToFit];
      CGRect label1 = self.label1.frame;
      label1.origin.x = kMenuPadding;
      label1.size.height = CGRectGetHeight(self.label1.frame) + 2 * kMenuPadding;
      self.label1.frame = label1;
    }
    return self.label1;
  }
  else if (index == 1)
  {
    if (nil == self.label2)
    {
      self.label2 = [[UILabel alloc] initWithFrame:CGRectZero];
      self.label2.userInteractionEnabled = YES;
      self.label2.text = @"Twitter";
      [self.label2 sizeToFit];
      CGRect label2 = self.label2.frame;
      label2.origin.x = kMenuPadding;
      label2.size.height = CGRectGetHeight(self.label2.frame) + 2 * kMenuPadding;
      self.label2.frame = label2;
    }
    return self.label2;
  }
  else
  {
    if (nil == self.label3)
    {
      self.label3 = [[UILabel alloc] initWithFrame:CGRectZero];
      self.label3.userInteractionEnabled = YES;
      self.label3.text = @"Weibo";
      [self.label3 sizeToFit];
      CGRect label3 = self.label3.frame;
      label3.origin.x = kMenuPadding;
      label3.size.height = CGRectGetHeight(self.label3.frame) + 2 * kMenuPadding;
      self.label3.frame = label3;
    }
    return self.label3;
  }
}

// the height of the row at the given index
- (CGFloat)heightForRowAtIndex:(NSInteger) index
{
  if (index == 0)
  {
    return CGRectGetHeight(self.label1.frame);
  }
  else if (index == 1)
  {
    return CGRectGetHeight(self.label2.frame);
  }
  else
  {
    return CGRectGetHeight(self.label3.frame);
  }
}

#pragma mark - menu tap handlers

- (void)facebookTapped
{
  [self didSelectRowAtIndex:0];
  
  [self share:SLServiceTypeFacebook];
}

- (void)twitterTapped
{
  [self didSelectRowAtIndex:1];
  
  [self share:SLServiceTypeTwitter];
}

- (void)weiboTapped
{
  [self didSelectRowAtIndex:2];
  
  [self share:SLServiceTypeSinaWeibo];
}

- (void)share:(NSString *)serviceType
{
  SLComposeViewController *shareSheet = [SLComposeViewController composeViewControllerForServiceType:serviceType];
  
  [shareSheet setInitialText:@"Check out BSTSlidingMenu on @github by @PHATRS. http://github.com/benst/BSTSlidingMenu"];

  if (nil == shareSheet)
  {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Weibo accounts" message:@"There are no Weibo accounts configured in Settings. You need to enable a Chinese keyboard first." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
    [alertView show];
  } else {
    [self presentViewController:shareSheet animated:YES completion:nil];
  }
}


@end
