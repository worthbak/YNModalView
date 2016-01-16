//
//  YNModalView.swift
//  YNModalView
//
//  Created by David Baker on 1/15/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

public class YNModalViewController: UIViewController {
  
  var modalView: UIView!
  
  public lazy var doneButton: UIButton = {
    let doneButton = UIButton(type: .System)
    doneButton.setTitle("Dismiss", forState: .Normal)
    doneButton.translatesAutoresizingMaskIntoConstraints = false
    doneButton.addTarget(self, action: "dismissTapped:", forControlEvents: .TouchUpInside)
    
    return doneButton
  }()
  
  public init() {
    super.init(nibName:nil, bundle:nil)
    
    self.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
  }
  
  required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .clearColor()
    
    self.modalView = UIView(frame: .zero)
    self.modalView.backgroundColor = .greenColor()
    self.modalView.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(self.modalView)
    self.modalView.heightAnchor.constraintEqualToConstant(300).active = true
    self.modalView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, constant: -30).active = true
    self.modalView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
    self.modalView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
    
    self.modalView.addSubview(doneButton)
    doneButton.centerXAnchor.constraintEqualToAnchor(self.modalView.centerXAnchor).active = true
    doneButton.centerYAnchor.constraintEqualToAnchor(self.modalView.centerYAnchor).active = true
  }
  
  func dismissTapped(sender: AnyObject?) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
}