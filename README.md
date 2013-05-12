BSTSlidingMenu
==============

An iOS component that displays a button and a menu that slides out from under the button.

Currently supports buttons being placed at the top or bottom of a view.

The slide-out menu can be configured to be pinned to the left or right side of the button.

The menu can optionally be configured to be close automatically after a given period of time.

*Used in apps:*

&nbsp;&nbsp;http://appstore.com/HarkenForiPhone

<img src="https://github.com/jessedc/BSTSlidingMenu/raw/master/BSTSScreenshot.png" alt="BSTSSliding Menu Demo" width="749" />

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



Licence
-------

The code is copyright (c) 2013, Ben Thomas
All rights reserved.

* Redistribution and use in source and binary forms, with or without 
 modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright 
 notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright 
 notice, this list of conditions and the following disclaimer in the 
 documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY 
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
