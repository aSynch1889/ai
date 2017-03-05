//
//  HMFilterMapViewController.m
//  HealthMall
//
//  Created by qiuwei on 15/12/27.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMFilterMapViewController.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Utils/BMKGeometry.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import "HMPaopaoView.h"
#import "HMSegmentedView.h"
#import "HMFormFootView.h"
#import "HMHUD.h"
#import "HMRefresh.h"

#define kMapViewCoordinateSpan BMKCoordinateSpanMake(0.02, 0.02) // 坐标范围
#define kMapViewPaopViewMargin 20.0
#define kMapViewSegmentedViewH 45.0
#define kMapViewIcon_Marker_myPoint [UIImage imageNamed:@"icon_Marker_myPoint"]
#define kMapViewIcon_Marker_nor [UIImage imageNamed:@"icon_Marker_nor"]
#define kMapViewIcon_Marker_sel [UIImage imageNamed:@"icon_Marker_sel"]
#define kMapViewSearchPageCount 2000  // 检索页条数
#define kMapViewSearchRadius 20 // 检索范围 m

@interface HMFilterMapViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate, HMSegmentedViewDelegate,BMKPoiSearchDelegate , UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
{
    BOOL _isGeoingMyPoint;  // 正在编码我的位置
    BOOL _isSetMapSpan; // 是否已经设置锁定显示区域时
    BOOL _isUpdateMyLoca; // 是否需要更新自己的位置
    BMKLocationService *_locService; // 定位
    BMKGeoCodeSearch *_geocodesearch;// 编码
    BMKPoiSearch *_poisearch;       // 搜索
    HMPointAnnotation *_selectPointAnnotation;
    int _currentSearchPage;// 当前搜索页码
    
    NSString *_paopaoViewButtonTitle;
    NSString *_paopaoViewButtonSelTitle;
}
@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, weak) HMSegmentedView *segmentedView;
@property (nonatomic, weak) HMFormFootView *footView;
@property (nonatomic, weak) UIButton *myPointButton;
@property (nonatomic, weak) UIView *coverView;
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) UITableView *resultsTableView;

@property (nonatomic, strong) HMPointAnnotation *myPointAnnotation;
@property (nonatomic, strong) NSMutableArray<BMKPoiInfo *> *searchResults;
@property (nonatomic, strong) NSMutableArray<HMPointAnnotation *> *selectedAnnotations;    // 选中的地址
@end

@implementation HMFilterMapViewController

- (void)dealloc
{
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
    if (_poisearch) {
        _poisearch = nil;
    }
    if (_locService) {
        _locService = nil;
    }
}

