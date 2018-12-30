//
//  ThreadC.swift
//  XBMultithreadingDemo
//
//  Created by xiaobin liu on 2018/12/29.
//  Copyright © 2018 Sky. All rights reserved.
//  Reference https://www.jianshu.com/p/cbaeea5368b1, https://github.com/bujige/YSC-pthread-NSThread-demo

import UIKit


/// MARK - ThreadC
final class ThreadC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Thread演示"
        self.view.backgroundColor = UIColor.white
        self.createThread1()
    }
    
    
    /// 创建线程
    private func createThread1() {
        let thread = Thread {
            debugPrint("\(Thread.current)")
        }
        thread.start()
        
        
    }
}
