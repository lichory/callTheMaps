//
//  ViewController.m
//  调用其他的app的地图
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 李重阳. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}




- (IBAction)app_mapClick:(id)sender {
    
    CLLocationCoordinate2D coords1 = CLLocationCoordinate2DMake(39.915,116.404);
    
    CLLocationCoordinate2D coords2 = CLLocationCoordinate2DMake(40.001,116.404);
    
    //起点
    
    MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords1 addressDictionary:nil]];
    
    //目的地的位置
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords2 addressDictionary:nil]];
    toLocation.name = @"目的地";
    
    NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
    
    NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES }; //打开苹果自身地图应用，并呈现特定的item
    
    [MKMapItem openMapsWithItems:items launchOptions:options];
    
}


/*
 
 　  1.苹果自带地图(不需要检测，所以不需要URL Scheme)
 　　2.百度地图 ：baidumap://
 　　3.高德地图 ：iosamap://
 
 
     在 iOS 9 之后我们做跳转是需要有个白名单的，就像我们做分享的时候也是一样。
 　　添加白名单：
 　　在 info.plist 文件里面，添加一个字段：LSApplicationQueriesSchemes，类型为数组，然后在这个数组里面再添加我们所需要的地图 URL Scheme :baidumap, iosamap
 **/

- (IBAction)baidu_mapClick:(id)sender {
    
    if ([self canOpenBaiduMap]) {
        
        CLLocationCoordinate2D coords1 = CLLocationCoordinate2DMake(39.915,116.404);
        
        CLLocationCoordinate2D coords2 = CLLocationCoordinate2DMake(40.001,116.404);
        
        //NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:起点&destination=latlng:%f,%f|name:终点&mode=driving",coords1.latitude, coords1.longitude,coords2.latitude, coords2.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        /* 如果设置了 我的位置 会直接忽略 设置的 经纬度 会以 当前的我的位置来 进行计算 **/

        
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:终点&mode=driving",coords1.latitude, coords1.longitude,coords2.latitude, coords2.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        //        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/
        //
        //                                direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&
        //
        //                                mode=driving&coord_type=gcj02",coordinate.latitude, coordinate.long
        //
        //                                itude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
        
    }
    
    
}

/* 打开百度地图 **/
- (BOOL)canOpenBaiduMap {
    
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]];
}

- (IBAction)gaode_MapClick:(id)sender {
    
    if ([self canOpenGaoDeMap]) {
        
        CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(39.915,116.404);
        
        CLLocationCoordinate2D coor2 = CLLocationCoordinate2DMake(40.001,116.404);
        
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%lf&slon=%lf&sname=我的位置&did=BGVIS2&dlat=%lf&dlon=%lf&dname=%@&dev=0&m=0&t=%@",coor.latitude,coor.longitude, coor2.latitude,coor2.longitude,@"目的地",@(0)] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        //NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%lf&slon=%lf&sname=我的位置_123123123&did=BGVIS2&dlat=%lf&dlon=%lf&dname=%@&dev=0&m=0&t=%@",coor.latitude,coor.longitude, coor2.latitude,coor2.longitude,@"目的地",@(0)] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
         [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
    }
    
}


/* 打开百度地图 **/
- (BOOL)canOpenGaoDeMap {
    
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]];
}

@end
