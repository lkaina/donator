//
//  OrgDataViewController.m
//  donation
//
//  Created by Leighton Kaina on 11/2/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import "OrgDataViewController.h"

@interface OrgDataViewController ()

@property (nonatomic, strong) IBOutlet CPTGraphHostingView *hostView;
@property (nonatomic, strong) CPTBarPlot *firstPlot;
@property (nonatomic, strong) CPTBarPlot *secondPlot;
@property (nonatomic, strong) CPTBarPlot *thirdPlot;
@property (nonatomic, strong) CPTBarPlot *fourthPlot;
@property (nonatomic, strong) CPTBarPlot *fifthPlot;


@property (nonatomic, strong) CPTPlotSpaceAnnotation *priceAnnotation;

-(void)initPlot;
-(void)configureGraph;
-(void)configurePlots;
-(void)configureAxes;
-(void)hideAnnotation:(CPTGraph *)graph;

@end

@implementation OrgDataViewController

{
    NSArray *_top5;
}

CGFloat const CPDOrgBarWidth = 1.0f;
CGFloat const CPDOrgBarInitialX = 1.0f;

@synthesize hostView = hostView_;
@synthesize firstPlot = firstPlot_;
@synthesize secondPlot    = secondPlot_;
@synthesize thirdPlot    = thirdPlot_;
@synthesize fourthPlot    = fourthPlot_;
@synthesize fifthPlot    = fifthPlot_;


@synthesize priceAnnotation = priceAnnotation_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.noDataLabel.hidden = YES;
    hostView_.hidden = NO;
    
    PFQuery *query = [PFQuery queryWithClassName:@"OrgView"];
    [query orderByDescending:@"orgDonation"];
    [query addDescendingOrder:@"updatedAt"];
    query.limit = 5;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error retrieving query data");
        } else if (![objects count]) {
            self.noDataLabel.hidden = NO;
            hostView_.hidden = YES;
        } else {
            _top5 = objects;
            [self initPlot];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Chart behavior
-(void)initPlot
{
    self.hostView.allowPinchScaling = NO;
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
}

-(void)configureGraph
{
    // 1 - Create the graph
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
    graph.plotAreaFrame.masksToBorder = NO;
    self.hostView.hostedGraph = graph;
    // 2 - Configure the graph
    [graph applyTheme:[CPTTheme themeNamed:kCPTPlainBlackTheme]];
    graph.paddingBottom = 30.0f;
    graph.paddingLeft  = 30.0f;
    graph.paddingTop    = -0.5f;
    graph.paddingRight  = -0.5f;
    // 3 - Set up styles
    CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
    titleStyle.color = [CPTColor whiteColor];
    titleStyle.fontName = @"Helvetica-Bold";
    titleStyle.fontSize = 14.0f;
    // 4 - Set up title
    NSString *title = @"Charity Donations Data";
    graph.title = title;
    graph.titleTextStyle = titleStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, -16.0f);
    // 5 - Set up plot space
    CGFloat xMin = 0.0f;
    CGFloat xMax = 10.0f;
    CGFloat yMin = 0.0f;
    CGFloat yMax = 1.0f;  // should determine dynamically based on max price
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xMin) length:CPTDecimalFromFloat(xMax)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(yMin) length:CPTDecimalFromFloat(yMax)];
}

-(void)configurePlots
{
    // 1 - Set up the three plots
    self.firstPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor redColor] horizontalBars:YES];
    self.firstPlot.identifier = @"1st";
    self.secondPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor greenColor] horizontalBars:YES];
    self.secondPlot.identifier = @"2nd";
    self.thirdPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor blueColor] horizontalBars:YES];
    self.thirdPlot.identifier = @"3rd";
    self.fourthPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor yellowColor] horizontalBars:YES];
    self.fourthPlot.identifier = @"4th";
    self.fifthPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor orangeColor] horizontalBars:YES];
    self.fifthPlot.identifier = @"5th";
    
    
    // 2 - Set up line style
    CPTMutableLineStyle *barLineStyle = [[CPTMutableLineStyle alloc] init];
    barLineStyle.lineColor = [CPTColor lightGrayColor];
    barLineStyle.lineWidth = 0.5;
    // 3 - Add plots to graph
    CPTGraph *graph = self.hostView.hostedGraph;
    CGFloat barX = 0.6f;
    CGFloat barWidth = 0.1f;
    NSArray *plots = [NSArray arrayWithObjects:self.firstPlot, self.secondPlot, self.thirdPlot, self.fourthPlot, self.fifthPlot, nil];
    for (CPTBarPlot *plot in plots) {
        plot.dataSource = self;
        plot.delegate = self;
        plot.barWidthsAreInViewCoordinates = NO;
        plot.barWidth = CPTDecimalFromDouble(barWidth);
        plot.barOffset = CPTDecimalFromDouble(barX + barWidth);
        plot.lineStyle = barLineStyle;
        [graph addPlot:plot toPlotSpace:graph.defaultPlotSpace];
        barX -= 0.15f;
    }
}

