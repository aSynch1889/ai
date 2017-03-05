//
//  HMNavigationMapViewController.m
//  HealthMall
//
//  Created by qiuwei on 15/12/27.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMNavigationMapViewController.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Utils/BMKGeometry.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKRouteSearch.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Base/BMKTypes.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>//编码
#import "UIImage+HMExtension.h"
#import "HMHUD.h"
#import "HMPointAnnotation.h"
#import "HMPaopaoView.h"
#import "HMLocationTool.h"

#define BMKBUNDLE_NAME @"mapapi.bundle"
#define BMKBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: BMKBUNDLE_NAME]
#define BMKBUNDLE [NSBundle bundleWithPath: BMKBUNDLE_PATH]

#define kMapViewCoordinateSpan BMKCoordinateSpanMake(0.02, 0.02) // 坐标范围
#define kMapViewIcon_Marker_myPoint [UIImage imageNamed:@"icon_Marker_myPoint"]
#define kMapViewPaopViewMargin 20.0

@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
    int _degree;
}
@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@end

@interface HMNavigationMapViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, BMKRouteSearchDelegate, BMKGeoCodeSearchDelegate>
{
    BOOL _isSetMapSpan; // 是否已经设置锁定显示区域时
    BOOL _isUpdateMyLoca; // 是否需要更新自己的位置
    BMKLocationService *_locService;
    BMKRouteSearch *_routesearch;
}
@property (strong, nonatomic) BMKMapView *mapView;
@property (nonatomic, weak) UIButton *myPointButton;
@property (nonatomic, weak) UISegmentedControl *segmented;
@property (nonatomic, strong) HMPointAnnotation *targetAnnotation;  // 目标对象
@property (nonatomic, strong) BMKGeoCodeSearch *geocodesearch;       // 编码对象
@end

@implementation HMNavigationMapViewController

#pragma mark -
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"查看路线";
    self.view.backgroundColor = HMBackgroundColor;
    
    [[HMLocationTool shared] reStartMapManager];
    
    _locService = [[BMKLocationService alloc] init];
    _routesearch = [[BMKRouteSearch alloc]init];
    
    // 先关闭显示的定位图层
    self.mapView.showsUserLocation = NO;
    self.mapView.frame = self.view.bounds;
    [self.view insertSubview:self.mapView atIndex:0];
    
    [self myPointButton];
    
    
    // 设置配置
    [self setUpMapViewProperty];
    
    UIView *navBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 64)];
    navBg.backgroundColor = HMNavBgColor;
    [self.view addSubview:navBg];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    _locService.delegate = self;
    _routesearch.delegate = self;
    [_locService startUserLocationService];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    _locService.delegate = nil;
    [_locService stopUserLocationService];
    _locService = nil;
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    _routesearch.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [self viewWillDisappear:YES];
    [_locService stopUserLocationService];
    _locService = nil;
    self.mapView.showsUserLocation = NO;
    [self.mapView removeFromSuperview];
    self.mapView = nil;
    _routesearch = nil;
    
}

- (void)setUpMapViewProperty
{
    self.mapView.showsUserLocation = NO;
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;
    self.mapView.showsUserLocation = YES; //是否显示定位图层（即我的位置的小圆点）
    self.mapView.zoomLevel = 4;//地图显示比例
}

#pragma mark -
#pragma mark - <BMKLocationServiceDelegate>
// 更新位置
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
    
    // 一般情况使用开始位置
    if (self.startNode.pt.latitude && self.startNode.pt.longitude) {
        coordinate = self.startNode.pt;
    }else{
        self.startNode.pt = coordinate;
    }
    
    // 需要更新自己位置的就更新
    if (_isUpdateMyLoca) {
        _isUpdateMyLoca = NO;
        coordinate = userLocation.location.coordinate;
        [self.mapView updateLocationData:userLocation];
    }
    
    // 这里用一个变量判断一下,只在第一次锁定显示区域时 设置一下显示范围 Map Region
    if (!_isSetMapSpan){
        _isSetMapSpan = YES;
        
        if(self.targetNode.pt.latitude){
            
            coordinate = self.targetNode.pt;
            
            if ( NotNilAndNull(self.targetNode.cityName) || NotNilAndNull(self.targetNode.name)) {// 直接显示
                [self showTargetAnnotation:self.targetNode];
            }else{// 编码后再显示
                [self reverseGeoCodeWithCoordinate:coordinate];
            }
            
        }
        
        [self setMapRegionWithCoordinate:coordinate];
    }
}

