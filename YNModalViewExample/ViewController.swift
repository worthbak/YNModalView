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
  
  var presentedModalViewController: YNModalViewController?
  
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
  
  lazy var defaultButton: UIButton = {
    let exampleButton = UIButton(type: .System)
    exampleButton.translatesAutoresizingMaskIntoConstraints = false
    exampleButton.setTitle("Default View", forState: .Normal)
    exampleButton.addTarget(self, action: #selector(ViewController.showDefaultTapped(_:)), forControlEvents: .TouchUpInside)
    
    return exampleButton
  }()
  
  lazy var customButton: UIButton = {
    let exampleButton = UIButton(type: .System)
    exampleButton.translatesAutoresizingMaskIntoConstraints = false
    exampleButton.setTitle("Custom View", forState: .Normal)
    exampleButton.addTarget(self, action: #selector(ViewController.showCustomTapped(_:)), forControlEvents: .TouchUpInside)
    
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
    
    self.view.addSubview(self.defaultButton)
    self.defaultButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
    self.defaultButton.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
    
    self.view.addSubview(self.exampleLabel)
    self.exampleLabel.bottomAnchor.constraintEqualToAnchor(self.defaultButton.topAnchor).active = true
    self.exampleLabel.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
    
    self.view.addSubview(self.customButton)
    self.customButton.topAnchor.constraintEqualToAnchor(self.defaultButton.bottomAnchor).active = true
    self.customButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
  }
  
  func showDefaultTapped(sender: AnyObject?) {
    let modalViewController = YNModalViewController()
    modalViewController.presentFromViewController(self)
  }
  
  func showCustomTapped(sender: AnyObject?) {
    let customView = UIView(frame: .zero)
    customView.backgroundColor = .orangeColor()
    customView.translatesAutoresizingMaskIntoConstraints = false
    
    let dismissButton = UIButton(type: .System)
    dismissButton.translatesAutoresizingMaskIntoConstraints = false
    dismissButton.setTitle("dismiss", forState: .Normal)
    dismissButton.addTarget(self, action: #selector(ViewController.dismiss(_:)), forControlEvents: .TouchUpInside)
    
    customView.addSubview(dismissButton)
    dismissButton.centerXAnchor.constraintEqualToAnchor(customView.centerXAnchor).active = true
    dismissButton.centerYAnchor.constraintEqualToAnchor(customView.centerYAnchor).active = true
    
    self.presentedModalViewController = YNModalViewController(withCustomView: customView, andSize: CGSizeMake(300, 300))
    self.presentedModalViewController?.presentFromViewController(self)
  }
  
  func dismiss(sender: AnyObject?) {
    if let viewCon = self.presentedModalViewController {
      viewCon.dismiss()
    }
  }
  
}

