//
//  ViewController.m
//  VSBusinessProfile
//
//  Created by Admin on 12/20/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *array;
    NSString *yelpString;
    NSData *dataPic;
   NSString *idNo;
    NSString *str;
    NSMutableArray *userInfoArray;
    NSString *twitterString;
    UIWebView *webView;
    NSString *fbString;
    NSString *address;
    NSString *youtubeString;
    
}

@end

@implementation ViewController
@synthesize  collectionView =_collectionView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   // array =[[NSMutableArray alloc]init];
   // [array addObject:[UIImage imageNamed:@"qmark.jpg"]];
    self.fbButton.layer.cornerRadius = 25;
    userInfoArray = [[NSMutableArray alloc]init];
      webView = [[UIWebView alloc]initWithFrame:CGRectMake(50,200,200,500)];
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DisableWebView)];
    [self.view addGestureRecognizer:tap];
    [self FindPicture];
   // [self FindYelp];
}
-(void)DisableWebView
{
    NSLog(@"web disable");
    webView.hidden = YES;
    self.collectionView.hidden = NO;
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return userInfoArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"reloaded");
    DisplayPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
   // UIImage *img =[UIImage imageWithData:[array objectAtIndex:indexPath.row]];
    UserInfo *usr = [userInfoArray objectAtIndex:indexPath.row];
    UIImage *img =[UIImage imageWithData:usr.data];
    cell.imgView.image = img;
    NSLog(@"reloaded- end");
    return cell;
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{  NSLog(@"prepare for segue");
    if( [segue.identifier  isEqual: @"yelp"])
    {
    YelpDisplayViewController *vc = [segue destinationViewController];
    NSIndexPath *indexPath =[[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
    UserInfo *usr = [userInfoArray objectAtIndex:indexPath.row];
    vc.string = usr.yelpString;
    NSLog(@"YELP String %@",usr.yelpString);
    }
    if([segue.identifier isEqualToString:@"Map"])
    {
        MapViewController *mvc = [segue destinationViewController];
        mvc.address = address;
         NSLog(@"map String %@",address);
        
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"yelp" sender:self];
    
}

-(void)FindPicture
{

NSLog(@"FindPicture");
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *request =  @"https://core1.antsquare.com/v5/users/179/resources";
    NSURL *URL = [NSURL URLWithString:request];
   NSURLSessionConfiguration *configSession = [NSURLSessionConfiguration defaultSessionConfiguration];
   NSURLSession *session =[NSURLSession sessionWithConfiguration:configSession] ;
   // NSURLSession *session =[NSURLSession  sharedSession];
 
    //START URLCACHE needs default configuration
    NSString *cachePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"/nsurlsessiondemo.cache"];
    
    NSURLCache *myCache = [[NSURLCache alloc] initWithMemoryCapacity: 16384
                                                        diskCapacity: 268435456
                                                            diskPath: cachePath];
    configSession.URLCache = myCache;
    
    configSession.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
    
    //END URLCACHE
  
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //    NSLog(@"json %@",json);
        if([json  objectForKey:@"resources"]  )
        {
            
            NSMutableArray *groups = [[NSMutableArray alloc] init];
            NSArray *results = [json valueForKey:@"resources"];
       //     NSLog(@"Count %@", results[0] );
        //     NSLog(@"Count %d", results.count);
             //start
            for(int i=0;i<results.count ;i++)
            {  NSDictionary *dict = results[i] ;
               // NSLog(@"images %@",[[dict objectForKey:@"user_info" ]  objectForKey:@"picture"] );
                str=  [[dict objectForKey:@"user_info" ]  objectForKey:@"picture"]  ;
                NSURL *url  =[NSURL URLWithString:str];
                dataPic = [[NSData alloc]initWithContentsOfURL:url];
              //  img = [UIImage imageWithData:dataPic];
              //  [array addObject:img];
                NSLog(@"ID %@", [[dict objectForKey:@"user_info" ]  objectForKey:@"id"]);
                idNo = [[dict objectForKey:@"user_info" ]  objectForKey:@"id"] ;
                [self FindYelp:idNo];
            }
            
             
        }
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self.collectionView reloadData];
        });
    }];
    [dataTask resume];
    
   

});
    
}


