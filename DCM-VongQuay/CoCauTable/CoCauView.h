#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoCauView : UIView <UITableViewDelegate, UITableViewDataSource>
@property (retain, nonatomic) UITableView *coCauTable;
- (id)initWithFrame:(CGRect)frame withData: (NSMutableArray *) data;
- (void) show;

@end

NS_ASSUME_NONNULL_END
