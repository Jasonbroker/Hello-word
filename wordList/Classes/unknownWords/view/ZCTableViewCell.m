//
//  ZCTableViewCell.m
//  wordList
//
//  Created by Jason Zhou on 7/21/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCTableViewCell.h"
#import "Common.h"
@interface ZCTableViewCell()

@property (nonatomic, strong) CALayer *backgroundLayer;

@end

@implementation ZCTableViewCell


- (void)awakeFromNib {
    // Initialization code
    self.backgroundLayer = [CALayer layer];
    self.backgroundLayer.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.2f ].CGColor;
    
    [self.contentView.layer addSublayer:_backgroundLayer];
    
    self.textLabel.font = KcellFontSize;
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    
    CGFloat x = self.textLabel.frame.origin.x;
    CGFloat h = 1;
    CGFloat y = self.contentView.bounds.size.height - h;
    CGFloat w = self.bounds.size.width -x ;
    self.backgroundLayer.frame = CGRectMake(x, y, w, h);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end