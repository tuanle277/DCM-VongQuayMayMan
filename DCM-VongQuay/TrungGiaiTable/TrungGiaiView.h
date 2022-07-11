#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TrungGiaiView : UIView <UITableViewDelegate, UITableViewDataSource>
@property (retain, nonatomic) UITableView *trungGiaiTable;
- (id)initWithFrame:(CGRect)frame withData: (NSMutableArray *) data;
- (void) show;
@end

NS_ASSUME_NONNULL_END
