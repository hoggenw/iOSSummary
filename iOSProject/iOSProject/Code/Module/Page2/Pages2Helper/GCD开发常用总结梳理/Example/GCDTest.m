//
//  GCDTest.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/21.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "GCDTest.h"

@implementation GCDTest


// 使用dispatch_once构建单例，可以保证单例线程安全
+ (instancetype)shareInstance {
    static GCDTest *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[GCDTest alloc] init];
    });
    return handler;
}


#pragma mark - 信号量测试

- (void)semaphore {
    
    /**
     *创建信号量，参数：信号量的初值，如果小于0则会返回NULL
    dispatch_semaphore_create（信号量值）
    
    //等待降低信号量
    dispatch_semaphore_wait（信号量，等待时间）
    
    //提高信号量
    dispatch_semaphore_signal(信号量)
     
     */
    
    NSLog(@"=================semaphore信号量测试======================");
#pragma mark -semaphore测试内容一：模拟多线程操作时几个任务同时进行，完成后才输出结果
    dispatch_semaphore_t semaphoreControl = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"hoggen run task 1");
        sleep(1);
        NSLog(@"hoggen complete task 1");
        dispatch_semaphore_signal(semaphoreControl);
    });
    
    
    dispatch_async(queue, ^{
        NSLog(@"hoggen run task 2");
        sleep(2);
        NSLog(@"hoggen complete task 2");
        dispatch_semaphore_signal(semaphoreControl);
    });
    
    
    dispatch_async(queue, ^{
        NSLog(@"hoggen run task 3");
        sleep(3);
        NSLog(@"hoggen complete task 3");
        dispatch_semaphore_signal(semaphoreControl);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"hoggen run task 4");
        sleep(4);
        NSLog(@"hoggen complete task 4");
        dispatch_semaphore_signal(semaphoreControl);
    });
    
    dispatch_async(queue, ^{
        for(int i = 0; i < 4; i++){
            dispatch_semaphore_wait(semaphoreControl, DISPATCH_TIME_FOREVER);
        }
        NSLog(@"=================模拟多线程操作时几个任务同时进行，完成后才输出结果======================");
    });
    
    
    
#pragma mark -semaphore测试内容一：模拟多线程控制
    //crate的value表示，最多几个资源可访问
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    dispatch_queue_t queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //任务1
    dispatch_async(queue2, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 1");
        sleep(1);
        NSLog(@"complete task 1");
        dispatch_semaphore_signal(semaphore);
    });
    //任务2
    dispatch_async(queue2, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 2");
        sleep(1);
        NSLog(@"complete task 2");
        dispatch_semaphore_signal(semaphore);
    });
    //任务3
    dispatch_async(queue2, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 3");
        sleep(1);
        NSLog(@"complete task 3");
        dispatch_semaphore_signal(semaphore);
    });
    
}


-(void)deadThread {
    NSLog(@"=================4");
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"=================5");
    });
    NSLog(@"=================6");
}

-(void)deadThread2 {
    dispatch_queue_t queue = dispatch_queue_create("com.demo.serialQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1"); // 任务1
    dispatch_async(queue, ^{
        NSLog(@"2"); // 任务2
        dispatch_sync(queue, ^{
            NSLog(@"3"); // 任务3
        });
        NSLog(@"4"); // 任务4
    });
    NSLog(@"5"); // 任务5
    /**
     执行任务1；
     遇到异步线程，将【任务2、同步线程、任务4】加入串行队列中。因为是异步线程，所以在主线程中的任务5不必等待异步线程中的所有任务完成；
     因为任务5不必等待，所以2和5的输出顺序不能确定；
     任务2执行完以后，遇到同步线程，这时，将任务3加入串行队列；
     又因为任务4比任务3早加入串行队列，所以，任务3要等待任务4完成以后，才能执行。但是任务3所在的同步线程会阻塞，所以任务4必须等任务3执行完以后再执行。这就又陷入了无限的等待中，造成死锁。
     */
}

