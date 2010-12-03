//
//  mtgox_status_itemAppDelegate.m
//  mtgox status item
//
//  Created by bill on 8/1/11.
//

/* This program is free software. It comes without any warranty, to
 * the extent permitted by applicable law. You can redistribute it
 * and/or modify it under the terms of the Do What The Fuck You Want
 * To Public License, Version 2, as published by Sam Hocevar. See
 * http://sam.zoy.org/wtfpl/COPYING for more details. */

#import "mtgox_status_itemAppDelegate.h"
#import "SBJson.h"

@implementation mtgox_status_itemAppDelegate

@synthesize window;

#define UPDATE_INTERVAL 90.0

- (IBAction)openSite:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://mtgox.com/"]];
}

- (IBAction)shutdown:(id)sender {
    [httpTimer invalidate];
    httpTimer = nil;
    exit(0);
}

- (void)updateRate {
    NSURLRequest *urlRequest = [NSURLRequest
                                requestWithURL:[NSURL URLWithString:@"https://mtgox.com/api/0/ticker.php"]
                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                timeoutInterval:30.0];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection
                    sendSynchronousRequest:urlRequest
                    returningResponse:&response
                    error:&error];

    // Request failed for some reason
    if(error) {
        [statusItem setTitle:@"BTC --.--"];
        return;
    }
    
    // JSON looks like:
    // {"ticker":{"high":14.8999,"low":12.87,"avg":13.483069313,"vwap":13.65105773,"vol":33597,"last":13.26,"buy":13.27235,"sell":13.3}}
    
    NSString *jsonString = [[NSString alloc]
                            initWithData:data
                            encoding:NSUTF8StringEncoding];
    NSDictionary *jsonDictionary = [jsonString JSONValue];
    NSDictionary *tickerDictionary = [jsonDictionary objectForKey:@"ticker"];
    NSString *avgString = [tickerDictionary objectForKey:@"avg"];
    NSString *formattedString = [NSString stringWithFormat:@"BTC: %.2f", [avgString doubleValue]];

    
    [statusItem setTitle:formattedString];
}

- (void)timedUpdateRate:(NSTimer *)theTimer {
    [self updateRate];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self updateRate];
    httpTimer = [NSTimer
                 scheduledTimerWithTimeInterval:UPDATE_INTERVAL
                 target:self
                 selector:@selector(timedUpdateRate:)
                 userInfo:nil
                 repeats:YES];
}

- (void)awakeFromNib {
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
    [statusItem setMenu:statusMenu];
    [statusItem setTitle:@"Loading..."];
    [statusItem setHighlightMode:YES];
}

@end
