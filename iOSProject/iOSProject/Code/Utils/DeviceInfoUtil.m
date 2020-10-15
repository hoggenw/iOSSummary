//
//  DeviceInfoUtil.m
//  iOSProject
//
//  Created by hoggen on 2020/4/24.
//  Copyright © 2020 hoggenWang.com. All rights reserved.
//

#import "DeviceInfoUtil.h"
//获取手机型号需要导入
#import "sys/utsname.h"

//获取运行商需要导入
#import <CoreTelephony/CTCarrier.h>

#import <CoreTelephony/CTTelephonyNetworkInfo.h>


#include <mach/message.h>
#include <mach/machine.h>
#include <mach/machine/processor_info.h>

@implementation DeviceInfoUtil

// 获取设备型号然后手动转化为对应名称

+ (NSString *)getDeviceName{

    // 需要#import "sys/utsname.h"

    #warning 题主呕心沥血总结！！最全面！亲测！全网独此一份！！

    struct utsname systemInfo;

    uname(&systemInfo);

    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    

    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";

    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";

    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";

    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";

    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";

    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";

    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";

    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";

    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";

    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";

    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";

    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";

    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";

    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";

    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";

    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付

    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";

    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";

    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";

    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";

    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"国行(A1863)、日行(A1906)iPhone 8";

    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"美版(Global/A1905)iPhone 8";

    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"国行(A1864)、日行(A1898)iPhone 8 Plus";

    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"美版(Global/A1897)iPhone 8 Plus";

    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"国行(A1865)、日行(A1902)iPhone X";

    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"美版(Global/A1901)iPhone X";

    

    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";

    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";

    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";

    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";

    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";

    

    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";

    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";

    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";

    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";

    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";

    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";

    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";

    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";

    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";

    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";

    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";

    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";

    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";

    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";

    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";

    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";

    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";

    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";

    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";

    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";

    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";

    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";

    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";

    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";

    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";

    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";

    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";

    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";

    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";

    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";

    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";

    if ([deviceString isEqualToString:@"iPad6,11"])    return @"iPad 5 (WiFi)";

    if ([deviceString isEqualToString:@"iPad6,12"])    return @"iPad 5 (Cellular)";

    if ([deviceString isEqualToString:@"iPad7,1"])     return @"iPad Pro 12.9 inch 2nd gen (WiFi)";

    if ([deviceString isEqualToString:@"iPad7,2"])     return @"iPad Pro 12.9 inch 2nd gen (Cellular)";

    if ([deviceString isEqualToString:@"iPad7,3"])     return @"iPad Pro 10.5 inch (WiFi)";

    if ([deviceString isEqualToString:@"iPad7,4"])     return @"iPad Pro 10.5 inch (Cellular)";

    

   if ([deviceString isEqualToString:@"AppleTV2,1"])    return @"Apple TV 2";

   if ([deviceString isEqualToString:@"AppleTV3,1"])    return @"Apple TV 3";

   if ([deviceString isEqualToString:@"AppleTV3,2"])    return @"Apple TV 3";

   if ([deviceString isEqualToString:@"AppleTV5,3"])    return @"Apple TV 4";



    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";

    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";

    

    return deviceString;

}

+ (void)iphoneInfo {
    //设备唯一标识符
    NSString *identifierStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"设备唯一标识符:%@",identifierStr);
    //手机别名： 用户定义的名称
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    NSLog(@"手机别名: %@", userPhoneName);
    //设备名称
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    NSLog(@"设备名称: %@",deviceName );
    //手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"手机系统版本: %@", phoneVersion);
    //手机型号
    NSString * phoneModel =  [DeviceInfoUtil getDeviceName];
    NSLog(@"手机型号:%@",phoneModel);
    //地方型号  （国际化区域名称）
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    NSLog(@"国际化区域名称: %@",localPhoneModel );
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    // 当前应用版本号码   int类型
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSLog(@"当前应用版本号码：%@",appCurVersionNum);
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    NSLog(@"物理尺寸:%.0f × %.0f",width,height);
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    NSLog(@"分辨率是:%.0f × %.0f",width*scale_screen ,height*scale_screen);
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    NSLog(@"运营商:%@", carrier.carrierName);
   // [DeviceInfoUtil getCPUCount];
    // 这个方法后面会列出来


    

       CGFloat batteryLevel = [[UIDevice currentDevice] batteryLevel];

       NSLog(@"电池电量-->%f", batteryLevel);

       

       NSString *localizedModel = [UIDevice currentDevice].localizedModel;

       NSLog(@"localizedModel-->%@", localizedModel);

       

       NSString *systemName = [UIDevice currentDevice].systemName;

       NSLog(@"当前系统名称-->%@", systemName);

       

       NSString *systemVersion = [UIDevice currentDevice].systemVersion;

       NSLog(@"当前系统版本号-->%@", systemVersion);



       struct utsname systemInfo;

       uname(&systemInfo);

       NSString *device_model = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

       NSLog(@"device_model-->%@", device_model);