#pragma mark -
#pragma mark - 初始化
- (instancetype)init
{
    if (self = [super init]) {
        _minCount = 1;
        _maxCount = 100;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HMBackgroundColor;
    
    _isUpdateMyLoca = self.annotations.count ? NO : YES;
    _isShowMyAnnotation = _isUpdateMyLoca;
    
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    _poisearch = [[BMKPoiSearch alloc] init];
    _locService = [[BMKLocationService alloc] init];
    
    // 先关闭显示的定位图层
    self.mapView.frame = self.view.bounds;
    [self.view insertSubview:self.mapView atIndex:0];
    
    [self myPointButton];
    
    // 非单选
    if (!self.isSingleChoice) {
        [self footView];
        [self segmentedView];
        self.segmentedView.hidden = !self.selectedAnnotations;
    }
    
    // 搜索按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:kSearchIconImage style:0 target:self action:@selector(searchButtonClick)];
    
    // 设置配置
    [self setUpMapViewProperty];
    
    // 添加大头针
    [self.mapView addAnnotations:self.annotations];
    
    [self.selectedAnnotations removeAllObjects];
    
    for (HMPointAnnotation *anno in self.annotations) {
        if (anno.isSelected) {
            [self.selectedAnnotations addObject:anno];
        }
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.mapView viewWillAppear];
    _mapView.delegate = self;
    _locService.delegate = self;
    _geocodesearch.delegate = self;
    _poisearch.delegate = self;
    [_locService startUserLocationService];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    _locService.delegate = nil;
    [_locService stopUserLocationService];
    _locService = nil;
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _geocodesearch.delegate = nil;
    _poisearch.delegate = nil;
    
    [_searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [self viewWillDisappear:YES];
    [_locService stopUserLocationService];
    _locService = nil;
    _mapView.showsUserLocation = NO;
    [_mapView removeFromSuperview];
    _mapView = nil;
    _geocodesearch.delegate = nil;

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
    if (!userLocation.location) return;
    
    // 需要更新的就更新
    if (_isUpdateMyLoca || _isShowMyAnnotation) {
        _isUpdateMyLoca = NO;
        _isGeoingMyPoint = YES;

        [self reverseGeocodeWithCoordinate:userLocation.location.coordinate];
        
//        if (!_isShowMyAnnotation) {
//            [self.mapView updateLocationData:userLocation];
//        }
    }
    
    // 把地图移到第一个大头针上
    if(!_isSetMapSpan && self.annotations.count > 0){
        _isSetMapSpan = YES;
        HMPointAnnotation *anno = self.annotations[0];
        [self setMapRegionWithCoordinate:anno.coordinate];
    }
    // 这里用一个变量判断一下,只在第一次锁定显示区域时 设置一下显示范围 Map Region
    else if (!_isSetMapSpan ){
        _isSetMapSpan = YES;
        [self setMapRegionWithCoordinate:userLocation.location.coordinate];
    }
    
    
    [_locService stopUserLocationService];
}

// 获取位置失败
- (void)didFailToLocateUserWithError:(NSError *)error
{
    [HMHUD showErrorWithStatus:@"获取位置失败"];
}

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    _isSetMapSpan = NO;
    [self.mapView showAnnotations:self.annotations animated:YES];
}

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(HMPointAnnotation<BMKAnnotation> *)annotation
{
    // 普通annotation
    NSString *AnnotationViewID = @"renameMark";
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        // 从天上掉下效果
        annotationView.animatesDrop = YES;
    }
    // 设置图标
    if(annotation == _selectPointAnnotation ){
        annotationView.selected = YES;
        annotationView.draggable = YES;
        annotationView.image = kMapViewIcon_Marker_myPoint;
    }else{
        if (annotation.selected) {
            annotationView.image = kMapViewIcon_Marker_sel;
        }else{
            annotationView.image = kMapViewIcon_Marker_nor;
        }
    }

    // paopaoVIew
    HMPaopaoView *paoView = [[HMPaopaoView alloc] init];
    [paoView setButtonTitle:_paopaoViewButtonTitle selectedTitle:_paopaoViewButtonSelTitle];
    paoView.pointAnnotation = annotation;
    paoView.backgroundColor = [UIColor whiteColor];
    paoView.width = kSCREEN_WIDTH - kMapViewPaopViewMargin * 2;
    [paoView layoutSubviews];
    
    annotationView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:paoView];
    
    return annotationView;
}

// 当选中一个annotation view时，调用此接口
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
//    self.coverView.hidden = NO;
    HMPointAnnotation *annotation = view.annotation;
    
    [self setMapRegionWithCoordinate:annotation.coordinate];
    
    HMPaopaoView *paoView = (HMPaopaoView *)[[view.paopaoView subviews] firstObject];
    if([paoView isKindOfClass:[HMPaopaoView class]] && [annotation isKindOfClass:[HMPointAnnotation class]]){
        paoView.state = annotation.selected;
    }
    
}

// 当点击泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    HMPointAnnotation *pointAnnotation = view.annotation;
    
    if (![pointAnnotation isKindOfClass:[HMPointAnnotation class]]) {
        return;
    }
    
    HMPaopaoView *paoView = (HMPaopaoView *)[[view.paopaoView subviews] firstObject];
    
    pointAnnotation.selected = !pointAnnotation.selected;
    
    if (pointAnnotation == _selectPointAnnotation) {
        pointAnnotation.selected = YES;
    }
    
    // 点击添加
    if (pointAnnotation.selected) {
        view.image = kMapViewIcon_Marker_sel;
        if (![self.selectedAnnotations containsObject:pointAnnotation]) {
            [self.selectedAnnotations addObject:pointAnnotation];
        }
        paoView.state = HMPaopaoViewStateDel;
        _selectPointAnnotation = nil;
        
        if(self.isSingleChoice){// 单选
            ! _completeBlock ? : _completeBlock(self.selectedAnnotations, self.myPointAnnotation);
            return;
        }else{
            self.segmentedView.hidden = NO;
        }
        
    }
    // 点击删除
    else{
        view.image = kMapViewIcon_Marker_nor;
        [self.selectedAnnotations removeObject:pointAnnotation];
        paoView.state = HMPaopaoViewStateAdd;
        if (self.selectedAnnotations.count == 0) {
            self.segmentedView.hidden = YES;
        }
    }
    
    // 隐藏气泡
    [view setSelected:NO];
    [view.paopaoView removeFromSuperview];
    NSLog(@"paopaoclick:%@ - isSel:%d", pointAnnotation.title, pointAnnotation.selected);
}

