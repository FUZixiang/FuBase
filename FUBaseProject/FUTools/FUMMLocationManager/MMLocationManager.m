
#import "MMLocationManager.h"

@interface MMLocationManager ()

@property (nonatomic, strong) LocationBlock locationBlock;
@property (nonatomic, strong) NSStringBlock cityBlock;
@property (nonatomic, strong) NSStringBlock addressBlock;
@property (nonatomic, strong) LocationErrorBlock errorBlock;

@end

@implementation MMLocationManager

+ (MMLocationManager *)shareLocation;
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (self) {
        NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
        
        float longitude = [standard floatForKey:MMLastLongitude];
        float latitude = [standard floatForKey:MMLastLatitude];
        self.longitude = longitude;
        self.latitude = latitude;
        self.lastCoordinate = CLLocationCoordinate2DMake(longitude,latitude);
        self.lastCity = [standard objectForKey:MMLastCity];
        self.lastAddress=[standard objectForKey:MMLastAddress];
    }
    return self;
}

- (void) getLocationCoordinate:(LocationBlock) locaiontBlock
{
    self.locationBlock = [locaiontBlock copy];
    [self startLocation];
}

- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock) addressBlock
{
    self.locationBlock = [locaiontBlock copy];
    self.addressBlock = [addressBlock copy];
    [self startLocation];
}

- (void) getAddress:(NSStringBlock)addressBlock
{
    self.addressBlock = [addressBlock copy];
    [self startLocation];
}

- (void) getCity:(NSStringBlock)cityBlock
{
    self.cityBlock = [cityBlock copy];
    [self startLocation];
}

- (void) getCity:(NSStringBlock)cityBlock error:(LocationErrorBlock) errorBlock
{
    self.cityBlock = [cityBlock copy];
    self.errorBlock = [errorBlock copy];
    [self startLocation];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocation * newLocation = userLocation.location;
    self.lastCoordinate=mapView.userLocation.location.coordinate;
    
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    
    [standard setObject:@(self.lastCoordinate.longitude) forKey:MMLastLongitude];
    [standard setObject:@(self.lastCoordinate.latitude) forKey:MMLastLatitude];
    
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    CLGeocodeCompletionHandler handle = ^(NSArray *placemarks,NSError *error)
    {
        for (CLPlacemark * placeMark in placemarks)
        {
            NSDictionary *addressDic=placeMark.addressDictionary;
            
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            
            self.lastCity = city;
            self.lastAddress=[NSString stringWithFormat:@"%@%@%@%@",state,city,subLocality,street];
            
            [standard setObject:self.lastCity forKey:MMLastCity];
            [standard setObject:self.lastAddress forKey:MMLastAddress];
            
            [self stopLocation];
        }
        
        if (_cityBlock) {
            _cityBlock(_lastCity);
            _cityBlock = nil;
        }
        
        if (_locationBlock) {
            _locationBlock(_lastCoordinate);
            _locationBlock = nil;
        }
        
        if (_addressBlock) {
            _addressBlock(_lastAddress);
            _addressBlock = nil;
        }
    };
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [clGeoCoder reverseGeocodeLocation:newLocation completionHandler:handle];
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
//    NSLog(@"定位 %f %f",manager.location.coordinate.longitude,manager.location.coordinate.latitude);
    switch (status) {
            
        case kCLAuthorizationStatusDenied :
            
        {
            // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
            
            UIAlertView *tempA = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"请在设置-隐私-定位服务中开启定位功能！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [tempA show];
            
        }
            
            break;
            
        case kCLAuthorizationStatusNotDetermined :
            
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
                
            {
                
                //NSLog(@"调用");
                
                [_locationManager requestAlwaysAuthorization];
                
            }
            
            break;
            
        case kCLAuthorizationStatusRestricted:
            
        {
            
            // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
            
            UIAlertView *tempA = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"定位服务无法使用！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [tempA show];
            
            
            
        }
            
        default:
            
            
            
            break;
            
    }
    
}

-(void)startLocation
{
    if (_mapView) {
        _mapView = nil;
    }
    
    _mapView = [[MKMapView alloc] init];
    _mapView.mapType = MKMapTypeStandard ;
    _mapView.userTrackingMode=MKUserTrackingModeFollow;
    _mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    // 判斷是否 iOS 8
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization]; // 永久授权
        [self.locationManager requestWhenInUseAuthorization]; //使用中授权
    }
    self.locationManager.delegate = self;
    
    
    [self.locationManager startUpdatingLocation];
    _mapView.showsUserLocation = YES;
}
-(MKMapView *)startLocationReturnV
{
    if (_mapView) {
        _mapView = nil;
    }
    
    _mapView = [[MKMapView alloc] init];
    _mapView.mapType = MKMapTypeStandard ;
    _mapView.userTrackingMode=MKUserTrackingModeFollow;
    _mapView.delegate = self;
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    // 判斷是否 iOS 8
    if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [locationManager requestAlwaysAuthorization]; // 永久授权
        [locationManager requestWhenInUseAuthorization]; //使用中授权
    }
    ////    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    _mapView.showsUserLocation = YES;
    return _mapView;
}

-(void)stopLocation
{
    _mapView.showsUserLocation = NO;
    _mapView = nil;
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    [self stopLocation];
}

@end
