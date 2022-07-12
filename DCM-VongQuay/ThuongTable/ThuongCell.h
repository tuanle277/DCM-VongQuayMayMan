#import <UIKit/UIKit.h>
#import "GiaiThuongModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThuongCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *phanThuongBackground;
@property (weak, nonatomic) IBOutlet UIView *thoiGianBackground;
@property (weak, nonatomic) IBOutlet UILabel *phanThuongLabel;
@property (weak, nonatomic) IBOutlet UILabel *thoigianLabel;

- (void) setUp: (GiaiThuong *) giaiThuong withIndexPath: (NSIndexPath *) indexPath;
+ (NSString *) identifier;
@end

NS_ASSUME_NONNULL_END
