#import <UIKit/UIKit.h>
#import "NguoiChoiTrungGiaiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrungGiaiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *nguoiChoiBackground;
@property (weak, nonatomic) IBOutlet UIView *SDTBackground;
@property (weak, nonatomic) IBOutlet UIView *phanThuongBackground;
@property (weak, nonatomic) IBOutlet UIView *thoiGianBackground;
@property (weak, nonatomic) IBOutlet UILabel *nguoiChoiLabel;
@property (weak, nonatomic) IBOutlet UILabel *SDTLabel;
@property (weak, nonatomic) IBOutlet UILabel *phanThuongLabel;
@property (weak, nonatomic) IBOutlet UILabel *thoiGianLabel;

- (void) setUp: (NguoiChoiTrungGiai *) nguoiChoi withIndexPath: (NSIndexPath *) indexPath;
+ (NSString *) identifier;
@end

NS_ASSUME_NONNULL_END
