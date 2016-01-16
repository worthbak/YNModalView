//
//  YNModalView.swift
//  YNModalView
//
//  Created by David Baker on 1/15/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

public class YNModalView: UIViewController {
  
  public lazy var doneButton: UIButton = {
    let doneButton = UIButton(type: .System)
    doneButton.setTitle("Dismiss", forState: .Normal)
    doneButton.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(doneButton)
    doneButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
    doneButton.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
    
    return doneButton
  }()
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .blueColor()
    self.doneButton.addTarget(self, action: "dismissTapped:", forControlEvents: .TouchUpInside)
  }
  
  func dismissTapped(sender: AnyObject?) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
}