-(void)configureAxes
{
    // 1 - Configure styles
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor whiteColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 10.0f;
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 1.0f;
    axisLineStyle.lineColor = [[CPTColor whiteColor] colorWithAlphaComponent:1];
    // 2 - Get the graph's axis set
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
    // 3 - Configure the x-axis
    axisSet.xAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    axisSet.xAxis.title = @"Charity";
    axisSet.xAxis.titleTextStyle = axisTitleStyle;
    axisSet.xAxis.titleOffset = 10.0f;
    axisSet.xAxis.axisLineStyle = axisLineStyle;
    // 4 - Configure the y-axis
    axisSet.yAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    axisSet.yAxis.title = @"Total Contributions";
    axisSet.yAxis.titleTextStyle = axisTitleStyle;
    axisSet.yAxis.titleOffset = 5.0f;
    axisSet.yAxis.axisLineStyle = axisLineStyle;
}

-(void)hideAnnotation:(CPTGraph *)graph
{
    
}

#pragma mark - CPTPlotDataSource methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return 1;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSDecimalNumber *num = nil;
    if ( [plot isKindOfClass:[CPTBarPlot class]] ) {
        switch ( fieldEnum ) {
            case CPTBarPlotFieldBarLocation:
                num = (NSDecimalNumber *)[NSDecimalNumber numberWithUnsignedInteger:index];
                NSLog(@"location: %@",num );
                break;
                
            case CPTBarPlotFieldBarTip:
                num = 0;
                if ([plot.identifier  isEqual: @"1st"]) {
                    num = [_top5 objectAtIndex:0][@"orgDonation"];
                } else if ([_top5 count] > 1 && [plot.identifier  isEqual: @"2nd"]) {
                    num = [_top5 objectAtIndex:1][@"orgDonation"];
                } else if ([_top5 count] > 2 && [plot.identifier  isEqual: @"3rd"]) {
                    num = [_top5 objectAtIndex:2][@"orgDonation"];
                } else if ([_top5 count] > 3 && [plot.identifier  isEqual: @"4th"]) {
                    num = [_top5 objectAtIndex:3][@"orgDonation"];
                } else if ([_top5 count] > 4 && [plot.identifier  isEqual: @"5th"]) {
                    num = [_top5 objectAtIndex:4][@"orgDonation"];
                }
                NSLog(@"tip: %@", num);
                break;
        }
    }
    
    return num;
}

#pragma mark - CPTBarPlotDelegate methods
-(void)barPlot:(CPTBarPlot *)plot barWasSelectedAtRecordIndex:(NSUInteger)index
{
    // 1 - Is the plot hidden?
    if (plot.isHidden == YES) {
        return;
    }
    // 2 - Create style, if necessary
    static CPTMutableTextStyle *style = nil;
    if (!style) {
        style = [CPTMutableTextStyle textStyle];
        style.color= [CPTColor yellowColor];
        style.fontSize = 16.0f;
        style.fontName = @"Helvetica-Bold";
    }
    // 3 - Create annotation, if necessary
    NSNumber *price = [self numberForPlot:plot field:CPTBarPlotFieldBarTip recordIndex:index];
    if (!self.priceAnnotation) {
        NSNumber *x = [NSNumber numberWithInt:0];
        NSNumber *y = [NSNumber numberWithInt:0];
        NSArray *anchorPoint = [NSArray arrayWithObjects:x, y, nil];
        self.priceAnnotation = [[CPTPlotSpaceAnnotation alloc] initWithPlotSpace:plot.plotSpace anchorPlotPoint:anchorPoint];
    }
    // 4 - Create number formatter, if needed
    static NSNumberFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSNumberFormatter alloc] init];
        [formatter setMaximumFractionDigits:2];
    }
    // 5 - Create text layer for annotation
    NSString *priceValue = [formatter stringFromNumber:price];
    CPTTextLayer *textLayer = [[CPTTextLayer alloc] initWithText:priceValue style:style];
    self.priceAnnotation.contentLayer = textLayer;
    // 6 - Get plot index based on identifier
    NSInteger plotIndex = 0;
    
    // 7 - Get the anchor point for annotation
    CGFloat x = index + CPDOrgBarInitialX + (plotIndex * CPDOrgBarWidth);
    NSNumber *anchorX = [NSNumber numberWithFloat:x];
    CGFloat y = [price floatValue] + 40.0f;
    NSNumber *anchorY = [NSNumber numberWithFloat:y];
    self.priceAnnotation.anchorPlotPoint = [NSArray arrayWithObjects:anchorX, anchorY, nil];
    // 8 - Add the annotation
    [plot.graph.plotAreaFrame.plotArea addAnnotation:self.priceAnnotation];
}

- (IBAction)donePressed:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
