//
//  ParallaxBackgroundView.m
//  LMParallax
//
//  Created by li yajie on 11/12/12.
//  Copyright (c) 2012 com.coamee. All rights reserved.
//

#import "ParallaxView.h"

#ifndef BACKGROUND_HEIGHT 
#define BACKGROUND_HEIGHT 145.f
#endif

#define TRANSPARENT_LAYER_HEIGHT 400.f

@interface ParallaxView()<UIScrollViewDelegate>

@end

@implementation ParallaxView
{
    UIScrollView * _backgroundScrollView;
    UIScrollView * transparentScrollView;
    UIView * maskView;
    UIView * backgroundView;
    UIView * floatTopView;
    CGRect topRect;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _backgroundScrollView  = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _backgroundScrollView.backgroundColor = [UIColor clearColor];
        _backgroundScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backgroundScrollView.pagingEnabled = YES;
        _backgroundScrollView.delegate = self;
        _backgroundScrollView.showsHorizontalScrollIndicator = NO;
        _backgroundScrollView.showsVerticalScrollIndicator = NO;
        
        [self addSubview:_backgroundScrollView];
        // transpaent layer
        transparentScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        transparentScrollView.backgroundColor = [UIColor clearColor];
        transparentScrollView.showsHorizontalScrollIndicator = NO;
        transparentScrollView.showsVerticalScrollIndicator  = NO;
        transparentScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        transparentScrollView.delegate = self;
        [self addSubview:transparentScrollView];

    }
    return self;
}


-(void)layoutSubviews {
    [super layoutSubviews];
    //top background
    int count = [_datasource numbersOfParallax:self];
    
    CGFloat height = [_delegate heightOfParallaxViewOfItem:self];
    if ( abs(height - 0.001) == 0) {
        height = BACKGROUND_HEIGHT;
    }
    _backgroundScrollView.frame = CGRectMake(0.f, 0.f, self.frame.size.width,self.frame.size.height);
    _backgroundScrollView.contentSize = CGSizeMake(self.frame.size.width * count,self.frame.size.height);
    [_backgroundScrollView canCancelContentTouches];
    _backgroundScrollView.userInteractionEnabled = YES;
    _backgroundScrollView.contentOffset = CGPointZero;
    CGFloat frameHeight = [_delegate heightOfTransparentLayer:self];
    CGFloat deltaX = 0.f;
    if (backgroundView == nil) {
        backgroundView = [_delegate parallaxViewOfItem:self atIndex:0];
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        backgroundView.frame = CGRectMake(deltaX, floorf((height - backgroundView.frame.size.height)/ 2), backgroundView.frame.size.width, frameHeight);
        [_backgroundScrollView addSubview:backgroundView];
    }
    // transpaent layer
    if (frameHeight <= TRANSPARENT_LAYER_HEIGHT) {
        frameHeight = TRANSPARENT_LAYER_HEIGHT;
    }
    //transparent view the show view
    transparentScrollView.frame = self.bounds;
    floatTopView.frame = topRect;
    maskView.frame = CGRectMake(0.f, height, maskView.frame.size.width, self.frame.size.height);
    transparentScrollView.backgroundColor = [UIColor clearColor];
    transparentScrollView.contentSize = CGSizeMake(self.frame.size.width, height + maskView.frame.size.height);
}

-(void)setAutoresizingMask:(UIViewAutoresizing)autoresizingMask {
    [super setAutoresizingMask:autoresizingMask];
    [_backgroundScrollView setAutoresizingMask:autoresizingMask];
    [transparentScrollView setAutoresizingMask:autoresizingMask];
}
#pragma mark -- transparent layer 
-(void)maskViewCover:(UIView*) mContentView {
    maskView = mContentView;
    [transparentScrollView addSubview:maskView];
}

-(void)floatLayerView:(UIView *)floatView {
    floatTopView = floatView;
    topRect = floatTopView.frame;
    floatTopView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [transparentScrollView addSubview:floatTopView];
}

#pragma mark -- scroll delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _backgroundScrollView) {
//        CGFloat pageWidth = _backgroundScrollView.frame.size.width;
//        curIndex = floor(((_backgroundScrollView.contentOffset.x - pageWidth / 2) / pageWidth)) + 1;
    } else {
        [self parallaxEffect];
        if ([_scrollDelegate respondsToSelector:_cmd]) {
            [_scrollDelegate scrollViewDidScroll:scrollView];
        }
    }
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if (scrollView == transparentScrollView) {
        if ([_scrollDelegate respondsToSelector:_cmd]) {
            [_scrollDelegate scrollViewDidZoom:scrollView];
        }
        
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == transparentScrollView) {
        if ([_scrollDelegate respondsToSelector:_cmd]) {
            [_scrollDelegate scrollViewWillBeginDragging:scrollView];
        }
    }
   
}

-(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if (scrollView == transparentScrollView) {
        if ([_scrollDelegate respondsToSelector:_cmd]) {
            return [_scrollDelegate scrollViewShouldScrollToTop:scrollView];
        }
    }
     return FALSE;
}

#pragma mark -- update the offset
-(void) parallaxEffect {
    CGFloat height = [_delegate heightOfParallaxViewOfItem:self];
    CGFloat offsetY = transparentScrollView.contentOffset.y;
    CGFloat offsetX = transparentScrollView.contentOffset.x;
    CGFloat transparentToTop = [_delegate heightOfTransparentLayer:self];
    CGFloat threshold = transparentToTop - height;
    if (offsetY > 0) {
        _backgroundScrollView.contentOffset = CGPointMake(offsetX, offsetY);
    } else if (offsetY < 0) {
        if (offsetY < - threshold) {
            _backgroundScrollView.contentOffset = CGPointMake(offsetX, offsetY + floorf(threshold / 2));
        } else {
            //是同一方向负值
            if (floatTopView) {
                [UIView animateWithDuration:.2 animations:^{
                    CGFloat centerX = topRect.origin.x + topRect.size.width / 2;
                    CGFloat centerY = topRect.origin.y + topRect.size.height / 2;
                    floatTopView.center = CGPointMake(centerX, centerY + offsetY);
                }];
            }
            _backgroundScrollView.contentOffset = CGPointMake(offsetX, floorf(offsetY / 2));
        }
    }
}
//#pragma mark -- the picture item clicked
//-(void) perItemClicked:(id) sender {
//    UITapGestureRecognizer *gesture = (UITapGestureRecognizer*) sender;
//    UIView * touchView = gesture.view;
//    if ([_delegate respondsToSelector:@selector(performItemClicked:atIndex:)]) {
//        [_delegate performItemClicked:self atIndex:touchView.tag];
//    }
//}
@end