//       // 这个方法后面会单独列出
//
//       NSString *macAddress = [self getMacAddress];
//
//       NSLog(@"macAddress-->%@", macAddress);
//
//
//
//       // 这个方法后面会单独列出
//
//       NSString *deviceIP = [self getDeviceIPAddresses];
//
//       NSLog(@"deviceIP-->%@", deviceIP);



      // 设备上次重启的时间

      NSTimeInterval time = [[NSProcessInfo processInfo] systemUptime];

      NSDate *lastRestartDate = [[NSDate alloc] initWithTimeIntervalSinceNow:(0 - time)];
    
       [DeviceInfoUtil getUsedDiskSpace];
    [DeviceInfoUtil getTotalMemory];
}


// 系统总内存空间

+ (int64_t)getTotalMemory {

    int64_t totalMemory = [[NSProcessInfo processInfo] physicalMemory];

    if (totalMemory < -1) totalMemory = -1;
    NSLog(@"系统总内存空间-->%@M", @(totalMemory/(1024*1024)));
    return totalMemory;

}


// 获取磁盘总空间

+ (int64_t)getTotalDiskSpace {

    NSError *error = nil;

    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];

    if (error) return -1;

    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];

    if (space < 0) space = -1;
    NSLog(@"获取磁盘总空间-->%@M", @(space/(1024*1024)));
    return space;

}

// 获取未使用的磁盘空间

+ (int64_t)getFreeDiskSpace {

    NSError *error = nil;

    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];

    if (error) return -1;

    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];

    if (space < 0) space = -1;
 NSLog(@"获取未使用的磁盘空间-->%@M", @(space/(1024*1024)));
    return space;

}

// 获取已使用的磁盘空间

+ (int64_t)getUsedDiskSpace {

    int64_t totalDisk = [DeviceInfoUtil getTotalDiskSpace];

    int64_t freeDisk = [DeviceInfoUtil getFreeDiskSpace];

    if (totalDisk < 0 || freeDisk < 0) return -1;

    int64_t usedDisk = totalDisk - freeDisk;

    if (usedDisk < 0) usedDisk = -1;
 NSLog(@"获取已使用的磁盘空间-->%@M", @(usedDisk/(1024*1024)));
    return usedDisk;

}



// CPU总数目

//+ (NSUInteger)getCPUCount {
//    NSLog(@"CPU总数目-->%@", [NSProcessInfo processInfo].activeProcessorCount);
//    return [NSProcessInfo processInfo].activeProcessorCount;
//
//}

//// 已使用的CPU比例
//
//+ (float)getCPUUsage {
//
//    float cpu = 0;
//
//    NSArray *cpus = [DeviceInfoUtil getPerCPUUsage];
//
//    if (cpus.count == 0) return -1;
//
//    for (NSNumber *n in cpus) {
//
//        cpu += n.floatValue;
//
//    }
//
//    return cpu;
//
//}
//
//// 获取每个cpu的使用比例
//
//+ (NSArray *)getPerCPUUsage {
//
//    processor_info_array_t _cpuInfo, _prevCPUInfo = nil;
//
//    mach_msg_type_number_t _numCPUInfo, _numPrevCPUInfo = 0;
//
//    unsigned _numCPUs;
//
//    NSLock *_cpuUsageLock;
//
//
//
//    int _mib[2U] = { CTL_HW, HW_NCPU };
//
//    size_t _sizeOfNumCPUs = sizeof(_numCPUs);
//
//    int _status = sysctl(_mib, 2U, &_numCPUs, &_sizeOfNumCPUs, NULL, 0U);
//
//    if (_status)
//
//        _numCPUs = 1;
//
//
//
//    _cpuUsageLock = [[NSLock alloc] init];
//
//
//
//    natural_t _numCPUsU = 0U;
//
//    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &_numCPUsU, &_cpuInfo, &_numCPUInfo);
//
//    if (err == KERN_SUCCESS) {
//
//        [_cpuUsageLock lock];
//
//
//
//        NSMutableArray *cpus = [NSMutableArray new];
//
//        for (unsigned i = 0U; i < _numCPUs; ++i) {
//
//            Float32 _inUse, _total;
//
//            if (_prevCPUInfo) {
//
//                _inUse = (
//
//                          (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
//
//                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
//
//                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
//
//                          );
//
//                _total = _inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
//
//            } else {
//
//                _inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
//
//                _total = _inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
//
//            }
//
//            [cpus addObject:@(_inUse / _total)];
//
//        }
//
//
//
//        [_cpuUsageLock unlock];
//
//        if (_prevCPUInfo) {
//
//            size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCPUInfo;
//
//            vm_deallocate(mach_task_self(), (vm_address_t)_prevCPUInfo, prevCpuInfoSize);
//
//        }
//
//        return cpus;
//
//    } else {
//
//        return nil;
//
//    }
//
//}

@end
