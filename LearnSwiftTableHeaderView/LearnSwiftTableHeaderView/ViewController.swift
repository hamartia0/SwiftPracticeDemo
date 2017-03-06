//
//  ViewController.swift
//  LearnSwiftTableHeaderView
//
//  Created by 赵白杨 on 03/03/2017.
//  Copyright © 2017 zby personal. All rights reserved.
//

import UIKit

let BYRect = UIScreen.main.bounds
let BYWidth = BYRect.size.width
let BYHeight = BYRect.size.height

let HeadViewHeight = BYHeight / 3.0

class ViewController: UIViewController {

    let datas = ["下","拉","可","以","出","现","很","神","奇","的","事","情","yo","yo","yo","yo","yo","yo"]
    let tableView = UITableView(frame: BYRect, style: .plain)
    let reuseIdentifier = "CustomCell"
    let headView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: BYWidth, height: HeadViewHeight))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        headView.backgroundColor = UIColor.white
        headView.contentMode = .scaleAspectFill
        headView.clipsToBounds = true
        view.addSubview(headView)
        
        let url = URL(string: "http://c.hiphotos.baidu.com/zhidao/pic/item/5ab5c9ea15ce36d3c704f35538f33a87e950b156.jpg")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let _ = data, error == nil else { return }
            DispatchQueue.main.sync {
                self.headView.image = UIImage(data: data!)
            }
        }
        
        task.resume()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.showsVerticalScrollIndicator = false
        
        tableView.contentInset.top = HeadViewHeight
        tableView.contentOffset = CGPoint(x: 0.0, y: -HeadViewHeight)
        
        view.addSubview(tableView)
        view.sendSubview(toBack: tableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController:UITableViewDataSource, UITableViewDelegate {
    //MARK: -DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = datas[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    //MARK: -Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsety = scrollView.contentOffset.y + scrollView.contentInset.top
        if offsety <= 0 {
            headView.frame = CGRect(x: 0.0, y: 0.0, width: BYWidth, height: HeadViewHeight - offsety)
        } else {
            let height = (HeadViewHeight - offsety) <= 0.0 ? 0.0 : (HeadViewHeight - offsety)
            headView.frame = CGRect(x: 0.0, y: 0.0, width: BYWidth, height: height)
            headView.alpha = height / HeadViewHeight
        }
    }
}

