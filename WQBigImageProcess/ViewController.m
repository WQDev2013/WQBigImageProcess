//
//  ViewController.m
//  WQBigImageProcess
//
//  Created by chenweiqiang on 2020/5/10.
//  Copyright © 2020 chenweiqiang. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Extension.h"
#import "UIImageView+Extension.h"
@interface ViewController ()
@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 320, 200)];
    imageView.backgroundColor = [UIColor brownColor];
    [self.view addSubview: imageView];
    self.imageView = imageView;
    
    [self.imageView setWQImage:[UIImage imageNamed:@"8.png"]];
    
    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 350, 320, 200)];
    imageView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:imageView];

    NSBundle *bundle = [NSBundle mainBundle];
    NSString *resourcePath = [bundle resourcePath];

    NSString *filePath = [resourcePath stringByAppendingPathComponent:@"8.png"];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
        UIImage *tempImage = [UIImage imageWithData:data];
        // 这步操作比较耗时
        UIImage* image = [tempImage resizeScaleImage:0.1];
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;
        });
    });

}

@end
