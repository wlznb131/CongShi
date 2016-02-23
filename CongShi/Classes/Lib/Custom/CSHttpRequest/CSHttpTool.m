//
//  CSHttpTool.m
//  CongShi
//
//  Created by Archy on 16/1/25.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSHttpTool.h"
#import "NSDictionary+CSExtension.h"
#import "CSDataCacheTool.h"

@implementation CSHttpTool

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];//使用这个将得到的是NSData
    
    NSString *fileName = url;
    
    url = [NSString stringWithFormat:@"%@%@", MAIN_URL, url];
    // 2.发送GET请求
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObj) {
         
         if (success) {
             NSDictionary *result = [NSDictionary resultWithResponseObj:responseObj];
             
             [CSDataCacheTool saveDictionary:result fileName:fileName];
             
             success(result);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSDictionary *result = [CSDataCacheTool dictionaryWithFileName:fileName];
         
         if (result) {
             
             if (success) {
                 success(result);
             }
         }else if (failure) {
             
             failure(error);
         }
     }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(id))failure end:(void (^)(id))end {
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSData *paramsData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *paramsJson = [[NSString alloc] initWithData:paramsData encoding:NSUTF8StringEncoding];
    
    NSString *fileName = [url stringByAppendingString:paramsJson];
    
    url = [NSString stringWithFormat:@"%@%@", MAIN_URL, url];
    // 2.发送POST请求
    [mgr POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          NSArray *result = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingAllowFragments error:nil];
          NSLog(@"%@",result);
          if (result[0][@"data"]) {
              [CSDataCacheTool saveDictionary:result[0][@"data"] fileName:fileName];
          }
          if (([result[0][@"status"] integerValue] == 1 ) || ([result[0][@"status"] integerValue] == 6000 )) {
              if (success) {
                  success(result[0][@"status"]);
              }
          } else {
              if (failure) {
                  failure(result[0][@"status"]);
              }
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (end) {
              end(error);
          }
      }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(id))failure {
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *fileName = nil;
    
    if (params) {
        
        NSData *paramsData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        
        NSString *paramsJson = [[NSString alloc] initWithData:paramsData encoding:NSUTF8StringEncoding];

        fileName = [url stringByAppendingString:paramsJson];

    }
    
    
    url = [NSString stringWithFormat:@"%@%@", MAIN_URL, url];
    // 2.发送POST请求
    [mgr POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          
          NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingAllowFragments error:nil];
          
          NSLog(@"%@",result);

          if (result[@"data"]) {
              [CSDataCacheTool saveDictionary:result[@"data"] fileName:fileName];
          } else if (result[@"list"]){
              [CSDataCacheTool saveDictionary:result[@"list"] fileName:fileName];
          }
          if (([result[@"status"] integerValue] == 1 ) || ([result[@"status"] integerValue] == 6000 )) {
              if (success) {
                  if(result[@"data"]){
                  success(result[@"data"]);
                  } else if (result[@"list"]){
                      success(result[@"list"]);
                  }else{
                      success(result[@"status"]);
                  }
              }
          } else {
              if (failure) {
                  failure(result[@"status"]);
              }
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
      }];
}

+ (void)noCacheGet:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];//使用这个将得到的是NSData
    // 2.发送GET请求
    url = [NSString stringWithFormat:@"%@%@", MAIN_URL, url];
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObj) {
         if (success) {
             NSDictionary *result = [NSDictionary resultWithResponseObj:responseObj];
             success(result);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}
+ (void)noCachePost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(id error))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr.operationQueue cancelAllOperations];
    
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 2.发送POST请求
    
    url = [NSString stringWithFormat:@"%@%@", MAIN_URL, url];
    [mgr POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingAllowFragments error:nil];
          if (([result[@"status"] integerValue] == 1 ) || ([result[@"status"] integerValue] == 6000 )) {
              if (success) {
                  success(result[@"status"]);
              }
          } else {
              if (failure) {
                  failure(result[@"status"]);
              }
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
      }];
}


@end
