//
//  PhotoboothAppDelegate.m
//  Photobooth
//
//  Created by Charly Biteau on 17/07/2014.
//  Copyright (c) 2014 Charly Biteau. All rights reserved.
//

#import "PhotoboothAppDelegate.h"


#define DEFAULT_FRAMES_PER_SECOND	5.0

@implementation PhotoboothAppDelegate

@synthesize outputURL;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    frameDuration = CMTimeMakeWithSeconds(1. / DEFAULT_FRAMES_PER_SECOND, 90000);
    
    NSError *error = nil;
    
    /*CALayer *imageLayer = [previewCellView layer];
    [imageLayer setBackgroundColor:CGColorGetConstantColor(kCGColorBlack)];*/
    
    session = [AVCaptureSession new];
	[session setSessionPreset:AVCaptureSessionPresetPhoto];
    
    NSMenu *newMenu;
    NSMenuItem *newItem;
    
    // Add the submenu
    /*newItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:@"Caméra" action:NULL keyEquivalent:@""];
    newMenu = [[NSMenu allocWithZone:[NSMenu menuZone]] initWithTitle:@"Caméra"];
    [newItem setSubmenu:newMenu];
    [[NSApp mainMenu] insertItem:newItem atIndex:[[NSApp mainMenu] indexOfItemWithTitle:@"Help"]];*/
    
    // Add some tricky items
    Boolean initCam = FALSE;

    
	// Select a video device, make an input
	for (AVCaptureDevice *device in [AVCaptureDevice devices]) {
		if (([device hasMediaType:AVMediaTypeVideo] || [device hasMediaType:AVMediaTypeMuxed])
            ) {
           /* newItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:[device localizedName] action:NULL keyEquivalent:@""];
            [newItem setRepresentedObject:device];
            [newItem setTarget:self];
            [newItem setAction:@selector(changeCamera:)];
            [newMenu addItem:newItem];
            if(!initCam)
            {
                [newItem setState:NSOnState];*/
                
                AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
                if (error) {
                    [session release];
                    NSLog(@"deviceInputWithDevice failed with error %@", [error localizedDescription]);
                }
                if ([session canAddInput:input])
                    [session addInput:input];
                
               /* initCam = TRUE;
            }*/
            break;
		}
	}
    
	// Make a still image output
	stillImageOutput = [AVCaptureStillImageOutput new];
	if ([session canAddOutput:stillImageOutput])
		[session addOutput:stillImageOutput];
	
	// Make a preview layer so we can see the visual output of an AVCaptureSession
	previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
	[previewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
	[previewLayer setFrame:[previewView bounds]];
	[[previewLayer connection] setAutomaticallyAdjustsVideoMirroring:NO];
	[[previewLayer connection] setVideoMirrored:YES];
    
    // add the preview layer to the hierarchy
	CALayer *rootLayer = [previewView layer];
	[rootLayer setBackgroundColor:CGColorGetConstantColor(kCGColorBlack)];
	[rootLayer addSublayer:previewLayer];
	
    // start the capture session running, note this is an async operation
    // status is provided via notifications such as AVCaptureSessionDidStartRunningNotification/AVCaptureSessionDidStopRunningNotification
    [session startRunning];

}

- (void)changeCamera:(id)sender {

    AVCaptureDevice *device = [(NSMenuItem*) sender representedObject];
    
    NSError *error = nil;
    [session stopRunning];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        NSLog(@"deviceInputWithDevice failed with error %@", [error localizedDescription]);
    }
    if ([session canAddInput:input])
        [session addInput:input];
    
    [session startRunning];
    
    NSMenu* menuSel = [(NSMenuItem*) sender menu];
    for (NSMenuItem* menuItem in [menuSel itemArray])
    {
        [menuItem setState:NSOffState];
    }
    [(NSMenuItem*) sender setState:NSOnState];
}

- (void)windowDidResize:(NSNotification *)notification
{
    [previewLayer setFrame:[previewView bounds]];
}

- (void)windowWillClose:(NSNotification *)notification
{
    /*[session stopRunning];
	[previewLayer removeFromSuperlayer];
	[previewLayer setSession:nil];
    [previewLayer release];
    [stillImageOutput release];
    [session release];*/
    [NSApp terminate:[NSApp class]];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    // Save changes in the application's managed object context before the application terminates.
    
    return NSTerminateNow;
}

@end
