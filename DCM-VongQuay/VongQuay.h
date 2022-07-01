#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HanhDongQuay.h"
#import "PhanVongQuay.h"

NS_ASSUME_NONNULL_BEGIN

@interface VongQuay : UIView

@property UIView *circle;
@property UIView

- (id) initWithFrame:(CGRect)frame withSections:(int)sectionsNumber;

- (void) rotate;

@end

NS_ASSUME_NONNULL_END
