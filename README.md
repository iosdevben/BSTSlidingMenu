BSTSlidingMenu
==============

An iOS component that displays a button and a menu that slides out from under the button.

Currently supports buttons being placed at the top or bottom of a view.

The slide-out menu can be configured to be pinned to the left or right side of the button.

The menu can optionally be configured to be close automatically after a given period of time.

*Used in apps:*

&nbsp;&nbsp;http://appstore.com/HarkenForiPhone

Screenshots
-----------
![alt text](https://lh4.googleusercontent.com/-4-HeqUOxjpA/UY8BBbHt59I/AAAAAAAAC7o/b6yOGQYNuf8/w298-h600-no/1.png "menus closed")
![alt text](https://lh4.googleusercontent.com/-jWsM0l1ds2Y/UY8BB1MxkWI/AAAAAAAAC7s/eaqS5sGbOYc/w298-h600-p-o/2.png "menus opened")


Usage
-----

See the demo project for examples of menu pinning and opening direction.

Note that BSTSlidingMenu must be added as the last subview otherwise the menus won't receive taps.

Known Issues
------------

Does not work in a UINavigationBar because the menu gets drawn outside the bounds of the navigation bar and won't receive touches.

ARC
---

BSTSlidingMenu is ARC only.

Support
-------

BSTSlidingMenu is provided open source with no warranty and no guarantee of support. However, best effort is made to address issues raised on Github https://github.com/benst/BSTSlidingMenu/issues.

