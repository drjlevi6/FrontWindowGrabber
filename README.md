# FrontWindowGrabber

FrontWindowGrabber is project containing a JavaScript for Automation (JXA) script that takes a screenshot of a macOS desktop, then crops it to show only the frontmost application's frontmost window. It needs to be run in the background, using either Apple's Shortcuts application or a third-party app such as FastScripts 3 ([https://redsweater.com/fastscripts/](https://redsweater.com/fastscripts/)).

## Requirements

- macOS
- FrontWindowGrabber's script file `cropScreenShotToFrontmostWindow.jxa.scpt`
- The open-source ImageMagick suite ([https://imagemagick.org/](https://imagemagick.org/)).

## Installation
- Install ImageMagick (if necessary).

- Create a folder $HOME/tmp.

- Clone the GitHub repository FrontWindowGrabber ([https://github.com/drjlevi6/FrontWindowGrabber](https://github.com/drjlevi6/FrontWindowGrabber)) or download the file `cropScreenShotToFrontmostWindow.jxa.scpt` from the same repository.

- Two possible next steps: Either

1. Using Apple's Shortcuts app: (a) Create a shortcut of category "Scripting", double-click sub-menu item "Run JavaScript for Mac Automation", and paste the contents of `cropScreenShotToFrontmostWindow.jxa.scpt`into it; in Shortcuts's "All Shortcuts" window, rename this shortcut to your liking; using System Settings > Keyboard > Keyboard Shortcuts > App Shortcuts, add a shortcut either to All Applications or any other application, typing your shortcut's new name into the Menu Title field; assign a keyboard shortcut, or
2. Using FastScripts: In the FastScripts settings, open or create a folder that FastScripts can see; drag `cropScreenShotToFrontmostWindow.jxa.scpt`into it; assign a keyboard shortcut.

## Running the Shortcut

When you type the keyboard shortcut you assigned (with the assigned application frontmost, if you assigned the shortcut to a specific application), the script will

1. Note which application is frontmost;
2. Compute the size and position of the frontmost app's frontmost window;
3. Create a screenshot of the computer's entire screen storing it as a PNG file with a title derived from the day's date, in the $HOME/tmp
4. Using InageMagick's `convert`, crop the saved PNG file to a new file in $HOME/tmp. The new file's name will be derived from the original file's name, with the suffix ".png" changed to "-cropped.png".

## Notes

`cropScreenShotToFrontmostWindow.jxa.scpt`computes the cropped window size and position by doubling the script's initial size and position. This is because JXA computes size and position assuming a pixel density of 72 dpi; however, the computer is assumed to have a Retina display at 144 dpi. (If your computer has a different display density, for example a Liquid Retina XDR display (254 dpi) the script will need to be modified accordingly.)

## Author

Jonathan Levi ([drjlevi6@aol.com](drjlevi6@aol.com))