// 获取位置失败
- (void)didFailToLocateUserWithError:(NSError *)error
{
    [HMHUD showErrorWithStatus:@"获取位置失败"];
}

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    _isSetMapSpan = NO;
    // 默认显示步行
    if (self.targetNode) {
        [self onClickWalkSearch];
        [self.segmented setSelectedSegmentIndex:2];
    }
}


#pragma mark -
#pragma mark - Event 
- (void)segmentedClick:(UISegmentedControl *)seg
{
    NSInteger index = seg.selectedSegmentIndex;
    NSLog(@"Index %zd", index);
    switch (index) {
        case 0:
            [self onClickBusSearch];
            break;
        case 1:
            [self onClickDriveSearch];
            break;
        case 2:
            [self onClickWalkSearch];
            break;
        default:
            break;
    }
}
- (void)myPointClick
{
    LogFunc;
    _isUpdateMyLoca = YES;
    [_locService startUserLocationService];
    [self setMapRegionWithCoordinate:_locService.userLocation.location.coordinate];
}

#pragma mark - Private
// 反编码获取城市
- (void)reverseGeoCodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeocodeSearchOption.reverseGeoPoint = coordinate;
    BOOL flag = [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag){
        NSLog(@"反geo检索发送成功");
    }else{
        NSLog(@"反geo检索发送失败");
    }
}

//  检索路线 Route
- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
    BMKAnnotationView* view = nil;
    switch (routeAnnotation.type) {
        case 0:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 1:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 2:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 3:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 4:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
            
        }
            break;
        case 5:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
        }
            break;
        default:
            break;
    }
    
    return view;
}

// 传入经纬度,将baiduMapView 锁定到以当前经纬度为中心点的显示区域和合适的显示范围
- (void)setMapRegionWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    BMKCoordinateRegion region;
    
    // 越小地图显示越详细
    region = BMKCoordinateRegionMake(coordinate, kMapViewCoordinateSpan);
    [self.mapView setRegion:region animated:YES];//执行设定显示范围
    // 根据提供的经纬度为中心原点 以动画的形式移动到该区域
    [self.mapView setCenterCoordinate:coordinate animated:YES];
}

#pragma mark -
#pragma mark - setter/getter
- (BMKMapView *)mapView
{
    if (_mapView == nil) {
        BMKMapView *mapView = [[BMKMapView alloc] init];
        mapView.delegate = self;
        // 设置定位的状态
        mapView.userTrackingMode = BMKUserTrackingModeFollow;
        mapView.showsUserLocation = YES;
        _mapView = mapView;
    }
    return _mapView;
}

- (UISegmentedControl *)segmented
{
    if (_segmented == nil) {
        UISegmentedControl *segmented = [[UISegmentedControl alloc] initWithItems:@[@"公交", @"架乘", @"步行"]];
        segmented.backgroundColor = [UIColor whiteColor];
        segmented.tintColor = HMMainlColor;
        segmented.frame = CGRectMake(0, kNavBarHeight - 3, self.view.width, 40.0);
        [segmented addTarget:self action:@selector(segmentedClick:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:segmented];
        _segmented = segmented;
    }
    return _segmented;
}
- (UIButton *)myPointButton
{
    if (_myPointButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"icon_button_myPoint"] forState:UIControlStateNormal];
        CGFloat margin = 20.0;
        CGFloat buttonWH = 35.0;
        btn.frame = CGRectMake(margin, self.mapView.height - (buttonWH + margin * 2), buttonWH, buttonWH);
        [btn addTarget:self action:@selector(myPointClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _myPointButton = btn;
    }
    return _myPointButton;
}

- (BMKPlanNode *)startNode
{
    if (_startNode == nil) {
        _startNode = [[BMKPlanNode alloc] init];
    }
    return _startNode;
}


#pragma mark - <BMKMapViewDelegate>
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
    }else{
        // 普通annotation
        NSString *AnnotationViewID = @"renameMark";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            // 从天上掉下效果
//            annotationView.animatesDrop = YES;
        }
        annotationView.image = kMapViewIcon_Marker_myPoint;
        annotationView.selected = YES;
        
        // paopaoVIew
        HMPaopaoView *paoView = [[HMPaopaoView alloc] init];
        paoView.pointAnnotation = annotation;
        paoView.backgroundColor = [UIColor whiteColor];
        paoView.width = kSCREEN_WIDTH - kMapViewPaopViewMargin * 2;
        [paoView layoutSubviews];
        paoView.state = HMPaopaoViewStateNor;
        annotationView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:paoView];
        return annotationView;
    }
    
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:1];
        polylineView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