// 点击地图空白处时会回调此接口
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    if (_justSelectFromAnnotations) return;
    
    if (!coordinate.latitude || !coordinate.longitude) return;
    
    self.mapView.showsUserLocation = NO;
    [_searchBar resignFirstResponder];
    
    [self reverseGeocodeWithCoordinate:coordinate];
}

#pragma mark - <BMKGeoCodeSearchDelegate>
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    if (error == 0) {
        
        if(self.isSingleChoice){// 单选
            [self.annotations removeAllObjects];
        }else{// 多选
            [self.annotations removeObject:_selectPointAnnotation];
        }
        
        // 是否编码我的位置
        if (_isGeoingMyPoint || _isShowMyAnnotation) {

            self.myPointAnnotation.title = result.address;
            self.myPointAnnotation.subtitle = _locService.userLocation.subtitle;
            self.myPointAnnotation.province = result.addressDetail.province;
            self.myPointAnnotation.city = result.addressDetail.city;
            self.myPointAnnotation.coordinate = result.location;
            
            if (_isShowMyAnnotation) {
                
                _isShowMyAnnotation = NO;
                
                [self.mapView removeAnnotation:_selectPointAnnotation];

                _selectPointAnnotation = self.myPointAnnotation;
                
                [self.annotations addObject:_selectPointAnnotation];
                [self.mapView addAnnotation:_selectPointAnnotation];
            }
            
        }else{
            
            NSArray *array = [NSArray arrayWithArray:self.mapView.annotations];
            [self.mapView removeAnnotations:array];
            
            _selectPointAnnotation = [[HMPointAnnotation alloc] init];
            _selectPointAnnotation.title = result.address;
            _selectPointAnnotation.coordinate = result.location;
            [self.annotations addObject:_selectPointAnnotation];
            [self.mapView addAnnotations:self.annotations];
            self.mapView.centerCoordinate = result.location;
        }
    }
    _isGeoingMyPoint = NO;
}

#pragma mark - <HMSegmentedViewDelegate>
- (void)segmentedView:(HMSegmentedView *)segmentedView didSelectedIndex:(NSUInteger)index
{
    if (index == 0) {
        [self.mapView removeAnnotations:self.selectedAnnotations];
        [self.mapView addAnnotations:self.annotations];
    }else if(index == 1){
        [self.mapView removeAnnotations:self.annotations];
        [self.mapView addAnnotations:self.selectedAnnotations];
    }
}
#pragma mark - <UISearchBarDelegate>
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    if (!self.searchBar.hidden && self.searchResults.count) {
        self.resultsTableView.hidden = NO;
    }
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) return;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%@",searchBar.text);
    if (searchBar.text.length == 0) return;
    
    [HMHUD show];
    [self.searchBar becomeFirstResponder];
    
    _currentSearchPage = 1;
    [self searchWithText:searchBar.text];
}
#pragma mark - <BMKPoiSearchDelegate>
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    if (error == BMK_SEARCH_NO_ERROR) {
        if (_currentSearchPage == 1) {
            self.searchResults = [NSMutableArray arrayWithArray:result.poiInfoList];
        }else{
            [self.searchResults addObjectsFromArray:result.poiInfoList];
        }
        
        self.resultsTableView.hidden = NO;
        [self.resultsTableView reloadData];
        _currentSearchPage++;
        [self.resultsTableView.footer endRefreshing];
        [HMHUD dismiss];
        
        NSLog(@"共搜索到%zd条数据", result.poiInfoList.count);
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"关键词有歧义");
        [self.resultsTableView.footer endRefreshingWithNoMoreData];
        [HMHUD showErrorWithStatus:@"无此地址，点击地添加吧"];
