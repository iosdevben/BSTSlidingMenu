//
//  BSTMenuViewController.m
//  Simple Media Player
//
//  Created by Ben Thomas on 5/04/13.
//
//

#import "BSTMenuViewController.h"

@interface BSTMenuViewController ()

- (void)menuButtonTapped;

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *menu;
@property (nonatomic, strong) NSMutableArray *rows;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) id<BSTMenuDelegate> delegate;

@end

@implementation BSTMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.animationDelay = BSTMenuDefaultAnimationDelay;
      self.animationDuration = BSTMenuDefaultAnimationDuration;
      
      self.buttonColor = [UIColor whiteColor];
      self.buttonActiveColor = [UIColor colorWithWhite:.9f alpha:1.f];
      self.buttonHighlightColor = [UIColor lightGrayColor];
      
      self.buttonTextColor = [UIColor blackColor];
      self.buttonActiveTextColor = [UIColor blackColor];
      self.buttonHighlightTextColor = [UIColor blackColor];

      self.buttonTitle = @"X";

      self.closeMenuWhenRowSelected = YES;
      
      self.delegate = self;
      
      self.headerBackgroundColor = [UIColor greenColor];
      
      self.openingDirection = BSTMenuOpeningDirectionDown;
      
      self.pinLocation = BSTMenuPinLocationLeft;
    
      self.rows = [NSMutableArray array];      

      self.timerLength = 0;
      self.timer = [NSTimer timerWithTimeInterval:self.timerLength target:self selector:@selector(close) userInfo:nil repeats:NO];
    }
    return self;
}

- (void)loadView
{
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
  view.clipsToBounds = YES;
  
  self.headerView = [[UIView alloc] initWithFrame:view.bounds];
  self.headerView.backgroundColor = self.headerBackgroundColor;

  self.button = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.button setBackgroundColor:self.buttonColor];
  [self.button setTitleColor:self.buttonTextColor forState:UIControlStateNormal];
  [self.button setTitleColor:self.buttonHighlightTextColor forState:UIControlStateHighlighted];
  [self.button setTitle:self.buttonTitle forState:UIControlStateNormal];
  self.button.titleLabel.font = self.buttonTitleFont;
  self.button.titleEdgeInsets = self.buttonTitleInsets;
  
  self.menu = [[UIView alloc] initWithFrame:CGRectZero];
  self.menu.backgroundColor = [UIColor whiteColor];
  self.menu.hidden = YES;
  self.menu.exclusiveTouch = NO;
  self.menu.clipsToBounds = YES;
  
  for (int i = 0; i < [self.delegate numberOfRowsInMenu]; ++i)
  {
    UIView *row = [self.delegate viewForRowAtIndex:i];
    row.exclusiveTouch = NO;
    [self.menu addSubview:row];
  }

  [view addSubview:self.menu];
  [view addSubview:self.headerView];
  [view addSubview:self.button];
  
  self.view = view;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  
  CGFloat menuWidth = [self menuWidth];
  CGFloat menuHeight = [self menuHeight];
    
  CGRect viewRect = self.view.frame;
  viewRect.size.height = [self buttonSize].height;
  viewRect.size.width = MAX([self buttonSize].width, menuWidth);
  self.view.frame = viewRect;
 
  CGRect button = self.button.frame;
  button.size = [self buttonSize];
  
