//
//  ViewController.swift
//  XBMultithreadingDemo
//
//  Created by xiaobin liu on 2018/12/28.
//  Copyright © 2018 Sky. All rights reserved.
//

import UIKit


/// MARK - 
final class ViewController: UIViewController {

    /// 列表
    private lazy var tableView: UITableView = {
        let tem = UITableView(frame: self.view.frame)
        tem.rowHeight = 50
        tem.backgroundColor = UIColor.white
        tem.backgroundView = nil
        tem.dataSource = self
        tem.delegate = self
        tem.tableFooterView = UIView()
        tem.register(UITableViewCell.self, forCellReuseIdentifier: "com.mike.thread")
        return tem
    }()
    
    /// 数据源
    private lazy var data = ["GCD演示",
                             "OperationQueue演示"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
    }
}

// MARK: - <#UITableViewDataSource#>
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.mike.thread")
        cell?.textLabel?.text = data[indexPath.row]
        return cell!
    }
}


// MARK: - <#UITableViewDelegate#>
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc = GCDC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = OperationC()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
