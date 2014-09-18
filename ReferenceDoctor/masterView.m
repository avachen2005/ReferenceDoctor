//
//  masterView.m
//  ReferenceDoctor
//
//  Created by Ava Chen on 9/15/14.
//  Copyright (c) 2014 chens. All rights reserved.
//

#import "masterView.h"

#define TEXT_BOX_HEIGHT             30

@interface masterView ()

@property (nonatomic, strong) NSOpenPanel *openPanel;
@property (nonatomic, strong) NSTextField *header;
@property (nonatomic, strong) NSTextField *fullFileName;
@property (nonatomic, strong) NSButton *openButton;
@property (nonatomic, strong) NSButton *goButton;

@end

@implementation masterView

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:[self getHeader:@"Welcome to Reference Doc"]];
        [self addSubview:[self getFullFileName:@"abc"]];
        [self addSubview:[self getOpenButton:@"檔案"]];
    }
    
    return self;
}

- (NSTextField *)getHeader:(NSString *)headerText
{
    self.header = [[NSTextField alloc] initWithFrame:CGRectMake(0,
                                                                self.bounds.size.height-TEXT_BOX_HEIGHT,
                                                                self.bounds.size.width, TEXT_BOX_HEIGHT)];
    self.header.stringValue = headerText;
    [self.header setBezeled:NO];
    [self.header setDrawsBackground:NO];
    [self.header setEditable:NO];
    [self.header setSelectable:NO];
    [self.header setAlignment:NSCenterTextAlignment];
    [self.header setFont:[NSFont fontWithName:@"Baskerville-BoldItalic" size:25.0]];
    [self.header setTextColor:[NSColor blueColor]];
    
    return self.header;
}

- (NSTextField *)getFullFileName:(NSString *)text
{
    self.fullFileName = [[NSTextField alloc] initWithFrame:CGRectMake( 50,
                                                                       self.bounds.size.height - TEXT_BOX_HEIGHT * 3,
                                                                      300, TEXT_BOX_HEIGHT)];
    self.fullFileName.wantsLayer = YES;
    self.fullFileName.layer.borderWidth = 2.0;
    self.fullFileName.layer.cornerRadius = 5.0;
    self.fullFileName.layer.borderColor = [NSColor clearColor].CGColor;
    self.fullFileName.stringValue = @"";
    self.fullFileName.layer.backgroundColor = [NSColor clearColor].CGColor;
    [self.fullFileName.cell setUsesSingleLineMode:YES];
    [self.fullFileName.cell setWraps:NO];
    [self.fullFileName.cell setScrollable:YES];
    
    return self.fullFileName;
}

- (NSButton *)getOpenButton:(NSString *)text
{
    NSImage *image = [NSImage imageNamed:@"open_file.png"];
    NSImage *resizedImage = [self resizeImage:image size:CGSizeMake(25, 25)];
    
    
    self.openButton = [[NSButton alloc] initWithFrame:CGRectMake( self.fullFileName.frame.origin.x + self.fullFileName.frame.size.width +  15,
                                                                 self.bounds.size.height - TEXT_BOX_HEIGHT * 3, 80, 33)];
    [self.openButton setImagePosition:NSImageRight];
    [self.openButton setImage:resizedImage];
    [self.openButton setTitle:text];
    [self.openButton setAction:@selector(openButtonPressed)];
    [self.openButton setTarget:self];
    return self.openButton;
}
     
- (NSImage*) resizeImage:(NSImage*)sourceImage size:(NSSize)size
{
    
    NSRect targetFrame = NSMakeRect(0, 0, size.width, size.height);
    NSImage* targetImage = nil;
    NSImageRep *sourceImageRep =
    [sourceImage bestRepresentationForRect:targetFrame
                                   context:nil
                                     hints:nil];
    
    targetImage = [[NSImage alloc] initWithSize:size];
    
    [targetImage lockFocus];
    [sourceImageRep drawInRect: targetFrame];
    [targetImage unlockFocus];
    
    return targetImage;
}

- (void) openButtonPressed
{
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    
    [openPanel setCanChooseDirectories:YES];
    [openPanel setCanChooseFiles:YES];
    [openPanel setAllowedFileTypes:@[@"xml"]];
    [openPanel beginWithCompletionHandler:^(NSInteger result) {
        NSLog(@"%@", openPanel.URL);
        self.fullFileName.stringValue = [NSString stringWithFormat:@"%@", [openPanel.URLs firstObject]];
    }];
}

@end
