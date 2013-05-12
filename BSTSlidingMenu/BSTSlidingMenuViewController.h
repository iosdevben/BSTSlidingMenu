//
//  BSTSlidingMenuViewController.h
//
//  Created by Ben Thomas on 5/04/13.
//


/** The direction that the menu will slide when it opens. If your
 *  button is at the top of the screen, then you should set the opening
 *  direction to down.
 *
 */
typedef NS_ENUM(NSInteger, BSTSlidingMenuOpeningDirection) {
  BSTSlidingMenuOpeningDirectionDown = 0,
  BSTSlidingMenuOpeningDirectionUp = 1,
  BSTSlidingMenuOpeningDirectionLeft = 2,
  BSTSlidingMenuOpeningDirectionRight = 3
};

/** The alignment of menu to the button.
 *  If your button is in the top-left corner of the screen,
 *  and you want the left side of the menu to be aligned with the
 *  left side of the button, use BSTSlidingMenuPintLocationLeft.
 *
 */
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


/** Returns the number of rows in the menu
 *
 *  @returns the number of rows in the menu.
 */
- (NSInteger)numberOfRowsInMenu;

/** Return the size of the menu button
 *  default value is 44 x 44
 *  
 *  @returns the size of the menu button
 */
- (CGSize)buttonSize;

/** Return the width of the menu
 *  default value is 100
 *
 *  @returns the witdh of the menu
 */
- (NSInteger)menuWidth;


/** Allows you to provide a view containing the row at a given index
 *
 *  @param an index
 *  @returns a view containing the row at a given index
 */
- (UIView *)viewForRowAtIndex:(NSInteger)index;


/** Returns the height of the row at a given index
 *
 *  @param an index
 *  @returns the hiehgt of the row at a given index
 */
- (CGFloat)heightForRowAtIndex:(NSInteger)index;

@optional

/** By default this closes the menu if closeMenuWhenRowSelected is set to YES
 *  and restarts the autoClose timer otherwise.
 *
 *  Make sure you call this if you want to perform other actions when a
 *  menu item is selected.
 *
 *  @param an index
 */
- (void)didSelectRowAtIndex:(NSInteger)index;

@end

@interface BSTSlidingMenuViewController : UIViewController<BSTSlidingMenuDelegate>

/** The delay to wait before animating the menu opening
 *  default value is BSTSlidingMenuDefaultAnimationDelay
 */
@property (nonatomic, assign) CGFloat animationDelay;

/** The duration to animate the menu opening
 *  default value is BSTSlidingMenuDefaultAnimationDuration
 */
@property (nonatomic, assign) CGFloat animationDuration;

/** the colours for the menu button
 *  default to white, gray, and light gray respectively
 */
@property (nonatomic, strong) UIColor *buttonColor;
@property (nonatomic, strong) UIColor *buttonActiveColor;
@property (nonatomic, strong) UIColor *buttonHighlightColor;

/** The colours for the text
 *  default value is black
 */
@property (nonatomic, strong) UIColor *buttonTextColor;
@property (nonatomic, strong) UIColor *buttonHighlightTextColor;
@property (nonatomic, strong) UIColor *buttonActiveTextColor;

/** Use this to modify the position of button title label
 *
 */
@property (nonatomic) UIEdgeInsets buttonTitleInsets;

/** The title for the button
 *
 */
@property (nonatomic, strong) NSString *buttonTitle;

/** The font for the title
 *
 */
@property (nonatomic, strong) UIFont *buttonTitleFont;

/** automatically close the menu as soon as a menu item is selected
 *  default value is YES
 */
@property (nonatomic, assign) BOOL closeMenuWhenRowSelected;

/** The background colour of the header, to hide the menu when it slides away
 *  defaults to an ugly green
 *
 *  NOTE: Don't forget to set this!
 */
@property (nonatomic, strong) UIColor *headerBackgroundColor;

/** The direction to open the menu
 *  default value is BSTSlidingMenuOpeningDirectionDown
 */
@property (nonatomic, assign) BSTSlidingMenuOpeningDirection openingDirection;

/** How the button and menu are aligned
 *  defaults to BSTSlidingMenuPinLocationLeft
 */
@property (nonatomic, assign) BSTSlidingMenuPinLocation pinLocation;

/** The menu will close after the period specified by timerLength if it's greater than 0
 *  default value is 0
 */
@property (nonatomic, assign) NSTimeInterval timerLength;

@end
