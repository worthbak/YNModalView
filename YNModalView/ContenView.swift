//
//  ContenView.swift
//  YNModalView
//
//  Created by David Baker on 1/18/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

protocol ContentViewDelegate: class {
  func dismissButtonTapped(sender: AnyObject)
}

class ContentView: UIView {
  
  weak var delegate: ContentViewDelegate?
  
  let doneButton: UIButton
  let textField: UITextField
  
  override init(frame: CGRect) {
    
    self.doneButton = UIButton(type: .System)
    self.doneButton.setTitle("Dismiss", forState: .Normal)
    self.doneButton.translatesAutoresizingMaskIntoConstraints = false
    
    self.textField = UITextField()
    self.textField.backgroundColor = .whiteColor()
    self.textField.translatesAutoresizingMaskIntoConstraints = false
    
    super.init(frame: frame)
    
    self.backgroundColor = .greenColor()
    self.translatesAutoresizingMaskIntoConstraints = false
    
    self.addSubview(self.doneButton)
    self.doneButton.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor).active = true
    self.doneButton.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
    self.doneButton.addTarget(self, action: "dismissTapped:", forControlEvents: .TouchUpInside)
    
    self.addSubview(self.textField)
    self.textField.topAnchor.constraintEqualToAnchor(self.doneButton.bottomAnchor, constant: 8).active = true
    self.textField.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor).active = true
    self.textField.widthAnchor.constraintEqualToConstant(100).active = true
    self.textField.heightAnchor.constraintEqualToConstant(44).active = true
  }

  required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  func dismissTapped(sender: AnyObject) {
    self.delegate?.dismissButtonTapped(sender)
  }
  
}
