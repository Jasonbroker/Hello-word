//
//  ZCDetailViewController.h
//  wordList
//
//  Created by Jason Zhou on 7/10/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCDetailViewController : UIViewController
/** will be updated into a model */
@property (nonatomic ,strong) NSString *word;

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

@end
