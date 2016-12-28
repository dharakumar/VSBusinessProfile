//
//  ViewController.h
//  VSBusinessProfile
//
//  Created by Admin on 12/20/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayPictureCollectionViewCell.h"
#import "YelpDisplayViewController.h"
#import "UserInfo.h"
#import "MapViewController.h"

@interface ViewController : UIViewController <UICollectionViewDelegate ,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *followsText;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *fbButton;
- (IBAction)twitterPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameText;
@property (weak, nonatomic) IBOutlet UILabel *likesText;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
- (IBAction)fbPressed:(id)sender;
- (IBAction)mapPressed:(UIButton *)sender;
- (IBAction)callPressed:(id)sender;
- (IBAction)youtubePressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *usernameText;

@end

