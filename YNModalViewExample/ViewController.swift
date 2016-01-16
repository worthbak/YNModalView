//
//  ViewController.swift
//  YNModalViewExample
//
//  Created by David Baker on 1/15/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit
import YNModalView

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let funButton = UIButton(type: .System)
    funButton.translatesAutoresizingMaskIntoConstraints = false
    funButton.setTitle("show", forState: .Normal)
    funButton.addTarget(self, action: "showTapped:", forControlEvents: .TouchUpInside)
    
    self.view.addSubview(funButton)
    funButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
    funButton.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func showTapped(sender: AnyObject?) {
    let modalfun = YNModalView()
    self.presentViewController(modalfun, animated: true, completion: nil)
  }
  
  
}

