//
//  MapViewController.m
//  VSBusinessProfile
//
//  Created by Admin on 12/23/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize coordinate=_coordinate;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"MAP VC Adrres %@",self.address);
    self.manager = [[CLLocationManager alloc]init];
    [self.manager requestAlwaysAuthorization];
    [self.manager requestWhenInUseAuthorization];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:self.address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = placemarks[0];
        CLLocation *location = placemark.location;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 800, 800);
        [self.mapView setRegion:region animated:NO];
        MKPointAnnotation *annot = [[MKPointAnnotation alloc]init];
        annot.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        annot.title = @"My Shop";
        annot.subtitle = @"Dexter Hu";

        [self.mapView addAnnotation:annot];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