-(void)barrier {
    
    //GCD的快速迭代方法
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    /*! dispatch_apply函数说明
     *
     *  @brief  dispatch_apply函数是dispatch_sync函数和Dispatch Group的关联API
     *         该函数按指定的次数将指定的Block追加到指定的Dispatch Queue中,并等到全部的处理执行结束
     *
     *  @param 6    指定重复次数  指定6次
     *  @param queue 追加对象的Dispatch Queue
     *  @param index 带有参数的Block, index的作用是为了按执行的顺序区分各个Block
     *
     */
    
    dispatch_apply(6, globalQueue, ^(size_t index) {
        if (index == 3) {
            
            NSString *url = [NSString stringWithFormat:@"%@/api/welcome/ad",BaseUrl];
            
            [[AFHTTPSessionManager manager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 NSLog(@"执行耗时操作3------%@",[NSThread currentThread]);
                 NSLog(@"执行耗时操作3");
                 
                 NSLog(@" ------------l--------------成功 =  ");
                  NSLog(@"%zd---globalQueue---%@",index, [NSThread currentThread]);
                 
             }
                                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
             {
                 NSLog(@" ------------l--------------失败 = %@ ",error);
                 NSLog(@"执行耗时操作3------%@",[NSThread currentThread]);
                 NSLog(@"执行耗时操作3");
                  NSLog(@"%zd---globalQueue---%@",index, [NSThread currentThread]);
             }];
        }else{
           NSLog(@"%zd---globalQueue---%@",index, [NSThread currentThread]);
        }
       
    });
    
    //对于内部再次异步的的内容（如网络请求），dispatch_apply并不能保证执行数据
    NSLog(@"============================dispatch_apply  over =======================");
    
    dispatch_queue_t queue = dispatch_queue_create("ssss", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"内部在异步1");
            NSLog(@"内部在异步1------%@",[NSThread currentThread]);
            
        });
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"内部在异步2");
            NSLog(@"内部在异步2------%@",[NSThread currentThread]);
            
        });
        dispatch_async(queue, ^{
            for (int i = 0; i < 2; ++i) {
                NSLog(@"内部queue------%@",[NSThread currentThread]);
            }
        });
    });
    
    //延时执行，不受栅栏的影响
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"run ----延时执行，不受栅栏的影响");
    });
    //先执行完栅栏前面的在执行后面的
    dispatch_barrier_sync(queue, ^{
        NSLog(@"----barrier  over-----%@", [NSThread currentThread]);
    });
    
    /**
     1.栅栏操作时候，只能拦截该线程中第一层异步操作的内容，对第一层中再次异步操作的线程无法拦截，同时属于这个线程的也不行
     */
    
    
    
    //    dispatch_async(queue, ^{
    //        for (int i = 0; i < 2; ++i) {
    //            NSLog(@"3------%@",[NSThread currentThread]);
    //        }
    //    });
    //    dispatch_async(queue, ^{
    //        for (int i = 0; i < 2; ++i) {
    //            NSLog(@"4------%@",[NSThread currentThread]);
    //        }
    //    });
//
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSLog(@"only once");
//    });
    
}

