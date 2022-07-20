#import "CoCauView.h"
#import "CoCauHeader.h"
#import "CoCauCell.h"

@interface CoCauView()
{
    UIView *backgroundView;
    UIView *superview;
    UIView *titleView;
    UITableView *tableView;
    NSMutableArray *datas;
}

@end

#pragma mark coCauView

@implementation CoCauView

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
    UILabel *title = [[UILabel alloc] initWithFrame: CGRectMake(titleView.bounds.origin.x, titleView.frame.size.height / 3, titleView.frame.size.width, titleView.frame.size.height / 3)];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = UIColor.blackColor;
    title.text = @"Giải thưởng";
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
    tableView = [[UITableView alloc] initWithFrame: CGRectMake(backgroundView.bounds.origin.x, backgroundView.bounds.origin.y + backgroundView.bounds.size.height / 4, backgroundView.bounds.size.width, backgroundView.frame.size.height * 3 / 4)];
    tableView.showsVerticalScrollIndicator = YES;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib: [UINib nibWithNibName: CoCauCell.identifier bundle:nil] forCellReuseIdentifier: CoCauCell.identifier];
    CoCauHeader *header = [[CoCauHeader alloc] initWithFrame: CGRectMake(backgroundView.bounds.origin.x, backgroundView.bounds.origin.y, backgroundView.frame.size.width, backgroundView.frame.size.height / 4)];
    [superview addSubview: self];
    [superview addSubview: backgroundView];
    [backgroundView addSubview: header];
    [backgroundView addSubview: tableView];
    NSLog(@"backgroundView width is %f, tableView width is %f", backgroundView.frame.size.width, tableView.frame.size.width);
    NSLog(@"backgroundView height is %f, tableView height is %f", backgroundView.frame.size.height, backgroundView.frame.size.height);
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
    tableView.estimatedRowHeight = 85;
    tableView.rowHeight = tableView.frame.size.height / 3;
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.hidden = TRUE;
    backgroundView.hidden = TRUE;
    titleView.hidden = TRUE;
}

- (nonnull CoCauCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CoCauCell * cell;
    cell = [tableView dequeueReusableCellWithIdentifier: CoCauCell.identifier forIndexPath: indexPath];
    GiaiThuong *giaiThuong = datas[indexPath.row];
    [cell setUp: giaiThuong withIndexPath:indexPath];
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
