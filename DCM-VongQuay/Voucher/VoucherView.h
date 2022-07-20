#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VoucherViewDelegate <NSObject>
- (void) tangLuotQuay;
@end

@interface VoucherView : UIView
@property int lanQuay;
@property (weak, nonatomic) id <VoucherViewDelegate> delegate;
- (void) show;


@end



NS_ASSUME_NONNULL_END
