//
//  OperationC.swift
//  XBMultithreadingDemo
//
//  Created by xiaobin liu on 2018/12/29.
//  Copyright © 2018 Sky. All rights reserved.
//  Reference https://www.jianshu.com/p/4b1d77054b35, https://github.com/bujige/YSC-NSOperation-demo

import UIKit


/// MARK - 操作队列控制器
final class OperationC: UIViewController {


    /* 剩余火车票数 */
    private var ticketSurplusCount: Int = 50
    private var lock: NSLock = NSLock()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "操作队列"
        
        //self.useBlockOperation()
        //self.useBlockOperationAddExecutionBlock()
        //self.addOperationToQueue()
        //self.addOperationWithBlockToQueue()
        //self.setMaxConcurrentOperationCount()
        //self.setQueuePriority()
        //self.addDependency()
        //self.communication()
        //self.completionBlock()
        //self.initTicketStatusNotSave()
        self.initTicketStatusSave()
    }
    
    
    /**
     * 使用子类 NSBlockOperation(在当前线程使用 NSBlockOperation)
     */
    private func useBlockOperation() {
        
        // 1.创建 NSBlockOperation 对象
        let op = BlockOperation {
            
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1----\(Thread.current)") //打印当前线程
            }
        }
        
        // 2.调用 start 方法开始执行操作
        op.start()
    }
    
    /**
     * 使用子类 NSBlockOperation
     * 调用方法 AddExecutionBlock:
     */
    private func useBlockOperationAddExecutionBlock() {
        
        
        // 1.创建 NSBlockOperation 对象
        let op = BlockOperation {
            
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1----\(Thread.current)") //打印当前线程
            }
        }
        
        //添加额外的操作2
        op.addExecutionBlock {
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2----\(Thread.current)") //打印当前线程
            }
        }
        
        //添加额外的操作3
        op.addExecutionBlock {
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("3----\(Thread.current)") //打印当前线程
            }
        }
        
        //添加额外的操作4
        op.addExecutionBlock {
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("4----\(Thread.current)") //打印当前线程
            }
        }
        
        //添加额外的操作5
        op.addExecutionBlock {
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("5----\(Thread.current)") //打印当前线程
            }
        }
        
        
        // 2.调用 start 方法开始执行操作
        op.start()
        
    }
    
    /**
     * 使用 addOperation: 将操作加入到操作队列中
     */
    private func addOperationToQueue() {
        
        // 1.创建队列
        let queue = OperationQueue()
        
        // 2.创建操作
        // 使用 BlockOperation 创建操作1
        let op1 = BlockOperation {
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1----\(Thread.current)") //打印当前线程
            }
        }
        
        // 使用 BlockOperation 创建操作2
        let op2 = BlockOperation {
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2----\(Thread.current)") //打印当前线程
            }
        }
        
        // 使用 BlockOperation 创建操作3
        let op3 = BlockOperation {
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("3----\(Thread.current)") //打印当前线程
            }
        }
        
        // 3.使用 addOperation: 添加所有操作到队列中
        queue.addOperation(op1)
        queue.addOperation(op2)
        queue.addOperation(op3)
    }
    
    /**
     * 使用 addOperationWithBlock: 将操作加入到操作队列中
     */
    private func addOperationWithBlockToQueue() {
        
        /// 1.创建队列
        let queue = OperationQueue()
        
        // 2.使用 addOperationWithBlock: 添加操作到队列中
        queue.addOperation {
            
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1----\(Thread.current)") //打印当前线程
            }
        }
        
        queue.addOperation {
            
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2----\(Thread.current)") //打印当前线程
            }
        }
        
        queue.addOperation {
            
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("3----\(Thread.current)") //打印当前线程
            }
        }
    }
    
    /**
     * 设置 MaxConcurrentOperationCount（最大并发操作数）
     */
    private func setMaxConcurrentOperationCount() {
        
        // 1.创建队列
        let queue = OperationQueue()
        
        // 2.设置最大并发操作数
        //queue.maxConcurrentOperationCount = 1 // 串行队列
        queue.maxConcurrentOperationCount = 2 // 并发队列
        //queue.maxConcurrentOperationCount = 8 // 并发队列
        
        // 3.使用 addOperationWithBlock: 添加操作到队列中
        queue.addOperation {
            
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1----\(Thread.current)") //打印当前线程
            }
        }
        
        queue.addOperation {
            
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2----\(Thread.current)") //打印当前线程
            }
        }
        
        queue.addOperation {
            
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("3----\(Thread.current)") //打印当前线程
            }
        }
    }
    
    /**
     * 设置优先级
     * 就绪状态下，优先级高的会优先执行，但是执行时间长短并不是一定的，所以优先级高的并不是一定会先执行完毕
     */
    private func setQueuePriority() {
        
        // 1.创建队列
        let queue = OperationQueue()
        
        let op1 = BlockOperation {
            
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1----\(Thread.current)") //打印当前线程
            }
        }
        op1.queuePriority = .low
        
        let op2 = BlockOperation {
            
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2----\(Thread.current)") //打印当前线程
            }
        }
        op2.queuePriority = .veryHigh
        
        queue.addOperation(op1)
        queue.addOperation(op2)
    }
    
    
    /**
     * 操作依赖
     * 使用方法：addDependency:
     */
    private func addDependency() {
        
        // 1.创建队列
        let queue = OperationQueue()
        
        let op1 = BlockOperation {
            
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1----\(Thread.current)") //打印当前线程
            }
        }
        
        let op2 = BlockOperation {
            
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2----\(Thread.current)") //打印当前线程
            }
        }
        
        // 3.添加依赖
        op2.addDependency(op1) // 让op2 依赖于 op1，则先执行op1，在执行op2
        
        queue.addOperation(op1)
        queue.addOperation(op2)
    }
    
    /**
     * 线程间通信
     */
    private func communication() {
        
        // 1.创建队列
        let queue = OperationQueue()
        
        // 2.添加操作
        queue.addOperation {
            
            // 异步进行耗时操作
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1----\(Thread.current)") //打印当前线程
            }
            
            // 回到主线程
            OperationQueue.main.addOperation {
                // 进行一些 UI 刷新等操作
                (0...2).forEach { (index) in
                    Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                    debugPrint("2----\(Thread.current)") //打印当前线程
                }
            }
        }
        
    }
    
    /**
     * 完成操作 completionBlock
     */
    private func completionBlock() {
        
        // 1.创建队列
        let  queue = OperationQueue()
        
        let op1 = BlockOperation {
            
            // 异步进行耗时操作
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("1----\(Thread.current)") //打印当前线程
            }
        }
        
        // 3.添加完成操作
        op1.completionBlock = {
            (0...2).forEach { (index) in
                Thread.sleep(forTimeInterval: 2) // 模拟耗时操作
                debugPrint("2----\(Thread.current)") //打印当前线程
            }
        }
        
        queue.addOperation(op1)
    }
    
    
    /**
     * 非线程安全：不使用 NSLock
     * 初始化火车票数量、卖票窗口(非线程安全)、并开始卖票
     */
    private func initTicketStatusNotSave() {
        
        debugPrint("currentThread---\(Thread.current)")  // 打印当前线程
        self.ticketSurplusCount = 50
        
        // 1.创建 queue1,queue1 代表北京火车票售卖窗口
        let queue1 = OperationQueue()
        queue1.maxConcurrentOperationCount = 1
        
        // 2.创建 queue2,queue2 代表上海火车票售卖窗口
        let queue2 = OperationQueue()
        queue2.maxConcurrentOperationCount = 1
        
        // 3.创建卖票操作 op1
        let op1 = BlockOperation { [weak self] in
            guard let self = self else { return }
            self.saleTicketNotSafe()
        }
        
        let op2 = BlockOperation { [weak self] in
            guard let self = self else { return }
            self.saleTicketNotSafe()
        }
        
        // 5.添加操作，开始卖票
        queue1.addOperation(op1)
        queue2.addOperation(op2)
    }
    
    /**
     * 售卖火车票(非线程安全)
     */
    private func saleTicketNotSafe() {
        
        while true {
            
            if self.ticketSurplusCount > 0 {
                //如果还有票，继续售卖
                self.ticketSurplusCount -= 1
                debugPrint("剩余票数:\(self.ticketSurplusCount) 窗口:\(Thread.current)")
                Thread.sleep(forTimeInterval: 0.2)
            } else {
                debugPrint("所有火车票均已售完")
                break
            }
        }
    }
    
    /**
     * 线程安全：使用 NSLock 加锁
     * 初始化火车票数量、卖票窗口(线程安全)、并开始卖票
     */
    private func initTicketStatusSave() {
        
        debugPrint("currentThread---\(Thread.current)")  // 打印当前线程
        self.ticketSurplusCount = 50
        
        // 1.创建 queue1,queue1 代表北京火车票售卖窗口
        let queue1 = OperationQueue()
        queue1.maxConcurrentOperationCount = 1
        
        // 2.创建 queue2,queue2 代表上海火车票售卖窗口
        let queue2 = OperationQueue()
        queue2.maxConcurrentOperationCount = 1
        
        // 3.创建卖票操作 op1
        let op1 = BlockOperation { [weak self] in
            guard let self = self else { return }
            self.saleTicketSafe()
        }
        
        let op2 = BlockOperation { [weak self] in
            guard let self = self else { return }
            self.saleTicketSafe()
        }
        
        // 5.添加操作，开始卖票
        queue1.addOperation(op1)
        queue2.addOperation(op2)
    }
    
    /**
     * 售卖火车票(线程安全)
     */
    private func saleTicketSafe() {
        
        while true {
            // 加锁
            self.lock.lock(); defer { self.lock.unlock() }
            
            if self.ticketSurplusCount > 0 {
                //如果还有票，继续售卖
                self.ticketSurplusCount -= 1
                debugPrint("剩余票数:\(self.ticketSurplusCount) 窗口:\(Thread.current)")
                Thread.sleep(forTimeInterval: 0.2)
            }
            
            if self.ticketSurplusCount <= 0 {
                debugPrint("所有火车票均已售完")
                break
            }
        }
    }
}
