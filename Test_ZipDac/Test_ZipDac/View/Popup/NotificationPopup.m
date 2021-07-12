//
//  MainViewController.m
//  Test_ZipDac
//
//  Created by 손태일 on 2021/07/10.
//

#import "NotificationPopup.h"

@interface NotificationPopup()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation NotificationPopup
 
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setTitle:(NSString*)title {
    _titleLabel.text = title;
}

- (IBAction)tapClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
