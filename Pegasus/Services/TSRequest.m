//
//  TSRequest.m
//  Pegasus
//
//  Created by Tyler Hunnefeld on 10/19/16.
//  Copyright © 2016 TylerHunnefeld. All rights reserved.
//

#import "TSRequest.h"
#import "Constants.h"




@implementation TSRequest
@synthesize delegate;
//Init

+ (instancetype)sharedInstance {
    static TSRequest *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TSRequest alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    return self;
}

- (id)delegate {
    return delegate;
}

- (void)setDelegate:(id<TSRequestDelegate>)newDelegate {
    delegate = newDelegate;
}

//Class Methods


- (void) performAPIRequestWithRadius:(int)radius latitude:(CLLocationDegrees *)lat longitude:(CLLocationDegrees *)lng {
    NSURL *url = [self createURLForQuery:radius latitude:lat longitude:lng];
    
    NSString *post =[NSString stringWithFormat:@"lat=%lf&lng=%lf", *lat, *lng];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url];
    
    //Set up your request
    NSString *authValue = [NSString stringWithFormat:@"%@", AUTH_STRING];
    [request addValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *e = nil;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error: &e];
        if (e != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate fetchJSONError:e];
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate didFetchJSON:JSON];
            });
        }
    }] resume];
}

- (NSURL *)createURLForQuery:(int)radius latitude:(CLLocationDegrees *)lat longitude:(CLLocationDegrees *)lng {
    NSString *radiusString = [NSString stringWithFormat:@"%d", radius];
    //NSString *urlAsString = [NSString stringWithFormat:@"%@%@/?lat=%lf&lng=%lf", REST_ENDPOINT, radiusString, *lat, *lng];
    NSString *urlAsString = [NSString stringWithFormat:@"%@%@/", REST_ENDPOINT, radiusString];
    NSLog(@"ViewController: createURLForQuery url is %@", urlAsString);
    NSURL *url = [NSURL URLWithString: urlAsString];
    return url;
}


@end
