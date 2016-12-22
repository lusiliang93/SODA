//
//  ViewController.m
//  Test_Soda
//
//  Created by Siliang Lu on 10/8/16.
//  Copyright © 2016 Siliang Lu. All rights reserved.
//

#import "ViewController.h"

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#import "opencv2/highgui/ios.h"
#endif

// Include iostream and std namespace so we can mix C++ code in here
#include <stdlib.h>
#include <iostream>
using namespace std;
using namespace cv;

@interface ViewController (){
    // Setup the view
    UIImageView *imageView_;
    UIImageView *resultView_; // Preview view of everything...
    UIImageView *subwayView_;
    UIImageView *predictView1_;
    UIImageView *predictView2_;
    UIImageView *predictView3_;
    UIImageView *predictView4_;
    UIImageView *notificationView_;
    // Button to initiate OpenCV processing of image
    UIButton *nanjingButton_, *xuhuiButton_,*wujiaochangButton_,*xinzhuangButton;
    UIButton *one,*two,*three;
    UIButton *didiButton_,*subwayButton_;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *image1 = [UIImage imageNamed:@"shanghai.jpg"];
    UIImage *image0 = [UIImage imageNamed:@"nanjing.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"subway.jpg"];
    UIImage *imagep0 = [UIImage imageNamed:@"5.png"];
    UIImage *imagep1 = [UIImage imageNamed:@"6.png"];
    UIImage *imagep2 = [UIImage imageNamed:@"7.png"];
    UIImage *imagep3 = [UIImage imageNamed:@"8.png"];
    UIImage *imagen = [UIImage imageNamed:@"notification.jpg"];
    float widthp = imagep0.size.width;
    float heightp = imagep0.size.height;
    float width = image2.size.width;
    float height = image2.size.height;
    //int view_width = self.view.frame.size.width;
    int view_width = image1.size.width;
    //int view_height = (640*view_width)/480; // Work out the viw-height assuming 640x480 input
    int view_height = image1.size.height;
    //int view_offset = (self.view.frame.size.height - view_height)/2;
    float widthn = imagen.size.width;
    float heightn = imagen.size.height;
    
    // 1. Setup the your OpenCV view, so it takes up the entire App screen......
    //imageView_ = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, width, height)];
    imageView_ = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, view_width, view_height)];
    resultView_ = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, view_width, view_height)];
    float x = (self.view.frame.size.width-width/4)/2;
    float y = (self.view.frame.size.height-height/4)/2;
    subwayView_ = [[UIImageView alloc] initWithFrame:CGRectMake(x-160, y-80, width/4+320, height/4+190)];
    predictView1_ = [[UIImageView alloc] initWithFrame:CGRectMake(x-160,y+150,widthp,heightp)];
    predictView2_ = [[UIImageView alloc] initWithFrame:CGRectMake(x-160,y+150,widthp,heightp)];
    predictView3_ = [[UIImageView alloc] initWithFrame:CGRectMake(x-160,y+150,widthp,heightp)];
    predictView4_ = [[UIImageView alloc] initWithFrame:CGRectMake(x-160,y+150,widthp,heightp)];
    notificationView_ = [[UIImageView alloc]initWithFrame:CGRectMake(x-100,y+50,widthn,heightn)];
    
    // 2. Important: add imageView and resultView as subviews
    [self.view addSubview:imageView_];
    [self.view addSubview:resultView_]; // Important: add resultView_ as a subview
    [imageView_ addSubview:subwayView_];
    [resultView_ addSubview:predictView1_];
    [resultView_ addSubview:predictView2_];
    [resultView_ addSubview:predictView3_];
    [resultView_ addSubview:predictView4_];
    [resultView_ addSubview:notificationView_];
    
    // 3.Read in the image (of the famous Lena)
    
    if(image1 != nil) resultView_.image = image1; // Display the image if it is there....
    else cout << "Cannot read in the file" << endl;
    if(image2 != nil) subwayView_.image = image2; //Display the image if it is there....
    else cout <<"Cannot read in the file"<< endl;
    if(imagep0 != nil) predictView1_.image = imagep0; //Display the image if it is there....
    else cout <<"Cannot read in the file"<< endl;
    if(imagep1 != nil) predictView2_.image = imagep1; //Display the image if it is there....
    else cout <<"Cannot read in the file"<< endl;
    if(imagep0 != nil) predictView3_.image = imagep2; //Display the image if it is there....
    else cout <<"Cannot read in the file"<< endl;
    if(imagep0 != nil) predictView4_.image = imagep3; //Display the image if it is there....
    else cout <<"Cannot read in the file"<< endl;
    if(imagen != nil) notificationView_.image=imagen;
    else cout<<"Cannot read in the file"<<endl;
    
    // 4. Next convert to a cv::Mat
    cv::Mat cvImage; UIImageToMat(image1, cvImage);
    
    // 5. Now apply some OpenCV operations
    cv::Mat gray; cv::cvtColor(cvImage, gray, CV_RGBA2GRAY); // Convert to grayscale
    
    // 6. Finally display the result
    resultView_.image = image0;
    imageView_.image = MatToUIImage(gray);
    imageView_.hidden = false;
    resultView_.hidden = true; // Hide the view
    
    //Set up a button for nanjingdonglu,xujiahui,wujiaochang,xinzhuang
    // Botton position is adaptive as this could run on a different device (iPAD, iPhone, etc.)
    int button_x = (self.view.frame.size.width - 200)/16-50; // Position of top-left of button
    int button_y = self.view.frame.size.height - 80; // Position of top-left of button
    nanjingButton_ = [self simpleButton:@"南京东路商圈" buttonColor:[UIColor redColor] Button_x:button_x Button_y:button_y];
    // Botton position is adaptive as this could run on a different device (iPAD, iPhone, etc.)
    button_x = (self.view.frame.size.width - 200)/8+100; // Position of top-left of button
    button_y = self.view.frame.size.height - 80; // Position of top-left of button
    xuhuiButton_ = [self simpleButton:@"徐家汇商圈" buttonColor:[UIColor redColor] Button_x:button_x Button_y:button_y];
    // Botton position is adaptive as this could run on a different device (iPAD, iPhone, etc.)
    button_x = (self.view.frame.size.width - 200)/8+300; // Position of top-left of button
    button_y = self.view.frame.size.height - 80; // Position of top-left of button
    wujiaochangButton_ = [self simpleButton:@"五角场商圈" buttonColor:[UIColor redColor] Button_x:button_x Button_y:button_y];
    // Botton position is adaptive as this could run on a different device (iPAD, iPhone, etc.)
    button_x = (self.view.frame.size.width - 200)/8+500; // Position of top-left of button
    button_y = self.view.frame.size.height - 80; // Position of top-left of button
    xinzhuangButton = [self simpleButton:@"莘庄商圈" buttonColor:[UIColor redColor] Button_x:button_x Button_y:button_y];
    // Botton position is adaptive as this could run on a different device (iPAD, iPhone, etc.)
    button_x = (self.view.frame.size.width - 200)/8+350; // Position of top-left of button
    button_y = self.view.frame.size.height-900; // Position of top-left of button
    didiButton_ = [self simpleButton:@"上海地铁" buttonColor:[UIColor redColor] Button_x:button_x Button_y:button_y];
    
    // Important part that connects the action to the member function buttonWasPressed
    [nanjingButton_ addTarget:self action:@selector(buttonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    [didiButton_ addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    //Set up a button for one/two/three hour(s) prediction
    // Botton position is adaptive as this could run on a different device (iPAD, iPhone, etc.)
    button_x = (self.view.frame.size.width - 200)/16-50; // Position of top-left of button
    button_y = self.view.frame.size.height - 80; // Position of top-left of button
    one = [self simpleButton:@"17:00-18:00" buttonColor:[UIColor blueColor] Button_x:button_x Button_y:button_y];
    [one setHidden:true];
    button_x = (self.view.frame.size.width - 200)/2; // Position of top-left of button
    button_y = self.view.frame.size.height - 80; // Position of top-left of button
    two = [self simpleButton:@"18:00-19:00" buttonColor:[UIColor blueColor] Button_x:button_x Button_y:button_y];
    [two setHidden:true];
    button_x = (self.view.frame.size.width - 200)/2+300; // Position of top-left of button
    button_y = self.view.frame.size.height - 80; // Position of top-left of button
    three = [self simpleButton:@"19:00-20:00" buttonColor:[UIColor blueColor] Button_x:button_x Button_y:button_y];
    [three setHidden:true];
    // Important part that connects the action to the member function buttonWasPressed
    [one addTarget:self action:@selector(predictononeWasPressed) forControlEvents:UIControlEventTouchUpInside];
    [two addTarget:self action:@selector(predictontwoWasPressed) forControlEvents:UIControlEventTouchUpInside];
    [three addTarget:self action:@selector(predictonthreeWasPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//===============================================================================================
// Simple member function to initialize buttons in the bottom of the screen so we do not have to
// bother with storyboard, and can go straight into vision on mobiles
//

- (UIButton *) simpleButton:(NSString *)buttonName buttonColor:(UIColor *)color Button_x:(int)button_x Button_y:(int)button_y
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom]; // Initialize the button
    // Bit of a hack, but just positions the button at the bottom of the screen
    int button_width = 200; int button_height = 50; // Set the button height and width (heuristic)
    button.frame = CGRectMake(button_x, button_y, button_width, button_height); // Position the button
    [button setTitle:buttonName forState:UIControlStateNormal]; // Set the title for the button
    [button setTitleColor:color forState:UIControlStateNormal]; // Set the color for the title
    
    [self.view addSubview: button]; // Important: add the button as a subview
    //[button setEnabled:bflag]; [button setHidden:(!bflag)]; // Set visibility of the button
    return button;
}
//===============================================================================================
// This member function is executed when the button is pressed
- (void)buttonWasPressed {
    [nanjingButton_ setHidden:true]; [xuhuiButton_ setHidden:true]; // Switch visibility of buttons
    [wujiaochangButton_ setHidden:true]; [xinzhuangButton setHidden:true];[didiButton_ setHidden:true];
    imageView_.hidden = true; // Hide the result view again
    resultView_.hidden = false; //Show the Nanjingdonglu density
    [one setHidden:false];
    [two setHidden:false];
    [three setHidden:false];
    predictView1_.hidden = false;
    predictView2_.hidden = true;
    predictView3_.hidden = true;
    predictView4_.hidden = true;
    
}
// This member function is executed when the button is pressed
- (void)predictononeWasPressed
{
    predictView1_.hidden = true;
    predictView2_.hidden = false;
}
- (void)predictontwoWasPressed
{
    predictView2_.hidden = true;
    predictView3_.hidden = false;
}
- (void)predictonthreeWasPressed
{
    predictView3_.hidden = true;
    predictView4_.hidden = false;
}
// This member function is executed when the button is pressed
- (void)buttonPressed//:(UIButton *)button
{
    NSString *customURL = @"http://service.shmetro.com/";
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:customURL]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customURL]];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"URL error"
                                                        message:[NSString stringWithFormat:@"No custom URL defined for %@", customURL]
                                                       delegate:self cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

@end
