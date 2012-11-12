//
//  MyItemView.m
//  LMParallax
//
//  Created by li yajie on 11/12/12.
//  Copyright (c) 2012 com.coamee. All rights reserved.
//

#import "MyItemView.h"

@implementation MyItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        _imageView.userInteractionEnabled = YES;
        self.exclusiveTouch = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        _imageView.contentMode = UIViewContentModeScaleAspectFill;
//        _imageView.frame = CGRectMake(0.f, 0.f, self.bounds.size.width, self.bounds.size.height);
//        _imageView.image = [UIImage imageNamed:@"Default.png"];
        [self addSubview:_imageView];
    }
    return self;
}

//-(void)layoutSubviews {
//    [super layoutSubviews];
//    _imageView.frame = CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height);
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
