//
//  AppDelegate.m
//  ReferenceDoctor
//
//  Created by Ava Chen on 9/15/14.
//  Copyright (c) 2014 chens. All rights reserved.
//

#import "AppDelegate.h"
#import "masterView.h"

@interface AppDelegate ()
            
@property (weak) IBOutlet NSWindow *window;
@property (strong, nonatomic) masterView *masterView;

@end

@implementation AppDelegate
            
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    self.masterView = [[masterView alloc] initWithFrame:((NSView *)self.window.contentView).bounds];
    [self.masterView setFrame:((NSView *)self.window.contentView).bounds];
    [self.window.contentView addSubview:self.masterView];
    [self.window setMaxSize:self.window.frame.size];
    [self.window setMinSize:self.window.frame.size];
    
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
