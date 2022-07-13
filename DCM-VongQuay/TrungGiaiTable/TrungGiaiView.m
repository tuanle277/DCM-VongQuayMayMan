#import "trungGiaiView.h"
#import "TrungGiaiCell.h"
#import "TrungGiaiHeader.h"

@interface TrungGiaiView ()
{
    UIView *backgroundView;
    UIView *superview;
    UIView *titleView;
    UITableView *tableView;
    NSMutableArray *datas;
}

@end

@implementation TrungGiaiView

- (id)initWithFrame:(CGRect)frame withData: (NSMutableArray *) data {
    self = [super initWithFrame: frame];
    datas = data;
    superview = [UIApplication sharedApplication].keyWindow;
    [self configureTableBackground: frame];
    [self configureTableView];
    [self configureTableTitle];
    [superview addSubview: titleView];
    return self;
}

- (void)configureTableTitle
{
    titleView = [[UIView alloc] initWithFrame: CGRectMake(backgroundView.frame.origin.x + backgroundView.frame.size.width / 4, backgroundView.frame.origin.y - backgroundView.frame.size.height / 6, backgroundView.frame.size.width / 2, backgroundView.frame.size.height / 6)];
    titleView.backgroundColor = UIColor.whiteColor;
    titleView.layer.borderWidth = 2.0;
    UILabel *title = [[UILabel alloc] initWithFrame: CGRectMake(titleView.bounds.origin.x + titleView.frame.size.width / 20, titleView.frame.size.height / 3, titleView.frame.size.width * 9/10, titleView.frame.size.height / 3)];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = UIColor.blackColor;
    title.text = @"Danh sách người chơi trúng giải";
    title.adjustsFontSizeToFitWidth = TRUE;
    [titleView addSubview: title];
}

- (void)configureTableBackground: (CGRect) frame
{
    backgroundView = [[UIView alloc] initWithFrame: frame];
    backgroundView.backgroundColor = UIColor.whiteColor;
    backgroundView.layer.borderWidth = 2.0;
}

- (void)configureTableView
{
    self.backgroundColor = [UIColor colorWithRed: 0.8 green:0.0 blue:0.0 alpha:0.3];
    tableView = [[UITableView alloc] initWithFrame: CGRectMake(backgroundView.bounds.origin.x, backgroundView.bounds.origin.y + backgroundView.frame.size.height / 4, backgroundView.bounds.size.width, backgroundView.bounds.size.height * 3 / 4)];
    tableView.showsVerticalScrollIndicator = YES;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib: [UINib nibWithNibName: TrungGiaiCell.identifier  bundle:nil] forCellReuseIdentifier: TrungGiaiCell.identifier];
    tableView.rowHeight = 100;
    tableView.estimatedRowHeight = 100;
    TrungGiaiHeader *header = [[TrungGiaiHeader alloc] initWithFrame: CGRectMake(backgroundView.bounds.origin.x, backgroundView.bounds.origin.y, backgroundView.bounds.size.width, backgroundView.frame.size.height / 4)];
    [superview addSubview: self];
    [superview addSubview: backgroundView];
    [backgroundView addSubview: header];
    [backgroundView addSubview: tableView];
}

- (void)show
{
    self.frame = superview.bounds;
    backgroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    [UIView animateWithDuration:0.7
                     animations:^{
                         self->backgroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                     }];
    titleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    [UIView animateWithDuration:0.7
                     animations:^{
                         self->titleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                     }];
    tableView.allowsSelection = FALSE;
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.hidden = TRUE;
    backgroundView.hidden = TRUE;
    titleView.hidden = TRUE;
}

- (nonnull TrungGiaiCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    TrungGiaiCell * cell;
    cell = [tableView dequeueReusableCellWithIdentifier: TrungGiaiCell.identifier forIndexPath: indexPath];
    NguoiChoiTrungGiai *nguoiChoi = datas[indexPath.row];
    [cell setUp: nguoiChoi withIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [datas count];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
