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
  var effectView: UIVisualEffectView!
  
  var modalViewTopConstraint: NSLayoutConstraint?
  var modalViewCenterYConstraint: NSLayoutConstraint?
  
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
    
    // make a vibrancy view
    self.effectView = UIVisualEffectView(frame: .zero)
    self.effectView.translatesAutoresizingMaskIntoConstraints = false
    self.effectView.effect = UIBlurEffect(style: .Light)
    self.effectView.alpha = 0.0
    
    self.view.addSubview(self.effectView)
    self.effectView.topAnchor.constraintEqualToAnchor(self.view.topAnchor).active = true
    self.effectView.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor).active = true
    self.effectView.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor).active = true
    self.effectView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
    
    self.modalView = UIView(frame: .zero)
    self.modalView.backgroundColor = .greenColor()
    self.modalView.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(self.modalView)
    self.modalView.heightAnchor.constraintEqualToConstant(300).active = true
    self.modalView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, constant: -30).active = true
    self.modalView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
    
    self.modalViewTopConstraint = self.modalView.topAnchor.constraintEqualToAnchor(self.view.bottomAnchor)
    self.modalViewTopConstraint?.active = true
    
    self.modalView.addSubview(doneButton)
    doneButton.centerXAnchor.constraintEqualToAnchor(self.modalView.centerXAnchor).active = true
    doneButton.centerYAnchor.constraintEqualToAnchor(self.modalView.centerYAnchor).active = true
  }
  
  public func presentYNModalViewControllerFromViewController(viewController: UIViewController, withCompletionHandler completionHandler: (() -> Void)?) {
    
    
    viewController.presentViewController(self, animated: false) {
      
      self.view.layoutIfNeeded()
      
      UIView.animateWithDuration(0.3, animations: {
        self.effectView?.alpha = 1.0
        
        }) { done in
          //
      }
      
      UIView.animateWithDuration(0.5, delay: 0.2, options: .CurveEaseOut, animations: { () -> Void in
        self.modalViewTopConstraint?.active = false
        self.modalViewCenterYConstraint = self.modalView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor)
        self.modalViewCenterYConstraint?.active = true
        
        self.view.layoutIfNeeded()
        }, completion: nil)
    }
  }
  
  func dismissTapped(sender: AnyObject?) {
    self.view.layoutIfNeeded()
    UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
      () -> Void in
      self.effectView?.alpha = 0.0
      
      self.modalViewCenterYConstraint?.active = false
      
      self.modalViewTopConstraint = self.modalView.topAnchor.constraintEqualToAnchor(self.view.bottomAnchor)
      self.modalViewTopConstraint?.active = true
      
      self.view.layoutIfNeeded()
      }) { done in self.dismissViewControllerAnimated(false, completion: nil) }
    

  }
  
}