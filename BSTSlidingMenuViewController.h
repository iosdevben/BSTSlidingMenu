//
//  BSTSlidingMenuViewController.h
//
//  Created by Ben Thomas on 5/04/13.
//

#import <UIKit/UIKit.h>

// The direction that the menu will slide when it opens. If your
// button is at the top of the screen, then you should set the opening
// direction to down
//
typedef NS_ENUM(NSInteger, BSTSlidingMenuOpeningDirection) {
  BSTSlidingMenuOpeningDirectionDown = 0,
  BSTSlidingMenuOpeningDirectionUp = 1,
  BSTSlidingMenuOpeningDirectionLeft = 2,
  BSTSlidingMenuOpeningDirectionRight = 3
};

// The alignment of menu to the button.
// If your button is in the top-left corner of the screen, then
// and you want the left side of the menu to be aligned with the
// left side of the button, use BSTSlidingMenuPintLocationLeft
//
typedef NS_ENUM(NSInteger, BSTSlidingMenuPinLocation) {
  BSTSlidingMenuPinLocationLeft = 0,
  BSTSlidingMenuPinLocationRight = 1,
  BSTSlidingMenuPinLocationTop = 2,
  BSTSlidingMenuPinLocationBottom = 3,
  BSTSlidingMenuPinLocationMiddle = 4
};

static const CGFloat BSTSlidingMenuDefaultAnimationDuration = 0.2f;
static const CGFloat BSTSlidingMenuDefaultAnimationDelay = 0.f;

@protocol BSTSlidingMenuDelegate

@required
// return the number of rows in the menu
- (NSInteger)numberOfRowsInMenu;

// return the size of the menu button
// defaults to 44 x 44
- (CGSize)buttonSize;

// return the width of the menu
// defaults to 100
- (NSInteger)menuWidth;

// provide a view containing the row at the given index
- (UIView *)viewForRowAtIndex:(NSInteger) index;

// the height of the row at the given index
- (CGFloat)heightForRowAtIndex:(NSInteger) index;

// By default, this closes the menu if closeMenuWhenRowSelected is set to YES
// and restarts the autoClose timer otherwise
// Make sure you call this if you want to do other stuff when a menu item is selected
@optional
- (void)didSelectRowAtIndex:(NSInteger) index;

@end

@interface BSTSlidingMenuViewController : UIViewController<BSTSlidingMenuDelegate>

// the delay to wait before animating the menu opening
// defaults to BSTSlidingMenuDefaultAnimationDelay
@property (nonatomic, assign) CGFloat animationDelay;

// the duration to animate the menu opening
// defaults to BSTSlidingMenuDefaultAnimationDuration
@property (nonatomic, assign) CGFloat animationDuration;

// the colors for the menu button
// default to white, gray, and light gray respectively
@property (nonatomic, strong) UIColor *buttonColor;
@property (nonatomic, strong) UIColor *buttonActiveColor;
@property (nonatomic, strong) UIColor *buttonHighlightColor;

// the colors for the text
// default to black
@property (nonatomic, strong) UIColor *buttonTextColor;
@property (nonatomic, strong) UIColor *buttonHighlightTextColor;
@property (nonatomic, strong) UIColor *buttonActiveTextColor;

// Here you can modify the position of button title label
@property (nonatomic) UIEdgeInsets buttonTitleInsets;

// the title for the button
@property (nonatomic, strong) NSString *buttonTitle;

// the font for the title
@property (nonatomic, strong) UIFont *buttonTitleFont;

// automatically close the menu as soon as a menu item is selected
// defaults to YES
@property (nonatomic, assign) BOOL closeMenuWhenRowSelected;

// the background color of the header, to hide the menu when it slides away
// defaults to an ugly green so you don't forget to set this
@property (nonatomic, strong) UIColor *headerBackgroundColor;

// the direction to open the menu
// defaults to down
@property (nonatomic, assign) BSTSlidingMenuOpeningDirection openingDirection;

// How the button and menu are aligned
// defaults to BSTSlidingMenuPinLocationLeft
@property (nonatomic, assign) BSTSlidingMenuPinLocation pinLocation;

// the menu will close after the period specified by timerLength if it's greater than 0
// defaults to 0
@property (nonatomic, assign) NSTimeInterval timerLength;

@end
