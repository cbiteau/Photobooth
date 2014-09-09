//
//  PhotoboothAppDelegate.h
//  Photobooth
//
//  Created by Charly Biteau on 17/07/2014.
//  Copyright (c) 2014 Charly Biteau. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PhotoboothAppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSView *previewView;
    IBOutlet NSImageCell *previewCell;
    IBOutlet NSImageView *previewCellView;
	AVCaptureSession *session;
    AVCaptureVideoPreviewLayer *previewLayer;
	AVCaptureStillImageOutput *stillImageOutput;
	BOOL started;
	NSURL *outputURL;
	AVAssetWriter *assetWriter;
	AVAssetWriterInput *videoInput;
	CMTime frameDuration;
	CMTime nextPresentationTime;

}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic) float framesPerSecond;
@property (retain) NSURL *outputURL;

- (void)windowDidResize:(NSNotification *)notification;

@end