-(void)testGroub {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //执行耗时操作1
        NSLog(@"执行耗时操作1");
        NSLog(@"执行耗时操作1------%@",[NSThread currentThread]);
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (long i = 0 ; i < 700000; i ++) {
                long j = i;
            }
            NSLog(@"内部在异步1");
            NSLog(@"内部在异步1------%@",[NSThread currentThread]);
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"内部在异步3");
            NSLog(@"内部在异步3------%@",[NSThread currentThread]);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                sleep(1); //h会让线程提前进入到   dispatch_group_notify
              
                
                NSString *url = [NSString stringWithFormat:@"%@/api/welcome/ad",BaseUrl];
                
                [[AFHTTPSessionManager manager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                 {
                     NSLog(@"内部在异步2");
                     NSLog(@"内部在异步2------%@",[NSThread currentThread]);
                     NSLog(@" ------------l--------------成功 =  ");
                     
                     
                 }
                                            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                 {
                     NSLog(@" ------------l--------------失败 = %@ ",error);
                     NSLog(@"内部在异步2");
                     NSLog(@"内部在异步2------%@",[NSThread currentThread]);
                 }];
                
                
            });
        });
        
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //执行耗时操作2
        NSLog(@"执行耗时操作2------%@",[NSThread currentThread]);
        NSLog(@"执行耗时操作2");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //执行耗时操作3
        NSLog(@"执行耗时操作3------%@",[NSThread currentThread]);
        NSLog(@"执行耗时操作3");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //                sleep(1); //h会让线程提前进入到   dispatch_group_notify
        
        
        NSString *url = [NSString stringWithFormat:@"%@/api/welcome/ad",BaseUrl];
        
        [[AFHTTPSessionManager manager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"执行耗时操作4------%@",[NSThread currentThread]);
             NSLog(@"执行耗时操作4");
             
             NSLog(@" ------------l--------------成功 =  ");
             
             
         }
                                    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@" ------------l--------------失败 = %@ ",error);
             NSLog(@"执行耗时操作4------%@",[NSThread currentThread]);
             NSLog(@"执行耗时操作4");
             
         }];
        
        
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"前面的异步操作已完成");
    });
    
    //dispatch_group_create()可以创建一个完全的线程控制，这这个group中的线程，无论该线程是否新开异步线程，
    //dispatch_group_notify都会在该group线程所有内容执行完成以后,再执行相关内容
    //所谓异步执行就是将当前在异步执行的代码以函数块形式排队放到线程(系统分配的线程，不一定是目前执行的线程)执行的最后
    //由于执行的线程不一致，所以完成先后顺序也不一致
    //对于内部再次异步的的内容（如网络请求），group并不能保证获取结果以后再执行通知
}


-(void)testMain{
    dispatch_queue_t queue = dispatch_get_main_queue();
    NSLog(@"asyncMain---begin");
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_block_t block = ^{
        NSLog(@"block------%@",[NSThread currentThread]);
        NSLog(@"new block message");
    };
    
    dispatch_async(queue, block);
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"asyncMain---end");
    //在指定线程中执行的异步操作，遵循代码执行顺序，碰到异步的函数块，即抛到线程最后排队；
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async( dispatch_get_main_queue(), ^{
            NSLog(@"0.0---main---%@",[NSThread currentThread]);
        });
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1.1------%@",[NSThread currentThread]);
        }
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            for (int i = 0; i < 2; ++i) {
                NSLog(@"2.2---main---%@",[NSThread currentThread]);
            }
        });
    });
}

-(void)creatQueue {
    
    //并发队列的创建方法
    NSLog(@"==================并发队列的创建方法=====================");
    dispatch_queue_t queueC = dispatch_queue_create("conTest.queue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"asyncConcurrent---begin");
     NSLog(@"==================同步执行任务创建方法=====================");
    //同步执行任务创建方法
    dispatch_sync(queueC, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1---并发队列sync---%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queueC, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2---并发队列sync---%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queueC, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3---并发队列sync---%@",[NSThread currentThread]);
        }
    });
    
    //异步执行任务创建方法
     NSLog(@"==================异步执行任务创建方法=====================");
    dispatch_async(queueC, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1---并发队列---%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queueC, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2---并发队列---%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queueC, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3---并发队列---%@",[NSThread currentThread]);
        }
    });
    NSLog(@"syncConcurrent---end");
    
    //并发同步队列在一个线程中执行，并发异步队列则由系统分配的线程执行，执行速度不一定比当前线程的速度慢
    
    
      NSLog(@"==================串行队列的创建方法=====================");
    //串行队列的创建方法
    dispatch_queue_t queueSerial = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
    //同步执行任务创建方法
      NSLog(@"==================同步执行任务创建方法=====================");
    dispatch_sync(queueSerial, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1---串行队列sync---%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queueSerial, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2---串行队列sync---%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queueSerial, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3---串行队列sync---%@",[NSThread currentThread]);
        }
    });
    NSLog(@"==================异步执行任务创建方法=====================");
    
    dispatch_async(queueSerial, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1---串行队列async---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queueSerial, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2---串行队列async---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queueSerial, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3---串行队列async---%@",[NSThread currentThread]);
        }
    });
    
    
    
}

@end