//        _currentSearchPage = _currentSearchPage - 1 < 0 ? 0 : _currentSearchPage--;
    } else {
        [self.resultsTableView.footer endRefreshingWithNoMoreData];
        [HMHUD showErrorWithStatus:@"无此地址，点击地添加吧"];
//        _currentSearchPage = _currentSearchPage - 1 < 0 ? 0 : _currentSearchPage--;
        // 各种情况的判断。。。
    }
    
    
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *HMFilterMapViewControllerCellID = @"HMFilterMapViewControllerCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HMFilterMapViewControllerCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:HMFilterMapViewControllerCellID];
        cell.textLabel.textColor = kColorBlackPercent60;
        cell.textLabel.font = HMFontSize(16.0);
        cell.detailTextLabel.textColor = kColorBlackPercent40;
    }
    BMKPoiInfo *info = self.searchResults[indexPath.row];
    cell.textLabel.text = info.name;
    cell.detailTextLabel.text = info.address;
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.searchBar resignFirstResponder];
    self.resultsTableView.hidden = YES;
    
    [self.annotations removeObject:_selectPointAnnotation];
    BMKPoiInfo *info = self.searchResults[indexPath.row];
    _selectPointAnnotation = [[HMPointAnnotation alloc] init];
    _selectPointAnnotation.title = info.address;
    _selectPointAnnotation.coordinate = info.pt;
    [self.annotations addObject:_selectPointAnnotation];
    [self.mapView addAnnotations:self.annotations];
    self.mapView.centerCoordinate = info.pt;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark - Event
// 点击我的位置
- (void)myPointClick
{
    LogFunc;
    _isUpdateMyLoca = YES;
    _isShowMyAnnotation = YES;
    [_locService startUserLocationService];
    [self setMapRegionWithCoordinate:_locService.userLocation.location.coordinate];
    self.mapView.showsUserLocation = YES;
}
// 点击确认
- (void)confirmClick
{
    if (self.selectedAnnotations.count < self.minCount) {
        [HMHUD showErrorWithStatus:[NSString stringWithFormat:@"至少选择%zd个地址", self.minCount]];
        return;
    }
    if (self.selectedAnnotations.count > self.maxCount) {
        [HMHUD showErrorWithStatus:[NSString stringWithFormat:@"至多选择%zd个地址", self.maxCount]];
        return;
    }
    NSLog(@"%@",self.selectedAnnotations);

    ! _completeBlock ? : _completeBlock(self.selectedAnnotations, self.myPointAnnotation);
}

// 点击搜索
- (void)searchButtonClick
{
    self.searchBar.hidden = !self.searchBar.hidden;
    if (!self.searchBar.hidden) {
        [self.searchBar becomeFirstResponder];
        if (self.searchResults.count) {
            self.resultsTableView.hidden = NO;
        }
        
    }else{
        [self.searchBar resignFirstResponder];
        self.resultsTableView.hidden = YES;
        self.navigationItem.titleView = nil;
    }
}

// 点击覆盖层
- (void)dismissCoverView
{
    self.coverView.hidden = YES;
}

// 加载更多
- (void)loadOldMore
{
    [self searchWithText:self.searchBar.text];
}
#pragma mark - Private
// 反编码某个位置
- (void)reverseGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeocodeSearchOption.reverseGeoPoint = coordinate;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag){
        NSLog(@"反geo检索发送成功");
    }else{
        NSLog(@"反geo检索发送失败");
    }
}

- (void)searchWithText:(NSString *)text
{
    if (text.length == 0) return;
    
    //城市内检索，请求发送成功返回YES，请求发送失败返回NO
    BMKNearbySearchOption *searchOption = [[BMKNearbySearchOption alloc] init];
    searchOption.radius = kMapViewSearchRadius; // 检索范围 m
    searchOption.location = self.mapView.centerCoordinate;
    searchOption.pageIndex = _currentSearchPage;
    searchOption.pageCapacity = kMapViewSearchPageCount;
    searchOption.keyword = text;
    
    BOOL flag = [_poisearch poiSearchNearBy:searchOption];
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }else{
        NSLog(@"城市内检索发送失败");
    }
}

- (void)setPaopaoViewButtonTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle
{
    _paopaoViewButtonTitle = title;
    _paopaoViewButtonSelTitle = selectedTitle;
}

#pragma mark -
#pragma mark - setter/getter

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

- (void)setSingleChoice:(BOOL)singleChoice
{
    _singleChoice = singleChoice;
    if (singleChoice) {
        _maxCount = 1;
    }
}

- (BMKMapView *)mapView
{
    if (_mapView == nil) {
        BMKMapView *mapView = [[BMKMapView alloc] init];
        mapView.delegate = self;
        // 设置定位的状态
        mapView.userTrackingMode = BMKUserTrackingModeFollow;
        mapView.showsUserLocation = NO;
        _mapView = mapView;
    }
    return _mapView;
}

