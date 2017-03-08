//
//  ViewController.swift
//  CustomFont
//
//  Created by 赵白杨 on 08/03/2017.
//  Copyright © 2017 zby personal. All rights reserved.
//

import UIKit

let BYRect = UIScreen.main.bounds
let BYWidth = BYRect.size.width
let BYHeight = BYRect.size.height


class ViewController: UIViewController {
    
    let tableView = UITableView(frame: BYRect, style: .plain)
    let dataArray = ["30 Days Swift", "这些字体特别适合打「奋斗」和「理想」 ", "谢谢「造字工房」，本案例完全模仿allenwong，不涉及商业使用", "使用到造字工房劲黑体，致黑体，童心体", "呵呵，🤣继续学习30 Days Swift，搞搞搞起来", "原作者 微博 @Allen朝晖", "30 Days Swift", "这些字体特别适合打「奋斗」和「理想」 ", "谢谢「造字工房」，本案例完全模仿allenwong，不涉及商业使用", "使用到造字工房劲黑体，致黑体，童心体", "呵呵，🤣继续学习30 Days Swift，搞搞搞起来", "原作者 微博 @Allen朝晖", "30 Days Swift", "这些字体特别适合打「奋斗」和「理想」 ", "谢谢「造字工房」，本案例完全模仿allenwong，不涉及商业使用", "使用到造字工房劲黑体，致黑体，童心体", "呵呵，🤣继续学习30 Days Swift，搞搞搞起来", "原作者 微博 @Allen朝晖", "30 Days Swift", "这些字体特别适合打「奋斗」和「理想」 ", "谢谢「造字工房」，本案例完全模仿allenwong，不涉及商业使用", "使用到造字工房劲黑体，致黑体，童心体", "呵呵，🤣继续学习30 Days Swift，搞搞搞起来", "原作者 微博 @Allen朝晖"]
    let reuseIdentifier = "Cell"
    let fontArray = ["MFJinHei_Noncommercial-Regular", "MFTongXin_Noncommercial-Regular", "MFZhiHei_Noncommercial-Regular"]
    let pressBtn = UIButton(type: .system)
    var fontSelection = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getCustomFontName()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    func setupView() {
        
        view.backgroundColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .black
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        view.addSubview(tableView)
        
        pressBtn.frame = CGRect(x: BYWidth/2 - 60, y: BYHeight - 160, width: 120, height: 120)
        pressBtn.layer.cornerRadius = 60
        pressBtn.layer.backgroundColor = UIColor.yellow.cgColor
        pressBtn.setTitle("Change Font", for: UIControlState.normal)
        pressBtn.setTitleColor(.black, for: .normal)
        pressBtn.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        
        pressBtn.addTarget(self, action: #selector(changeFontOfCharacter), for: .touchUpInside)
        
        view.addSubview(pressBtn)
        
        
        
    }
    
    func changeFontOfCharacter() {
        
        // 通过此方法获取到的是可见的cell，在tableView的缓存机制中，缓存池中的cell数量仅比现在在屏幕上的cell数量多2,所以这两个cell的字体属性不会被更改，而且当实际中cell数量很多时，这两个cell还会被复用，所以会出现多次，这个cell的字体并没有改变的情况。
//        let cells = tableView.visibleCells
//        for cell in cells {
//            cell.textLabel?.font = UIFont(name: "MFJinHei_Noncommercial-Regular", size: 17)
//        }
        fontSelection = (fontSelection + 1) % 3
        
        tableView.reloadData()
    }
    
    func getCustomFontName() {
        for family in UIFont.familyNames {
            for font in UIFont.fontNames(forFamilyName: family) {
                print("font: \(font)")
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: -UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        
        return cell
    }
    
    //MARK: -UITableViewDelegate
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        cell.textLabel?.font = UIFont(name: fontArray[fontSelection], size: 17)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
