//
//  ViewController.swift
//  YNModalViewExample
//
//  Created by David Baker on 1/15/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

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
    let exampleButton = UIButton(type: .system)
    exampleButton.translatesAutoresizingMaskIntoConstraints = false
    exampleButton.setTitle("Default View", for: UIControlState())
    exampleButton.addTarget(self, action: #selector(ViewController.showDefaultTapped(_:)), for: .touchUpInside)
    
    return exampleButton
  }()
  
  lazy var customButton: UIButton = {
    let exampleButton = UIButton(type: .system)
    exampleButton.translatesAutoresizingMaskIntoConstraints = false
    exampleButton.setTitle("Custom View", for: UIControlState())
    exampleButton.addTarget(self, action: #selector(ViewController.showCustomTapped(_:)), for: .touchUpInside)
    
    return exampleButton
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.title = "Example View"
    
    self.view.backgroundColor = .white()
    self.view.addSubview(self.arrowBackgroundView)
    self.arrowBackgroundView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor).isActive = true
    self.arrowBackgroundView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor).isActive = true
    self.arrowBackgroundView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor).isActive = true
    self.arrowBackgroundView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor).isActive = true
    
    self.view.addSubview(self.defaultButton)
    self.defaultButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    self.defaultButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    
    self.view.addSubview(self.exampleLabel)
    self.exampleLabel.bottomAnchor.constraint(equalTo: self.defaultButton.topAnchor).isActive = true
    self.exampleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    
    self.view.addSubview(self.customButton)
    self.customButton.topAnchor.constraint(equalTo: self.defaultButton.bottomAnchor).isActive = true
    self.customButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
  }
  
  func showDefaultTapped(_ sender: AnyObject?) {
    let modalViewController = YNModalViewController()
    modalViewController.presentFromViewController(self)
  }
  
  func showCustomTapped(_ sender: AnyObject?) {
    let customView = UIView(frame: .zero)
    customView.backgroundColor = .orange()
    customView.translatesAutoresizingMaskIntoConstraints = false
    
    let dismissButton = UIButton(type: .system)
    dismissButton.translatesAutoresizingMaskIntoConstraints = false
    dismissButton.setTitle("dismiss", for: UIControlState())
    dismissButton.addTarget(self, action: #selector(ViewController.dismiss(_:)), for: .touchUpInside)
    
    customView.addSubview(dismissButton)
    dismissButton.centerXAnchor.constraint(equalTo: customView.centerXAnchor).isActive = true
    dismissButton.centerYAnchor.constraint(equalTo: customView.centerYAnchor).isActive = true
    
    self.presentedModalViewController = YNModalViewController(withCustomView: customView, andSize: CGSize(width: 300, height: 300))
    self.presentedModalViewController?.presentFromViewController(self)
  }
  
  func dismiss(_ sender: AnyObject?) {
    if let viewCon = self.presentedModalViewController {
      viewCon.dismiss()
    }
  }
  
}

