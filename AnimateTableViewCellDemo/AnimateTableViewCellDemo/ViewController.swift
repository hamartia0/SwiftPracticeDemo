//
//  ViewController.swift
//  AnimateTableViewCellDemo
//
//  Created by 赵白杨 on 06/03/2017.
//  Copyright © 2017 zby personal. All rights reserved.
//

import UIKit

let BYRect = UIScreen.main.bounds
let BYWidth = BYRect.size.width
let BYHeight = BYRect.size.height

class ViewController: UIViewController {
    
    let tableView = UITableView(frame: BYRect, style: .plain)
    let reuseIdentifier = "CustomCell"
    let tableData = ["Read 3 article on Medium", "Cleanup bedroom", "Go for a run", "Hit the gym", "Build another swift project", "Movement training", "Fix the layout problem of a client project", "Write the experience of #30daysSwift", "Inbox Zero", "Booking the ticket to Chengdu", "Test the Adobe Project Comet", "Hop on a call to mom", "Movement training", "Fix the layout problem of a client project", "Write the experience of #30daysSwift", "Inbox Zero", "Booking the ticket to Chengdu", "Test the Adobe Project Comet", "Hop on a call to mom"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.backgroundColor = .blue
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.tableFooterView = UIView()
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        view.addSubview(tableView)
        
        let pullRefreshControl = UIRefreshControl.init(frame: CGRect(x: 0.0, y: 0.0, width: BYWidth, height: 100.0))
        let refreshLabel = UILabel.init(frame: CGRect(x: 0.0, y: 40.0, width: BYWidth, height: 40))
        refreshLabel.text = "松开后重新加载数据"
        refreshLabel.textAlignment = .center
        refreshLabel.font = UIFont.systemFont(ofSize: 12)
//        refreshLabel.backgroundColor = .orange
        refreshLabel.textColor = .green
        pullRefreshControl.addSubview(refreshLabel)
        
//        let pullRefreshControl = UIRefreshControl.init()
        pullRefreshControl.addTarget(self, action: #selector(refreshClick(refreshControl:)), for: .valueChanged)
        tableView.addSubview(pullRefreshControl)
        pullRefreshControl.beginRefreshing()
        refreshClick(refreshControl: pullRefreshControl)
        
//        let pullUpRefreshControl = UIRefreshControl.init(frame: CGRect(x: 0.0, y: BYHeight - 100, width: BYWidth, height: 100))
//        pullUpRefreshControl.addTarget(self, action: #selector(pullUpActioin(pullUpAction:)), for: .touchDragExit)
//        let loadMoreLabel = UILabel.init(frame: CGRect(x: 0.0, y: BYHeight - 100, width: BYWidth, height: 100))
//        loadMoreLabel.text = "上拉加载更多"
//        loadMoreLabel.textAlignment = .center
//        loadMoreLabel.textColor = .green
//        
//        pullUpRefreshControl.addSubview(loadMoreLabel)
//        tableView.addSubview(pullUpRefreshControl)
        
    }
    
    func pullUpActioin(pullUpAction: UIRefreshControl) {
        animateTable()
        pullUpAction.endRefreshing()
        print("执行上拉加载中")
    }
    func refreshClick(refreshControl: UIRefreshControl) {
        animateTable()
        refreshControl.endRefreshing()
        print("执行下拉刷新中")
    }
    
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight = BYRect.size.height
        
        for (index, cell) in cells.enumerated() {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
            UIView.animate(withDuration: 1.0,
                           delay: 0.05 * Double(index),
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0.0,
                           options: [],
                           animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            },
                           completion: nil)
        }
    }
    
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = tableData.count - 1
        let color = (CGFloat(index)/CGFloat(itemCount)) * 0.6
        return UIColor(red: 1.0, green: color, blue: 0.0, alpha: 1.0)
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: -UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = tableData[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.textLabel?.backgroundColor = .clear
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 18)
        cell.selectionStyle = UITableViewCellSelectionStyle.gray
        
        return cell
    }
    
    //MARK: -UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = colorForIndex(index: indexPath.row)
    }
}

