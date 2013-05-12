//
//  BSTSlidingMenuViewController.m
//  Simple Media Player
//
//  Created by Ben Thomas on 5/04/13.
//
//

#import "BSTSlidingMenuViewController.h"

@interface BSTSlidingMenuViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *menu;
@property (nonatomic, strong) NSMutableArray *rows;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) id<BSTSlidingMenuDelegate> delegate;

@end

@implementation BSTSlidingMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.animationDelay = BSTSlidingMenuDefaultAnimationDelay;
      self.animationDuration = BSTSlidingMenuDefaultAnimationDuration;
      
      self.buttonColor = [UIColor darkGrayColor];
      self.buttonActiveColor = [UIColor grayColor];
      self.buttonHighlightColor = [UIColor grayColor];
      
      self.buttonTextColor = [UIColor whiteColor];
      self.buttonActiveTextColor = [UIColor blackColor];
      self.buttonHighlightTextColor = [UIColor lightGrayColor];

      self.buttonTitleInsets = UIEdgeInsetsMake(0, 0, 0, 0);
      self.buttonTitleFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];
      
      self.buttonTitle = @"X";

      self.closeMenuWhenRowSelected = YES;
      
      self.delegate = self;
      
      self.headerBackgroundColor = [UIColor greenColor];
      
      self.openingDirection = BSTSlidingMenuOpeningDirectionDown;
      
      self.pinLocation = BSTSlidingMenuPinLocationLeft;
    
      self.rows = [NSMutableArray array];      

      self.timerLength = 0;
      self.timer = [NSTimer timerWithTimeInterval:self.timerLength target:self selector:@selector(close) userInfo:nil repeats:NO];
    }
    return self;
}

