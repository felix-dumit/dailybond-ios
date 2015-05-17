//
//  AppDelegate.m
//  DailyBond
//
//  Created by Nick-Retina on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <Bolts/Bolts.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <FBSDKMessengerUrlHandler.h>
#import <FBSDKMessengerURLHandlerOpenFromComposerContext.h>
#import <FBSDKMessengerURLHandlerReplyContext.h>
#import "User.h"
#import "Birthday.h"
#import "KeepInTouch.h"
#import "Event.h"
#import "CardsViewController.h"
#import <MJExtension.h>

enum MessengerShareMode { MessengerShareModeSend,
    MessengerShareModeComposer,
    MessengerShareModeReply};


@interface AppDelegate () <FBSDKMessengerURLHandlerDelegate>

@property (strong, nonatomic) FBSDKMessengerURLHandler *messengerURLHandler;
@property (strong, nonatomic) FBSDKMessengerURLHandlerOpenFromComposerContext *composeContext;
@property (strong, nonatomic) FBSDKMessengerURLHandlerReplyContext *replyContext;

@end

@implementation AppDelegate {
    enum MessengerShareMode shareMode;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [User registerSubclass];
    [Birthday registerSubclass];
    [KeepInTouch registerSubclass];
    [Event registerSubclass];
    
    
    [Parse enableLocalDatastore];
    [Parse setApplicationId:@"ioHHzrZSRJSMSTR0WZZETXjyjXfgKOZ3uefsMuG5" clientKey:@"M7vDYkWESocaASxvdf4UwYpZMDFaCey3yoyiDdPj"];
    
    
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:launchOptions];
    
    
    _messengerURLHandler = [[FBSDKMessengerURLHandler alloc] init];
    _messengerURLHandler.delegate = self;
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)  application:(UIApplication *)application
              openURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation {
    // attempt to extract a token from the url
    // Check if the handler knows what to do with this url
    if ([self.messengerURLHandler canOpenURL:url sourceApplication:sourceApplication]) {
        // Handle the url
        [self.messengerURLHandler openURL:url sourceApplication:sourceApplication];
        
        return YES;
    }
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

#pragma mark - FBSDKMessengerURLHandlerDelegate
/*
 * When people enter your app through the composer in Messenger,
 * this delegate function will be called.
 */
- (void)             messengerURLHandler:(FBSDKMessengerURLHandler *)messengerURLHandler
    didHandleOpenFromComposerWithContext:(FBSDKMessengerURLHandlerOpenFromComposerContext *)context;
{
    _composeContext = context;
    shareMode = MessengerShareModeComposer;
}

/*
 * When people enter your app through the "Reply" button on content
 * this delegate function will be called.
 */
- (void)  messengerURLHandler:(FBSDKMessengerURLHandler *)messengerURLHandler
    didHandleReplyWithContext:(FBSDKMessengerURLHandlerReplyContext *)context;
{
    _replyContext = context;
    shareMode = MessengerShareModeReply;
}


#pragma mark - Private
- (void)shareReply {
    NSString *metadata = @"{ \"image\" : \"pedro\" }";
    
    if ([FBSDKMessengerSharer messengerPlatformCapabilities] & FBSDKMessengerPlatformCapabilityImage) {
        UIImage *image = [UIImage imageNamed:@"selfie_pic"];
        
        // getContextForShareMode is a helper method
        FBSDKMessengerShareOptions *options = [[FBSDKMessengerShareOptions alloc] init];
        options.metadata = metadata;
        options.contextOverride = [self getContextForShareMode];
        
        [FBSDKMessengerSharer shareImage:image withOptions:options];
    }
}

- (FBSDKMessengerContext *)getContextForShareMode {
    // shareMode holds state indicating which flow the user is in.
    // Return the corresponding FBSDKMessengerContext based on that state.
    
    if (shareMode == MessengerShareModeSend) {
        // Force a send flow by returning a broadcast context.
        return [[FBSDKMessengerBroadcastContext alloc] init];
    }
    else if (shareMode == MessengerShareModeComposer) {
        // Force the composer flow by returning the composer context.
        return _composeContext;
    }
    else if (shareMode == MessengerShareModeReply) {
        // Force the reply flow by returning the reply context.
        return _replyContext;
    }
    
    
    return nil;
}

@end
