//
//  GCDC.swift
//  XBMultithreadingDemo
//
//  Created by xiaobin liu on 2018/12/28.
//  Copyright © 2018 Sky. All rights reserved.
//  Reference: https://github.com/bujige/YSC-GCD-demo, https://www.jianshu.com/p/2d57c72016c6

import UIKit


/// MARK - GCD演示控制器
final class GCDC: UIViewController {

    /// 并发队列
    private lazy var concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: DispatchQueue.Attributes.concurrent)
    
    /// 串行队列
    private lazy var serialQueue = DispatchQueue(label: "serialQueue")
    
    /// 剩余火车票数
    private var ticketSurplusCount = 0
    /// 信号锁
    private lazy var semaphoreLock = DispatchSemaphore(value: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "GCD演示"
        self.view.backgroundColor = UIColor.white
        
        //self.syncConcurrent()
        //self.asyncConcurrent()
        //self.syncSerial()
        //self.asyncSerial()
        //self.syncMain()
        //self.asyncMain()
        //self.communication()
        //self.barrier()
        //self.after()
        //self.apply()
        //self.groupNotify()
        //self.groupWait()
        //self.groupEnterAndLeave()
        //self.semaphoreSync()
        //self.initTicketStatusNotSave()
        //self.initTicketStatusSave()
        //self.mainThread()
        self.mainQueue()
    }

    
    /**
     * 同步执行 + 并发队列
     * 特点：在当前线程中执行任务，不会开启新线程，执行完一个任务，再执行下一个任务。
     */
    private func syncConcurrent() {
        
        // 打印当前线程
        debugPrint("currentThread---\(Thread.current)")
        debugPrint("syncConcurrent---begin")
        
        
        concurrentQueue.sync {
            
            // 追加任务1
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1---\(Thread.current)") // 打印当前线程
            }
        }
        
        
        concurrentQueue.sync {
            
            // 追加任务2
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2---\(Thread.current)") // 打印当前线程
            }
        }
        
        
        concurrentQueue.sync {
            
            // 追加任务3
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("3---\(Thread.current)") // 打印当前线程
            }
        }
        
        debugPrint("syncConcurrent---end")
    }
    
    /**
     * 异步执行 + 并发队列
     * 特点：可以开启多个线程，任务交替（同时）执行。
     */
    private func asyncConcurrent() {
        
        // 打印当前线程
        debugPrint("currentThread---\(Thread.current)")
        debugPrint("asyncConcurrent---begin")
        
        
        concurrentQueue.async {
            
            // 追加任务1
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1---\(Thread.current)") // 打印当前线程
            }
        }
        
        
        concurrentQueue.async {
            
            // 追加任务2
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2---\(Thread.current)") // 打印当前线程
            }
        }
        
        
        concurrentQueue.async {
            
            // 追加任务3
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("3---\(Thread.current)") // 打印当前线程
            }
        }
        
        debugPrint("asyncConcurrent---end")
    }
    
    /**
     * 同步执行 + 串行队列
     * 特点：不会开启新线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务。
     */
    private func syncSerial() {
        
        // 打印当前线程
        debugPrint("currentThread---\(Thread.current)")
        debugPrint("syncSerial---begin")

        self.serialQueue.sync {
            
            // 追加任务1
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1---\(Thread.current)") // 打印当前线程
            }
        }
        
        self.serialQueue.sync {
            
            // 追加任务2
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2---\(Thread.current)") // 打印当前线程
            }
        }
        
        self.serialQueue.sync {
            
            // 追加任务3
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("3---\(Thread.current)") // 打印当前线程
            }
        }
        
        debugPrint("syncSerial---end")
    }
    
    /**
     * 异步执行 + 串行队列
     * 特点：会开启新线程，但是因为任务是串行的，执行完一个任务，再执行下一个任务。
     */
    private func asyncSerial() {
        
        // 打印当前线程
        debugPrint("currentThread---\(Thread.current)")
        debugPrint("asyncSerial---begin")
        
        self.serialQueue.async {
            
            // 追加任务1
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1---\(Thread.current)") // 打印当前线程
            }
        }
        
        self.serialQueue.async {
            
            // 追加任务2
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2---\(Thread.current)") // 打印当前线程
            }
        }
        
        self.serialQueue.async {
            
            // 追加任务3
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("3---\(Thread.current)") // 打印当前线程
            }
        }
        
        debugPrint("asyncSerial---end")
    }
    
    /**
     * 同步执行 + 主队列
     * 特点(主线程调用)：互等卡主不执行。
     * 特点(其他线程调用)：不会开启新线程，执行完一个任务，再执行下一个任务。
     */
    private func syncMain() {
        
        // 打印当前线程
        debugPrint("currentThread---\(Thread.current)")
        debugPrint("syncMain---begin")
        
        DispatchQueue.main.sync {
            
            // 追加任务1
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1---\(Thread.current)") // 打印当前线程
            }
        }
        
        
        DispatchQueue.main.sync {
            
            // 追加任务2
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2---\(Thread.current)") // 打印当前线程
            }
        }
        
        DispatchQueue.main.sync {
            
            // 追加任务3
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("3---\(Thread.current)") // 打印当前线程
            }
        }
        
        debugPrint("syncMain---end")
    }
    
    /**
     * 异步执行 + 主队列
     * 特点：只在主线程中执行任务，执行完一个任务，再执行下一个任务
     */
    private func asyncMain() {
        
        // 打印当前线程
        debugPrint("currentThread---\(Thread.current)")
        debugPrint("asyncMain---begin")
        
        DispatchQueue.main.async {
            
            // 追加任务1
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1---\(Thread.current)") // 打印当前线程
            }
        }
        
        
        DispatchQueue.main.async {
            
            // 追加任务2
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2---\(Thread.current)") // 打印当前线程
            }
        }
        
        DispatchQueue.main.async {
            
            // 追加任务3
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("3---\(Thread.current)") // 打印当前线程
            }
        }
        
        debugPrint("asyncMain---end")
    }
    
    /**
     * 线程间通信
     */
    private func communication() {
        
        DispatchQueue.global().async {
            
            // 异步追加任务
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1---\(Thread.current)") // 打印当前线程
            }
            
            // 回到主线程
            DispatchQueue.main.async {
                // 追加在主线程中执行的任务
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2---\(Thread.current)") // 打印当前线程
            }
        }
    }
    
    /**
     * 栅栏方法 barrier
     */
    private func barrier() {
        
        
        concurrentQueue.async {
            
            // 追加任务1
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1---\(Thread.current)") // 打印当前线程
            }
        }
        
        
        concurrentQueue.async {
            
            // 追加任务2
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2---\(Thread.current)") // 打印当前线程
            }
        }
        
        concurrentQueue.async(flags: DispatchWorkItemFlags.barrier) {
            // 追加任务 barrier
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("barrier---\(Thread.current)") // 打印当前线程
            }
        }
        
        
        concurrentQueue.async {
            
            // 追加任务3
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("3---\(Thread.current)") // 打印当前线程
            }
        }
        
        
        concurrentQueue.async {
            
            // 追加任务4
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("4---\(Thread.current)") // 打印当前线程
            }
        }
    }
    
    /**
     * 延时执行方法 after
     */
    private func after() {
        
        // 打印当前线程
        debugPrint("currentThread---\(Thread.current)")
        debugPrint("after---begin")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            // 6.0秒后异步追加任务代码到主队列，并开始执行
            debugPrint("after---\(Thread.current)") // 打印当前线程
        }
    }
    
    /**
     * 快速迭代方法 apply
     */
    private func apply() {
        
        debugPrint("apply---begin")
        DispatchQueue.concurrentPerform(iterations: 6) { (index) in
            debugPrint("\(index)----\(Thread.current)")
        }
        debugPrint("apply---end")
    }
    
    /**
     * 队列组 groupNotify
     */
    private func groupNotify() {
        
        debugPrint("currentThread---\(Thread.current)")  // 打印当前线程
        debugPrint("group---begin")
        
        let group = DispatchGroup()
        
        self.concurrentQueue.async(group: group) {
            // 追加任务1
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1---\(Thread.current)") // 打印当前线程
            }
        }
        
        self.concurrentQueue.async(group: group) {
            // 追加任务2
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2---\(Thread.current)") // 打印当前线程
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            // 等前面的异步任务1、任务2都执行完毕后，回到主线程执行下边任务
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("3---\(Thread.current)") // 打印当前线程
            }
            debugPrint("group---end")
        }
    }
    
    /**
     * 队列组 groupWait
     */
    private func groupWait() {
        
        debugPrint("currentThread---\(Thread.current)")  // 打印当前线程
        debugPrint("groupWait---begin")
        
        let group = DispatchGroup()
        
        self.concurrentQueue.async(group: group) {
            // 追加任务1
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1---\(Thread.current)") // 打印当前线程
            }
        }
        
        self.concurrentQueue.async(group: group) {
            // 追加任务2
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2---\(Thread.current)") // 打印当前线程
            }
        }
        
        // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
        let _ = group.wait(timeout: DispatchTime.distantFuture)
        
        debugPrint("groupWait---end");
    }
    
    
    /**
     * 队列组 Enter、Leave
     */
    private func groupEnterAndLeave() {
        
        debugPrint("currentThread---\(Thread.current)")  // 打印当前线程
        debugPrint("groupEnterAndLeave---begin")
        
        let group = DispatchGroup()
        
        group.enter()
        self.concurrentQueue.async {
            // 追加任务1
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1---\(Thread.current)") // 打印当前线程
            }
            group.leave()
        }
        
        
        group.enter()
        self.concurrentQueue.async {
            // 追加任务2
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2---\(Thread.current)") // 打印当前线程
            }
            group.leave()
        }
        
        
        // 等前面的异步操作都执行完毕后，回到主线程
        group.notify(queue: DispatchQueue.main) {
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("3---\(Thread.current)") // 打印当前线程
            }
            debugPrint("groupEnterAndLeave---end");
        }
    }
    
    
    /**
     * semaphore 线程同步
     */
    private func semaphoreSync() {
        
        debugPrint("currentThread---\(Thread.current)")  // 打印当前线程
        debugPrint("semaphore---begin")
        
        let semaphore = DispatchSemaphore(value: 0)
        self.concurrentQueue.async {
            
            // 追加任务1
            Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
            debugPrint("1---\(Thread.current)") // 打印当前线程
            semaphore.signal()
        }
        
        let _ = semaphore.wait(wallTimeout: DispatchWallTime.distantFuture)
        debugPrint("semaphore---end")
        
    }
    
    /**
     * 非线程安全：不使用 semaphore
     * 初始化火车票数量、卖票窗口(非线程安全)、并开始卖票
     */
    private func initTicketStatusNotSave() {
        
        debugPrint("currentThread---\(Thread.current)") // 打印当前线程
        debugPrint("semaphore---begin")
        
        self.ticketSurplusCount = 50
        
        // queue1 代表北京火车票售卖窗口
        let queue1 = DispatchQueue(label: "com.mike.testQueue1")
        
        // queue2 代表上海火车票售卖窗口
        let queue2 = DispatchQueue(label: "com.mike.testQueue2")
        
        queue1.async { [weak self] in
            guard let self = self else { return }
            self.saleTicketNotSafe()
        }
        
        queue2.async { [weak self] in
            guard let self = self else { return }
            self.saleTicketNotSafe()
        }
        
        
    }
    
    
    /**
     * 售卖火车票(非线程安全)
     */
    private func saleTicketNotSafe() {
        
        while true {
            //如果还有票，继续售卖
            if self.ticketSurplusCount > 0 {
                self.ticketSurplusCount -= 1
                debugPrint("剩余票数:\(self.ticketSurplusCount) 窗口\(Thread.current)")
                Thread.sleep(forTimeInterval: 0.2)
            } else {
                //如果已卖完，关闭售票窗口
                debugPrint("所有火车票均已售完")
                break
            }
        }
    }
    
    /**
     * 线程安全：使用 semaphore 加锁
     * 初始化火车票数量、卖票窗口(线程安全)、并开始卖票
     */
    private func initTicketStatusSave() {
        
        debugPrint("currentThread---\(Thread.current)") // 打印当前线程
        debugPrint("semaphore---begin")
        
        self.ticketSurplusCount = 50
        
        // queue1 代表北京火车票售卖窗口
        let queue1 = DispatchQueue(label: "com.mike.testQueue1")
        
        // queue2 代表上海火车票售卖窗口
        let queue2 = DispatchQueue(label: "com.mike.testQueue2")
        
        queue1.async { [weak self] in
            guard let self = self else { return }
            self.saleTicketSafe()
        }
        
        queue2.async { [weak self] in
            guard let self = self else { return }
            self.saleTicketSafe()
        }
    }
    
    /**
     * 售卖火车票(线程安全)
     */
    private func saleTicketSafe() {
        
        while (true) {
            
            // 相当于加锁
            let _ = self.semaphoreLock.wait(timeout: .distantFuture)
            
            if self.ticketSurplusCount > 0 {
                self.ticketSurplusCount -= 1
                debugPrint("剩余票数:\(self.ticketSurplusCount) 窗口\(Thread.current)")
                Thread.sleep(forTimeInterval: 0.2)
            } else {
                //如果已卖完，关闭售票窗口
                debugPrint("所有火车票均已售完")
                // 相当于解锁
                self.semaphoreLock.signal()
                break
            }
            // 相当于解锁
            self.semaphoreLock.signal()
        }
    }
    
    
    /// 主线程只会执行主队列的任务吗？
    private func mainThread() {
        
        let key = DispatchSpecificKey<Any>()
        
        DispatchQueue.main.setSpecific(key: key, value: "main")
        
        func log() {
            debugPrint("main thread: \(Thread.isMainThread)")
            let value = DispatchQueue.getSpecific(key: key)
            debugPrint("main queue: \(value != nil)")
        }
        
        DispatchQueue.global().sync(execute: log)
        RunLoop.current.run()

    }
    
    /// 主队列任务只会在主线程上执行吗?
    private func mainQueue() {
        ///但在iOS系统上可以说主队列任务只会在主线程上执行
        //http://www.cocoachina.com/cms/wap.php?action=article&id=24726
        let key = DispatchSpecificKey<Any>()
        
        DispatchQueue.main.setSpecific(key: key, value: "main")
        
        func log() {
            debugPrint("main thread: \(Thread.isMainThread)")
            let value = DispatchQueue.getSpecific(key: key)
            debugPrint("main queue: \(value != nil)")
        }
        
        DispatchQueue.global().async {
            DispatchQueue.main.async(execute: log)
        }
        //dispatchMain()
    }
}
