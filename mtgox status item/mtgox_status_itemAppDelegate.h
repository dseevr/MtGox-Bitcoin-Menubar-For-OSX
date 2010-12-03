//
//  mtgox_status_itemAppDelegate.h
//  mtgox status item
//
//  Created by bill on 8/1/11.
//

/* This program is free software. It comes without any warranty, to
 * the extent permitted by applicable law. You can redistribute it
 * and/or modify it under the terms of the Do What The Fuck You Want
 * To Public License, Version 2, as published by Sam Hocevar. See
 * http://sam.zoy.org/wtfpl/COPYING for more details. */

#import <Cocoa/Cocoa.h>

@interface mtgox_status_itemAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    IBOutlet NSMenu *statusMenu;
    NSStatusItem    *statusItem;
    NSTimer         *httpTimer;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)openSite:(id)sender;
- (IBAction)shutdown:(id)sender;

@end