//  CGRect viewRect = self.view.bounds;
  
  if (self.pinLocation == BSTMenuPinLocationRight)
    button.origin.x = CGRectGetMaxX(self.view.bounds) - CGRectGetWidth(button);
  
  self.button.frame = button;
  
  CGRect header = self.headerView.frame;
  header.size.width = CGRectGetWidth(viewRect);
  header.size.height = CGRectGetHeight(button);
  self.headerView.frame = header;
  

  CGRect menu = self.menu.frame;
  menu.size = CGSizeMake(menuWidth, menuHeight);
  if (self.pinLocation == BSTMenuPinLocationRight)
    menu.origin.x = CGRectGetMaxX(self.button.frame) - CGRectGetWidth(menu);
  else
    menu.origin.x = 0;
  
  menu.origin.y = CGRectGetMaxY(self.button.frame) - CGRectGetHeight(menu);
  self.menu.frame = menu;

  [self.button addTarget:self action:@selector(menuButtonTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillLayoutSubviews
{
  NSArray *rows = self.menu.subviews;
  UIView *previous = nil;
  for (int rowIndex = 0; rowIndex < [self.delegate numberOfRowsInMenu]; ++rowIndex) {
    UIView *row = [rows objectAtIndex:rowIndex];

    CGRect rowRect = row.frame;
    rowRect.origin.y = nil != previous ? CGRectGetMaxY(previous.frame) : 0;
    row.frame = rowRect;
    previous = row;
  }
  
}

- (void)menuButtonTapped
{
  if (!self.menu.hidden)
  {
    [self close];
//    [self.parentViewController.view sendSubviewToBack:self.menu];
  }
  else
  {
//    [self.parentViewController.view bringSubviewToFront:self.menu];
    [self open];
  }
}

- (void)close
{
  [self.timer invalidate];
  
  CGRect rect = self.menu.frame;
  CGRect viewRect = self.view.frame;
  
  switch (self.openingDirection)
  {
    case BSTMenuOpeningDirectionLeft:
    {
      rect.origin.x = CGRectGetMinX(self.button.frame);
      break;
    }
    case BSTMenuOpeningDirectionRight:
    {
      rect.origin.x = CGRectGetMaxX(self.button.frame) - CGRectGetWidth(rect);
      break;
    }
    case BSTMenuOpeningDirectionUp:
    {
      rect.origin.y = CGRectGetMinY(self.button.frame);
      viewRect.size.height = [self buttonSize].height;
      break;
    }
    case BSTMenuOpeningDirectionDown:
    default:
    {
      viewRect.size.height = [self buttonSize].height;
      rect.origin.y = [self buttonSize].height - [self menuHeight];
      break;
    }
  }

  [UIView animateWithDuration:self.animationDuration delay:self.animationDelay options:UIViewAnimationOptionCurveEaseInOut animations:^{
    self.menu.frame = rect;
    self.button.backgroundColor = self.buttonColor;
    [self.button setTitleColor:self.buttonTextColor forState:UIControlStateNormal];
  } completion:^(BOOL finished) {
    self.menu.hidden = YES;
    self.view.frame = viewRect;
  }];
}

- (void)open
{
  CGRect rect = self.menu.frame;
  CGRect viewRect = self.view.frame;

  switch (self.openingDirection)
  {
    case BSTMenuOpeningDirectionLeft:
    {
      rect.origin.x = CGRectGetMinX(self.button.frame) - CGRectGetWidth(rect);
      break;
    }
    case BSTMenuOpeningDirectionRight:
    {
      rect.origin.x = CGRectGetMaxX(self.button.frame);
      break;
    }
    case BSTMenuOpeningDirectionUp:
    {
      rect.origin.y = CGRectGetMinY(self.button.frame) - CGRectGetHeight(rect);
      viewRect.size.height = [self buttonSize].height + [self menuHeight];
      break;
    }
    case BSTMenuOpeningDirectionDown:
    default:
    {
      rect.origin.y = CGRectGetMaxY(self.button.bounds);
      viewRect.size.height = [self buttonSize].height + [self menuHeight];
      break;
    }
  }
  

  self.menu.hidden = NO;
  self.view.frame = viewRect;
  [UIView animateWithDuration:self.animationDuration delay:self.animationDelay options:UIViewAnimationOptionCurveEaseInOut animations:^{
    self.menu.frame = rect;
    self.button.backgroundColor = self.buttonActiveColor;
    [self.button setTitleColor:self.buttonActiveTextColor forState:UIControlStateNormal];
  } completion:^(BOOL finished) {
    [self startTimer];
  }];
}

- (void)startTimer
{
  if (self.timerLength > 0)
  {
    [self.timer invalidate];
    self.timer = [NSTimer timerWithTimeInterval:self.timerLength target:self selector:@selector(close) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
  }
}

#pragma mark - BSTMenuDelegate methods

- (NSInteger)menuHeight
{
  NSInteger height = 0;
  for (int rowIndex = 0; rowIndex < [self numberOfRowsInMenu]; ++rowIndex)
  {
    height += [self heightForRowAtIndex:rowIndex];
  }
  return height;
}

- (NSInteger)numberOfRowsInMenu
{
  return 3;
}

- (CGSize)buttonSize
{
  return CGSizeMake(44, 44);
}

- (NSInteger)menuWidth
{
  return 100;
}

- (UIView *)viewForRowAtIndex:(NSInteger)index
{
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self menuWidth], [self heightForRowAtIndex:index])];
  label.text = [NSString stringWithFormat:@"row %d", index];
  label.textAlignment = NSTextAlignmentCenter;
  return label;
}

- (CGFloat)heightForRowAtIndex:(NSInteger)index
{
  return 44;
}

- (void)didSelectRowAtIndex:(NSInteger)index
{
  if (self.closeMenuWhenRowSelected)
    [self close];
  else
    [self startTimer];
}

@end
