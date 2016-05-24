//
//  ViewController.swift
//  MessageDetailScrollDemo
//
//  Created by neu on 16/5/24.
//  Copyright © 2016年 cactus. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {

    var tableView: UITableView?
    var invisibleScrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        self.tableView = UITableView(frame: self.view.bounds, style: .Plain)
        self.tableView?.rowHeight = 65
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "cellIdentifier")
        self.view.addSubview(self.tableView!)
        
        self.invisibleScrollView = UIScrollView(frame: self.view.bounds)
        self.invisibleScrollView?.contentInset.top = 64
        self.invisibleScrollView?.scrollIndicatorInsets.top = 64
        self.invisibleScrollView?.delegate = self
        self.invisibleScrollView?.userInteractionEnabled = false
        self.view.addSubview(self.invisibleScrollView!)
       self.invisibleScrollView?.setContentOffset(CGPointMake(0, -128), animated: false)
        self.tableView?.addGestureRecognizer((self.invisibleScrollView?.panGestureRecognizer)!)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
         self.invisibleScrollView?.contentSize = CGSize(width: tableView.bounds.size.width + 1, height: tableView.contentSize.height)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier", forIndexPath: indexPath) as! CustomTableViewCell
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        self.tableView?.contentOffset.y = scrollView.contentOffset.y
        self.tableView?.visibleCells.forEach({ (cell) in
            (cell as! CustomTableViewCell).rightConstraint.constant = scrollView.contentOffset.x - 45
        })
    }
    
    

}

