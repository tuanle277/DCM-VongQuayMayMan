#import "CoCauView.h"
#import "CoCauHeader.h"
#import "CoCauCell.h"

@interface CoCauView()
{
    UIView *backgroundView;
    UIView* superview;
    UITableView *tableView;
    NSMutableArray *datas;
}

@end

@implementation CoCauView

- (id)initWithFrame:(CGRect)frame withData: (NSMutableArray *) data {
  // add your custom subviews here
  // An example of a custom background color:
    self = [super initWithFrame: frame];
    datas = data;
    superview = [UIApplication sharedApplication].keyWindow;
    backgroundView = [[UIView alloc] initWithFrame: frame];
    backgroundView.backgroundColor = UIColor.whiteColor;
    self.backgroundColor = [UIColor colorWithRed: 0.8 green:0.0 blue:0.0 alpha:0.3];
    tableView = [[UITableView alloc] initWithFrame: CGRectMake(backgroundView.bounds.origin.x, backgroundView.bounds.origin.y + 100, backgroundView.bounds.size.width, backgroundView.bounds.size.height - 100)];
    tableView.showsVerticalScrollIndicator = YES;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib: [UINib nibWithNibName: @"CoCauCell" bundle:nil] forCellReuseIdentifier:@"CoCauCell"];
    tableView.rowHeight = 85;
    tableView.estimatedRowHeight = 85;
    CoCauHeader *header = [[CoCauHeader alloc] initWithFrame: CGRectMake(backgroundView.bounds.origin.x, backgroundView.bounds.origin.y, backgroundView.bounds.size.width, 100)];
    [superview addSubview: self];
    [superview addSubview: backgroundView];
    [backgroundView addSubview: header];
    [backgroundView addSubview: tableView];
    return self;
}

- (void)show
{
    self.frame = superview.bounds;
    backgroundView.hidden = FALSE;
    tableView.allowsSelection = FALSE;
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches are %@", touches);
    self.hidden = TRUE;
    backgroundView.hidden = TRUE;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (nonnull CoCauCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CoCauCell * cell;
    cell = [tableView dequeueReusableCellWithIdentifier: @"CoCauCell" forIndexPath: indexPath];
    GiaiThuong *giaiThuong = datas[indexPath.row];
    [cell setUp: giaiThuong withIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [datas count];
}




@end
