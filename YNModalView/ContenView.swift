//
//  ContenView.swift
//  YNModalView
//
//  Created by David Baker on 1/18/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

protocol ContentViewDelegate: class {
  func dismissButtonTapped(_ sender: AnyObject)
}

class ContentView: UIView {
  
  weak var delegate: ContentViewDelegate?
  
  let doneButton: UIButton
  let textField: UITextField
  
  override init(frame: CGRect) {
    
    self.doneButton = UIButton(type: .system)
    self.doneButton.setTitle("Dismiss", for: UIControlState())
    self.doneButton.translatesAutoresizingMaskIntoConstraints = false
    
    self.textField = UITextField()
    self.textField.backgroundColor = .white()
    self.textField.translatesAutoresizingMaskIntoConstraints = false
    
    super.init(frame: frame)
    
    self.backgroundColor = .green()
    self.translatesAutoresizingMaskIntoConstraints = false
    
    self.addSubview(self.doneButton)
    self.doneButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.doneButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    self.doneButton.addTarget(self, action: #selector(ContentView.dismissTapped(_:)), for: .touchUpInside)
    
    self.addSubview(self.textField)
    self.textField.topAnchor.constraint(equalTo: self.doneButton.bottomAnchor, constant: 8).isActive = true
    self.textField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.textField.widthAnchor.constraint(equalToConstant: 100).isActive = true
    self.textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
  }

  required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  func dismissTapped(_ sender: AnyObject) {
    self.delegate?.dismissButtonTapped(sender)
  }
  
}
