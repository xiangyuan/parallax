//
//  ParallaxBackgroundView.h
//  LMParallax
//
//  Created by li yajie on 11/12/12.
//  Copyright (c) 2012 com.coamee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParallaxItemView.h"

@class ParallaxView;


@protocol ParallaxViewDatasource <NSObject>

-(NSInteger) numbersOfParallax:(ParallaxView*) contentView;

@end
@protocol ParallaxViewDelegate <NSObject>

@required
/**
 * the item of the top background view
 */
-(ParallaxItemView *) parallaxViewOfItem:(ParallaxView *) contentView atIndex:(NSInteger) index;

/**
 * get the item view height
 */
-(CGFloat) heightOfParallaxViewOfItem:(ParallaxView*) contentView;
/**
 * transparent content height
 */
-(CGFloat) heightOfTransparentLayer:(ParallaxView*)contentView;


@optional
/**
 * the item clicked
 */
-(void) performItemClicked:(ParallaxView*) contentView atIndex:(NSInteger) index;


@end

@interface ParallaxView : UIView

//
@property(nonatomic,unsafe_unretained) id<UIScrollViewDelegate> scrollDelegate;
//
@property(nonatomic,unsafe_unretained) id<ParallaxViewDatasource> datasource;

@property(nonatomic,unsafe_unretained) id<ParallaxViewDelegate> delegate;


/*
 * set the transparent layer view
 */
-(void)maskViewCover:(UIView*) mContentView;

/*
 * set the top float layer view
 */
-(void) floatLayerView:(UIView *) floatView;


@end
