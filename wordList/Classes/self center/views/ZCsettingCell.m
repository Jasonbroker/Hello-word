//
//  ZCsettingCell.m
//  wordList
//
//  Created by Jason Zhou on 7/24/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCsettingCell.h"

@implementation ZCsettingCell
//********************************    init     *******************************//

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
///**************************************    setter getter    **************************************
- (void)setDataList:(NSDictionary *)dataList
{
    _dataList = dataList;
    
    self.textLabel.text = [dataList valueForKey:@"title"];
    if ([dataList valueForKey:@"detail"]) {
        self.detailTextLabel.text = [dataList valueForKey:@"detail"];
    }
    
    if ([[dataList valueForKey:@"warningColor"] boolValue]) {
        self.textLabel.textColor = [UIColor redColor];
    }
    
    if ([dataList valueForKey:@"accessory"]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
#warning not working....
    if ([[dataList valueForKey:@"center"] boolValue]) {
        
        self.textLabel.center = CGPointMake(self.contentView.bounds.size.width *0.5f, self.contentView.center.y);
    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