- (void)loadView
{
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
  view.clipsToBounds = NO;
  
  self.headerView = [[UIView alloc] initWithFrame:view.bounds];
  self.headerView.backgroundColor = self.headerBackgroundColor;

  self.button = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.button setBackgroundColor:self.buttonColor];
  [self.button setTitleColor:self.buttonTextColor forState:UIControlStateNormal];
  [self.button setTitleColor:self.buttonHighlightTextColor forState:UIControlStateHighlighted];
  [self.button setTitle:self.buttonTitle forState:UIControlStateNormal];
  self.button.titleLabel.font = self.buttonTitleFont;
  self.button.contentEdgeInsets = self.buttonTitleInsets;
  [self.button sizeToFit];
  
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
    
  CGRect viewFrame = self.view.frame;
  viewFrame.size.height = [self buttonSize].height;
  viewFrame.size.width = MAX([self buttonSize].width, menuWidth);
  self.view.frame = viewFrame;
 
  CGRect buttonFrame = self.button.frame;
  buttonFrame.size = [self buttonSize];
  
  if (self.pinLocation == BSTSlidingMenuPinLocationRight)
  {
    buttonFrame.origin.x = CGRectGetMaxX(self.view.bounds) - CGRectGetWidth(buttonFrame);
  }
  
  self.button.frame = buttonFrame;
  
  CGRect headerFrame = self.headerView.frame;
  headerFrame.size.width = CGRectGetWidth(viewFrame);
  headerFrame.size.height = CGRectGetHeight(buttonFrame);
  

  CGRect menuFrame = self.menu.frame;
  menuFrame.size = CGSizeMake(menuWidth, menuHeight);
  if (self.pinLocation == BSTSlidingMenuPinLocationRight)
  {
    menuFrame.origin.x = CGRectGetMaxX(self.button.frame) - CGRectGetWidth(menuFrame);
  }
  else if (self.pinLocation == BSTSlidingMenuPinLocationLeft)
  {
    menuFrame.origin.x = 0;
  }
  
  if (BSTSlidingMenuOpeningDirectionDown == self.openingDirection)
  {
    menuFrame.origin.y = CGRectGetMaxY(self.button.frame) - CGRectGetHeight(menuFrame);
  }
  else if (BSTSlidingMenuOpeningDirectionUp == self.openingDirection)
  {
    menuFrame.origin.y = CGRectGetMinY(self.button.frame);
    headerFrame.origin.y = CGRectGetMinY(self.button.frame);
  }
  
  self.menu.frame = menuFrame;
  self.headerView.frame = headerFrame;

  [self.button addTarget:self action:@selector(menuButtonTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillLayoutSubviews
{
  NSArray *rows = self.menu.subviews;
  UIView *previous = nil;
  for (NSInteger rowIndex = 0; rowIndex < [self.delegate numberOfRowsInMenu]; ++rowIndex)
  {
    UIView *row = [rows objectAtIndex:(NSUInteger)rowIndex];

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
  }
  else
  {
    [self open];
  }
}

- (void)close
{
  [self.timer invalidate];
  
  CGRect menuFrame = self.menu.frame;
  CGRect menuFrameFinal = self.menu.frame;
  
  CGRect buttonFrame = self.button.frame;
  CGRect headerFrame = self.headerView.frame;
  CGRect viewFrame = self.view.frame;
  
  switch (self.openingDirection)
  {
    case BSTSlidingMenuOpeningDirectionLeft:
    {
      menuFrame.origin.x = CGRectGetMinX(self.button.frame);
      break;
    }
    case BSTSlidingMenuOpeningDirectionRight:
    {
      menuFrame.origin.x = CGRectGetMaxX(self.button.frame) - CGRectGetWidth(menuFrame);
      break;
    }
    case BSTSlidingMenuOpeningDirectionUp:
    {
      menuFrame = self.menu.frame;
      menuFrame.origin.y = CGRectGetMinY(buttonFrame);
      
      menuFrameFinal.origin.y = 0;

      viewFrame.origin.y += CGRectGetHeight(menuFrame);
      viewFrame.size.height = [self buttonSize].height;

      buttonFrame = self.button.frame;
      buttonFrame.origin.y = 0;
      
      headerFrame.origin.y = buttonFrame.origin.y;

      break;
    }
    case BSTSlidingMenuOpeningDirectionDown:
    default:
    {
      viewFrame.size.height = [self buttonSize].height;
      menuFrame.origin.y = [self buttonSize].height - [self menuHeight];
      menuFrameFinal = menuFrame;
      break;
    }
  }

  [UIView animateWithDuration:self.animationDuration delay:self.animationDelay options:UIViewAnimationOptionCurveEaseInOut animations:^{
    self.menu.frame = menuFrame;
    self.button.backgroundColor = self.buttonColor;
    [self.button setTitleColor:self.buttonTextColor forState:UIControlStateNormal];
  } completion:^(BOOL finished) {
#pragma unused(finished)
    self.menu.hidden = YES;
    self.view.frame = viewFrame;
    self.button.frame = buttonFrame;
    self.headerView.frame = headerFrame;
    self.menu.frame = menuFrameFinal;
  }];
}

- (void)open
{
  CGRect menuFrame = self.menu.frame;
  CGRect menuFrameFinal = menuFrame;
  
  CGRect viewFrame = self.view.frame;
  CGRect buttonFrame = self.button.frame;
  
  CGRect headerFrame = self.headerView.frame;
  
  switch (self.openingDirection)
  {
    case BSTSlidingMenuOpeningDirectionLeft:
    {
      menuFrame.origin.x = CGRectGetMinX(self.button.frame) - CGRectGetWidth(menuFrame);
      break;
    }
    case BSTSlidingMenuOpeningDirectionRight:
    {
      menuFrame.origin.x = CGRectGetMaxX(self.button.frame);
      break;
    }
    case BSTSlidingMenuOpeningDirectionUp:
    {
      viewFrame.origin.y -= CGRectGetHeight(menuFrame);
      viewFrame.size.height = [self buttonSize].height + CGRectGetHeight(menuFrame);
      self.view.frame = viewFrame;
      
      menuFrameFinal = self.menu.frame;
      menuFrameFinal.origin.y = 0;
      
      menuFrame.origin.y = CGRectGetMaxY(viewFrame) - CGRectGetHeight(buttonFrame);
      self.menu.frame = menuFrame;
      
      buttonFrame.origin.y = CGRectGetHeight(menuFrame);
      
      headerFrame.origin.y = buttonFrame.origin.y;
      
      break;
    }
    case BSTSlidingMenuOpeningDirectionDown:
    default:
    {
      viewFrame.size.height = [self buttonSize].height + [self menuHeight];
      self.view.frame = viewFrame;
      menuFrameFinal = self.menu.frame;
      menuFrameFinal.origin.y = CGRectGetMaxY(self.button.bounds);
      break;
    }
  }

  self.menu.hidden = NO;
  self.button.frame = buttonFrame;
  self.headerView.frame = headerFrame;
  
  [UIView animateWithDuration:self.animationDuration delay:self.animationDelay options:UIViewAnimationOptionCurveEaseInOut animations:^{
    self.menu.frame = menuFrameFinal;
    self.button.backgroundColor = self.buttonActiveColor;
    [self.button setTitleColor:self.buttonActiveTextColor forState:UIControlStateNormal];
  } completion:^(BOOL finished) {
#pragma unused(finished)
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

#pragma mark - BSTSlidingMenuDelegate methods

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
  return CGSizeMake(CGRectGetWidth(self.button.frame), 44);
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
#pragma unused(index)
  return 44.f;
}

- (void)didSelectRowAtIndex:(NSInteger)index
{
#pragma unused(index)
  if (self.closeMenuWhenRowSelected)
  {
    [self close];
  }
  else
  {
    [self startTimer];
  }
}

@end
