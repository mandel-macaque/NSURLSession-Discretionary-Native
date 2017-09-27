//
//  ViewController.m
//  Discretionary-Native
//
//  Created by Chris Mays on 9/27/17.
//  Copyright © 2017 NSChris. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLSessionDownloadDelegate, NSURLSessionDelegate>

@property (strong, nonatomic) NSURLSession *session;
@property (nonatomic) NSURLSessionDownloadTask *downloadTask;

@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated
{
    if (self.session == nil)
    {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"test"];
        config.sessionSendsLaunchEvents = true;
        config.discretionary = true;

        self.session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }

    self.downloadTask = [self.session downloadTaskWithURL:[NSURL URLWithString:@"https://rss.art19.com/episodes/439bd7ab-177b-4552-a102-eca19b7e50fd.mp3"]];

    [self.downloadTask resume];
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error != nil)
    {
        NSLog(@"Error Downloading: %@", error.description);
    }
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"Downloaded to location %@", location);
}

@end