#pragma mark - <BMKGeoCodeSearchDelegate>
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
        // 显示目标大头针
        self.targetNode.cityName = result.addressDetail.city;
        self.targetNode.name = result.address;
        [self showTargetAnnotation:self.targetNode];
    }
}

#pragma mark - <BMKRouteSearchDelegate>
- (void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKTransitRouteLine* plan = (BMKTransitRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.instruction;
            item.type = 3;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation *item = [[RouteAnnotation alloc] init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [_mapView addAnnotation:item];
            }
        }
        //轨迹点
        BMKMapPoint *temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}

- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)[result.routes objectAtIndex:0];
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}

- (void)onClickBusSearch
{
    _isUpdateMyLoca = NO;
    BMKTransitRoutePlanOption *transitRouteSearchOption = [[BMKTransitRoutePlanOption alloc]init];
    transitRouteSearchOption.city= self.targetNode.cityName;
    transitRouteSearchOption.from = self.startNode;
    transitRouteSearchOption.to = self.targetNode;
    BOOL flag = [_routesearch transitSearch:transitRouteSearchOption];
    
    if(flag){
        NSLog(@"bus检索发送成功");
    }else{
        NSLog(@"bus路线检索失败");
        [HMHUD showErrorWithStatus:@"路线检索失败"];
    }
}

- (void)onClickDriveSearch
{

    _isUpdateMyLoca = NO;
    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
    drivingRouteSearchOption.from = self.startNode;
    drivingRouteSearchOption.to = self.targetNode;
    BOOL flag = [_routesearch drivingSearch:drivingRouteSearchOption];
    if(flag)
    {
        NSLog(@"car检索发送成功");
    }else{
        NSLog(@"car路线检索失败");
        [HMHUD showErrorWithStatus:@"路线检索失败"];
    }
    
}

-(void)onClickWalkSearch
{
    _isUpdateMyLoca = NO;
    BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc]init];
    walkingRouteSearchOption.from = self.startNode;
    walkingRouteSearchOption.to = self.targetNode;
    BOOL flag = [_routesearch walkingSearch:walkingRouteSearchOption];
    if(flag)
    {
        NSLog(@"walk检索发送成功");
    }else{
        NSLog(@"walk路线检索失败");
        [HMHUD showErrorWithStatus:@"路线检索失败"];
    }
    
}

//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [_mapView setVisibleMapRect:rect];
    _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
}

- (NSString*)getMyBundlePath1:(NSString *)filename
{
    NSBundle * libBundle = BMKBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}

// 显示目标地址
- (void)showTargetAnnotation:(BMKPlanNode *)point
{
    self.targetAnnotation.title = point.cityName;
    self.targetAnnotation.subtitle = point.name;
    self.targetAnnotation.coordinate = point.pt;
    
    [self.mapView removeAnnotation:self.targetAnnotation];
    [self.mapView addAnnotation:self.targetAnnotation];
    [self.mapView showAnnotations:@[self.targetAnnotation] animated:YES];
}

- (HMPointAnnotation *)targetAnnotation
{
    if (_targetAnnotation == nil) {
        _targetAnnotation = [[HMPointAnnotation alloc] init];
    }
    return _targetAnnotation;
}

- (BMKGeoCodeSearch *)geocodesearch
{
    if (_geocodesearch == nil) {
        _geocodesearch = [[BMKGeoCodeSearch alloc] init];
        _geocodesearch.delegate = self;
    }
    return _geocodesearch;
}
@end