-(void)FindYelp:(NSString*) idN
{
    
    NSLog(@"FindYelp %@ %@",idN, str);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //NSString *request =@"https://core1.antsquare.com/v5/users/179/mpview";
        NSString *request= [NSString stringWithFormat:@"%@%@%@",@"https://core1.antsquare.com/v5/users/",idN,@"/mpview"];
        NSURL *URL = [NSURL URLWithString:request];
        NSURLSession *session =[NSURLSession sharedSession] ;
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             //NSLog(@"json %@",json);
            NSLog(@"json link %@",[json objectForKey:@"external_url"]);
            yelpString = [json objectForKey:@"external_url"];
            UserInfo *usr =[[UserInfo alloc]initWithData:dataPic idNum:idN yelpString:yelpString];
            [userInfoArray addObject:usr];
            NSLog(@"userInfoArray Count %ld", userInfoArray.count);
            NSLog(@"json link %@",[json objectForKey:@"twitter"]);
           twitterString =[json objectForKey:@"twitter"];
            fbString =[json objectForKey:@"facebook"];
            youtubeString =[json objectForKey:@"youtube"];
NSLog(@"json link %@",[json objectForKey:@"twitter"]);
            address =[json objectForKey:@"address1"];
                        dispatch_async(dispatch_get_main_queue(), ^ {
                [self.collectionView reloadData];
                            self.nameText.text = [json objectForKey:@"name"];
                             self.usernameText.text = [json objectForKey:@"username"];
                            self.likesText.text = [NSString stringWithFormat:@"%@%@",[json objectForKey:@"total_likes"] , @" likes" ];
                           // NSMutableDictionary *attrDict =[[NSMutableDictionary alloc]init];
                           /* NSDictionary *attrDict = @{
                                                       NSFontAttributeName : [UIFont fontWithName:@"ariel" size:16.0],
                                                       NSForegroundColorAttributeName : [UIColor redColor]
                                                       };
                            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"followers" attributes:attrDict];
                            
                            */
                            NSString *follwers =[json objectForKey:@"total_followers"];
                          //  NSLog(@"length %lu",(unsigned long)[follwers length]);
                            
                            NSString *followsText =[NSString stringWithFormat:@"%@%@",follwers,@" followers"];
                            NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:followsText];
                            [attrString  addAttribute:NSFontAttributeName
                                          value:[UIFont systemFontOfSize:12.0]
                                          range:NSMakeRange(3,9)];
                            [self.followsText  setAttributedText:attrString];
                           // NSLog(@"length %lu",(unsigned long)[follwers length]);
                           
                            self.imgView.image=[UIImage imageWithData:[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[json objectForKey:@"cover_image"]]]];
                            
                            self.imgView.layer.cornerRadius = self.imgView.frame.size.width / 2;
                            self.imgView.clipsToBounds = YES;

            });
                   }];
        [dataTask resume];
       
        
    
    });
   
    
}



- (IBAction)twitterPressed:(id)sender {
    self.collectionView.hidden = YES;
    webView.hidden = NO;
    NSLog(@"Twitter %@",twitterString);
  
    [ webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:twitterString]]];
    [self.view addSubview:webView];
}
- (IBAction)fbPressed:(id)sender {
    self.collectionView.hidden = YES;
    webView.hidden = NO;
    NSLog(@"Twitter %@",fbString);
    NSString *fbCompString = [NSString stringWithFormat:@"%@%@",@"https://facebook.com/",fbString];
    
    [ webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:fbCompString]]];
    [self.view addSubview:webView];
}

- (IBAction)mapPressed:(UIButton *)sender {
}

- (IBAction)callPressed:(id)sender {
    NSLog(@"call");
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel:5106743117"] ];
}

- (IBAction)youtubePressed:(id)sender {
    self.collectionView.hidden = YES;
    webView.hidden = NO;
    NSLog(@"Twitter %@",youtubeString);
    NSString *ytCompString = [NSString stringWithFormat:@"%@%@",@"https://youtube.com/",youtubeString];
    
    [ webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ytCompString]]];
    [self.view addSubview:webView];
}

//Logout

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    NSLog(@"Back Home");
}
@end



