//
//  ViewController.m
//  LMParallax
//
//  Created by li yajie on 11/12/12.
//  Copyright (c) 2012 com.coamee. All rights reserved.
//

#import "ViewController.h"
#import "MyItemView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    ParallaxView * view = [[ParallaxView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, self.view.bounds.size.height)];
//    UITableView * table = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, 420.f)];
//    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    [view transparentViewLayer:table];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIView * table = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, 420.f)];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    table.backgroundColor = [UIColor magentaColor];
    table.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [view transparentViewLayer:table];
    view.datasource = self;
    view.delegate = self;
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- delegate of the parallax view
-(NSInteger)numbersOfParallax:(ParallaxView *)contentView {
    return 1;
}

-(CGFloat)heightOfParallaxViewOfItem:(ParallaxView *)contentView {
    return 220.f;
}

-(CGFloat)heightOfTransparentLayer:(ParallaxView *)contentView {
    return 400.f;
}

-(ParallaxItemView *)parallaxViewOfItem:(ParallaxView *)contentView atIndex:(NSInteger)index {
    UIImage * image = [UIImage imageNamed:@"background.png"];
    MyItemView * view = [[MyItemView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, image.size.height)];
//    view.imageView.frame = CGRectMake(0.f, 0.f, image.size.width, image.size.height);
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    view.autoresizesSubviews = YES;
    [view.imageView setImage:image];
    return view;
}

-(void)performItemClicked:(ParallaxView *)contentView atIndex:(NSInteger)index {
    NSLog(@"the clicked..");
}
@end
