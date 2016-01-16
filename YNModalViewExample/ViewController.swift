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
  
  lazy var arrowBackgroundView: UIImageView = {
    let arrowImage = UIImage(named: "arrows")
    let arrowView = UIImageView(image: arrowImage)
    arrowView.translatesAutoresizingMaskIntoConstraints = false
    
    return arrowView
  }()
  
  lazy var exampleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Tap Here!"
    
    return label
  }()
  
  lazy var exampleButton: UIButton = {
    let exampleButton = UIButton(type: .System)
    exampleButton.translatesAutoresizingMaskIntoConstraints = false
    exampleButton.setTitle("Present View", forState: .Normal)
    exampleButton.addTarget(self, action: "showTapped:", forControlEvents: .TouchUpInside)
    
    return exampleButton
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.title = "Example View"
    
    self.view.backgroundColor = .whiteColor()
    self.view.addSubview(self.arrowBackgroundView)
    self.arrowBackgroundView.topAnchor.constraintEqualToAnchor(self.view.layoutMarginsGuide.topAnchor).active = true
    self.arrowBackgroundView.leadingAnchor.constraintEqualToAnchor(self.view.layoutMarginsGuide.leadingAnchor).active = true
    self.arrowBackgroundView.trailingAnchor.constraintEqualToAnchor(self.view.layoutMarginsGuide.trailingAnchor).active = true
    self.arrowBackgroundView.bottomAnchor.constraintEqualToAnchor(self.view.layoutMarginsGuide.bottomAnchor).active = true
    
    self.view.addSubview(self.exampleButton)
    self.exampleButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
    self.exampleButton.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
    
    self.view.addSubview(self.exampleLabel)
    self.exampleLabel.bottomAnchor.constraintEqualToAnchor(self.exampleButton.topAnchor).active = true
    self.exampleLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
  }
  
  func showTapped(sender: AnyObject?) {
    let modalViewController = YNModalViewController()
    // obviously need this to be in YNModalViewController - override init
    modalViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
    self.presentViewController(modalViewController, animated: true, completion: nil)
  }
  
  
}

