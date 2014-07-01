//
//  LoginViewController.m
//  loginFeed
//
//  Created by Natalia Fisher on 6/27/14.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import "LoginViewController.h"
#import "FeedViewController.h"


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loginActivityIndicator;

- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;
- (IBAction)emailFieldEditingChanged:(id)sender;
- (IBAction)passwordFieldEditingChanged:(id)sender;
- (IBAction)loginTouchUpInside:(id)sender;



@end

@implementation LoginViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //  Tapping in the UITextField repositions the elements, as shown in the screenshots.
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // If email and password field are both blank, button should be disabled.
    self.loginButton.enabled = NO;
    
}

// Tapping anywhere dismisses the keyboard
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


// Tapping in the UITextField repositions the elements, as shown in the screenshots.
- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.blueView.frame = self.blueView.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.blueView.frame.size.height + 150, self.blueView.frame.size.width, self.blueView.frame.size.height);
                     }
                     completion:nil];
}

- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.blueView.frame = CGRectMake(0, self.view.frame.size.height - self.blueView.frame.size.height, self.blueView.frame.size.width, self.blueView.frame.size.height);
                     }
                     completion:nil];
}


// If email and password field are both blank, button should be disabled.
- (void)checkFields
{
    // Get field values.
    NSString *userEmail = self.emailField.text;
    NSString *userPassword = self.passwordField.text;
    if ((userEmail.length == 0) || (userPassword.length == 0)) {
        self.loginButton.enabled = NO;
    }
    else {
        self.loginButton.enabled = YES;
    }
}

- (IBAction)emailFieldEditingChanged:(id)sender {
    [self checkFields];
}

- (IBAction)passwordFieldEditingChanged:(id)sender {
    [self checkFields];
}

// After tapping log in button, show the loading indicator in the button.
- (IBAction)loginTouchUpInside:(id)sender {
    
    // Change image of button to say "Logging in"
    [self.loginButton setImage:[UIImage imageNamed:@"logging_in"] forState:UIControlStateNormal];
    
    // Show the loading indicator in the button
    [self.loginActivityIndicator startAnimating];
    
    // After a 2 second delay, check the password.
    [self performSelector:@selector(checkPassword) withObject:nil afterDelay:2];

}

- (void)checkPassword {
    NSString *userPassword = self.passwordField.text;
    
    if ([userPassword isEqualToString:@"password"]){
        // If the password is 'password', transition to the next screen.
        UIViewController *vc = [[FeedViewController alloc] init];
        vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:vc animated:YES completion:nil];
    }
    else {
        // If the password is anything else, display the password error alert.
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:@"The password you entered is incorrect.  Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
        // Reset login button 
        [self.loginActivityIndicator stopAnimating];
        [self.loginButton setImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