- (UIButton *)myPointButton
{
    if (_myPointButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"icon_button_myPoint"] forState:UIControlStateNormal];
        CGFloat margin = 20.0;
        CGFloat buttonWH = 35.0;
        btn.frame = CGRectMake(margin, self.mapView.height - (buttonWH + margin * 2) - kFormfootViewHeight, buttonWH, buttonWH);
        [btn addTarget:self action:@selector(myPointClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _myPointButton = btn;
    }
    return _myPointButton;
}

- (HMFormFootView *)footView
{
    if (_footView == nil) {
        HMFormFootView *footView = [[HMFormFootView alloc] init];
        [footView.submitButton setTitle:@"确定" forState:UIControlStateNormal];
        [footView.submitButton addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        footView.frame = CGRectMake(0, self.view.height - kFormfootViewHeight, self.view.width, kFormfootViewHeight);
        [self.view addSubview:footView];
        _footView = footView;
    }
    return _footView;
}
- (NSMutableArray *)selectedAnnotations
{
    if (_selectedAnnotations == nil) {
        _selectedAnnotations = [NSMutableArray array];
    }
    return _selectedAnnotations;
}

- (UIView *)coverView
{
    if (_coverView == nil) {
        UIView *view = [[UIView alloc] init];
        view.hidden = YES;
        view.backgroundColor = [UIColor blackColor];
        view.layer.opacity = 0.5;
        view.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissCoverView)];
        [view addGestureRecognizer:tap];
        _coverView = view;
    }
    return _coverView;
}

- (HMSegmentedView *)segmentedView
{
    if (_segmentedView == nil) {
        // 自定义tabbarBar
        HMSegmentedView *segmentedView = [[HMSegmentedView alloc] initWithItems:@[@"所有场地",@"我的场地"]];
        segmentedView.hidden = YES;
        segmentedView.delegate = self;
        segmentedView.edgeInsets = UIEdgeInsetsMake(5, 20, 5, 20);
        CGFloat segmentedViewContentViewH = kMapViewSegmentedViewH - segmentedView.edgeInsets.top - segmentedView.edgeInsets.bottom;
        segmentedView.contentView.layer.cornerRadius = segmentedViewContentViewH * 0.5;
        segmentedView.contentView.layer.masksToBounds = YES;
        segmentedView.frame = CGRectMake(0, kNavBarHeight, self.view.width, kMapViewSegmentedViewH);
        [self.view addSubview:segmentedView];
        _segmentedView = segmentedView;
    }
    return _segmentedView;
}

- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        UISearchBar *searchBar = [[UISearchBar alloc] init];
        searchBar.hidden = YES;
        searchBar.delegate = self;
        searchBar.placeholder = @"请输入场馆名称或具体地址";
        searchBar.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 44);

        searchBar.tintColor = HMBackgroundColor;
        [searchBar setSearchFieldBackgroundImage:kSearchBarBgImage forState:UIControlStateNormal];
        if (!SYSTEM_VERSION_LESS_THAN(@"8.0")){ // 系统大于等于iOS8.0
            _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        }else{ // 系统小于iOS8.0
            
        }

        self.navigationItem.titleView = searchBar;
        _searchBar = searchBar;
    }
    return _searchBar;
}

- (NSMutableArray *)searchResults
{
    if (_searchResults == nil) {
        _searchResults = [NSMutableArray array];
    }
    return _searchResults;
}

- (UITableView *)resultsTableView
{
    if (_resultsTableView == nil) {
        CGRect frame = CGRectMake(0, kNavBarHeight, self.view.width, self.view.height - kNavBarHeight);
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 49.0;
        tableView.backgroundColor = HMBackgroundColor;
        tableView.tableFooterView = [[UIView alloc] init];
        //上拉刷新
        tableView.footer = [HMRefreshFooter footerWithTarget:self refreshingAction:@selector(loadOldMore)];
        tableView.hidden = YES;
        [self.view addSubview:tableView];
        _resultsTableView = tableView;
    }
    return _resultsTableView;
}

- (NSMutableArray<HMPointAnnotation *> *)annotations
{
    if (_annotations == nil) {
        _annotations = [NSMutableArray array];
    }
    return _annotations;
}

- (HMPointAnnotation *)myPointAnnotation
{
    if (_myPointAnnotation == nil) {
        _myPointAnnotation = [[HMPointAnnotation alloc] init];
    }
    return _myPointAnnotation;
}
@end
