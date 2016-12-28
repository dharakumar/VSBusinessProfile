//
//  MapViewController.h
//  VSBusinessProfile
//
//  Created by Admin on 12/23/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate , CLLocationManagerDelegate,MKAnnotation>
@property(nonatomic,strong) NSString *address;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic,strong) CLLocationManager *manager;
- (IBAction)Logout:(id)sender;

@end
