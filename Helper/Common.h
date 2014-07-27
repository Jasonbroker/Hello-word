/**
* customed logout
*/

#define KwordInSection 15

#ifdef DEBUG
#define Mylog(...)      NSlog(__VA_ARGS__)
//#elif
//#define Mylog(...)
#endif

/**
*   log function
*/

#define LogFunc         MyLog(@"%s", __func__);
#define LogObj(obj)         MyLog(@"%@", obj);
#define LogFrame(view)      MyLog(@"%@", NSStringFromCGRect(view.frame))
#define LogBounds(view)     MyLog(@"%@", NSStringFromCGRect(view.bounds))

#define KUserReadingProgressMarkerKey @"userReadingProgressMarker"
#define KUserMaxReadingProgressMarkerKey @"userMaxReadingProgressMarker"

/**
 define cell height
 */

#define KcellHeight 60.0

/**
 define system font size
 */
#define KcellFontSize [UIFont systemFontOfSize:15.0f]


/** import */

#import "ZCbBaiscViewController.h"

#define iOS7    ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)

#define iPhone4inch ([NSStringFromCGRect([UIScreen mainScreen].bounds) isEqualToString: @"{{0, 0}, {320, 568}}"])


