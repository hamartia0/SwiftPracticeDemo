//
//  ViewController.swift
//  SimpleClock
//
//  Created by 赵白杨 on 03/03/2017.
//  Copyright © 2017 zby personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var countTime = 0
    let showTimeLabel = UILabel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupView()
        
    }

    func setupView() {
        let pauseBtn = UIButton.init(type: .custom)
        pauseBtn.frame = CGRect.init(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2, width: self.view.frame.size.width/2, height: self.view.frame.size.height/2)
        
        pauseBtn.setTitle("暂停", for: .normal)
        pauseBtn.setTitle("继续", for: .selected)
        
        pauseBtn.isSelected = false
        
        pauseBtn.backgroundColor = UIColor.blue
        
        pauseBtn.addTarget(self, action: #selector(pauseAction(sender:)), for: .touchUpInside)
        
        self.view.addSubview(pauseBtn)
        
        let endBtn = UIButton.init(type: .custom)
        endBtn.frame = CGRect.init(x: 0, y: self.view.frame.size.height/2, width: self.view.frame.size.width/2, height: self.view.frame.size.height/2)
        
        endBtn.setTitle("开始", for: .normal)
        endBtn.setTitle("结束", for: .selected)
        
        endBtn.isSelected = false
        
        endBtn.backgroundColor = UIColor.orange
        
        endBtn.addTarget(self, action: #selector(startCountAction(sender:)), for: .touchUpInside)
        
        self.view.addSubview(endBtn)
        
        showTimeLabel.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.height/2)
        showTimeLabel.backgroundColor = UIColor.yellow
        showTimeLabel.font = UIFont.boldSystemFont(ofSize: 200)
        showTimeLabel.text = "0"
        showTimeLabel.textColor = UIColor.white
        showTimeLabel.textAlignment = NSTextAlignment.center
        
        self.view.addSubview(showTimeLabel)
        
    }
    
    func countUpSecond() {
        
        countTime += 1
        
        showTimeLabel.text = "\(countTime)"

    }
    
    func pauseAction(sender: UIButton) {
        
        if !sender.isSelected {
            timer.fireDate = NSDate.distantFuture
        } else {
            timer.fireDate = NSDate.distantPast
        }
        
        sender.isSelected = !sender.isSelected
        
    }
    
    func startCountAction(sender: UIButton) {
        
        if !sender.isSelected {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countUpSecond), userInfo: nil, repeats: true)
        } else {
            timer.invalidate()
            showTimeLabel.text = "0"
            countTime = 0
        }
        
        sender.isSelected = !sender.isSelected
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

