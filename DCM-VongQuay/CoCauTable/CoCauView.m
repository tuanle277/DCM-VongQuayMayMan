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

@implementation CoCauView

- (id)initWithFrame:(CGRect)frame withData: (NSMutableArray *) data {
    self = [super initWithFrame: frame];
    NSLog(@"%@", datas);
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
    titleView = [[UIView alloc] initWithFrame: CGRectMake(backgroundView.frame.origin.x + backgroundView.frame.size.width / 4, backgroundView.frame.origin.y - 50, backgroundView.frame.size.width / 2, 50)];
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
}

- (void)show
{
    self.frame = superview.bounds;
    titleView.hidden = FALSE;
    backgroundView.hidden = FALSE;
    tableView.allowsSelection = FALSE;
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
    cell = [tableView dequeueReusableCellWithIdentifier: @"CoCauCell" forIndexPath: indexPath];
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
