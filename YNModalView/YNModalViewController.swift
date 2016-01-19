//
//  YNModalView.swift
//  YNModalView
//
//  Created by David Baker on 1/15/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

public class YNModalViewController: UIViewController {
  
  let modalView: UIView
  let modalViewSize: CGSize?
  
  lazy var effectView: UIVisualEffectView = {
    let effectView = UIVisualEffectView(frame: .zero)
    effectView.translatesAutoresizingMaskIntoConstraints = false
    effectView.effect = UIBlurEffect(style: .Light)
    effectView.alpha = 0.0
    
    return effectView
  }()
  
  var modalViewTopConstraint: NSLayoutConstraint?
  var modalViewBottomConstraint: NSLayoutConstraint?
  
  public convenience init() {
    self.init(withCustomView: ContentView(frame: .zero))
  }
  
  public init(withCustomView customView: UIView, andSize size: CGSize? = nil) {
    self.modalView = customView
    self.modalViewSize = size
    super.init(nibName:nil, bundle:nil)
    
    self.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
    
    if let contentView = self.modalView as? ContentView {
      contentView.delegate = self
    }
  }
  
  required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .clearColor()
    
    // constrain the vibrancy view
    self.view.addSubview(self.effectView)
    self.effectView.topAnchor.constraintEqualToAnchor(self.view.topAnchor).active = true
    self.effectView.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor).active = true
    self.effectView.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor).active = true
    self.effectView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
    
    let heightAnchor: NSLayoutConstraint
    self.view.addSubview(self.modalView)
    if let size = self.modalViewSize {
      heightAnchor = self.modalView.heightAnchor.constraintEqualToConstant(size.height)
      self.modalView.widthAnchor.constraintEqualToConstant(size.width).active = true
    } else {
      heightAnchor = self.modalView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, constant: -60)
      self.modalView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, constant: -30).active = true
    }
    heightAnchor.priority = 750
    heightAnchor.active = true
    
    self.modalView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
    self.modalViewTopConstraint = self.modalView.topAnchor.constraintEqualToAnchor(self.view.bottomAnchor)
    self.modalViewTopConstraint?.active = true
  }
  
  public override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
  }
  
  public override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
  }
  
  func keyboardWillShowNotification(notification: NSNotification) {
    updateBottomLayoutConstraintWithNotification(notification)
  }
  
  func keyboardWillHideNotification(notification: NSNotification) {
    updateBottomLayoutConstraintWithNotification(notification)
  }
  
  
  // MARK: - Private
  
  func updateBottomLayoutConstraintWithNotification(notification: NSNotification) {
    guard let userInfo = notification.userInfo else { return }
    
    let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
    let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
    let convertedKeyboardEndFrame = view.convertRect(keyboardEndFrame!, fromView: view.window)
    let rawAnimationCurve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)!.unsignedIntValue << 16
    let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
    
    self.modalViewBottomConstraint?.active = false
    self.modalViewBottomConstraint = self.modalView.bottomAnchor.constraintLessThanOrEqualToAnchor(self.view.bottomAnchor, constant: -(CGRectGetMaxY(view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame)) - 8)
    self.modalViewBottomConstraint?.active = true
    
    UIView.animateWithDuration(animationDuration!, delay: 0.0, options: [.BeginFromCurrentState, animationCurve], animations: {
      self.view.layoutIfNeeded()
      }, completion: nil)
  }
  
  public func presentFromViewController(viewController: UIViewController, withCompletionHandler completionHandler: (() -> Void)? = nil) {
    viewController.presentViewController(self, animated: false) {
      self.view.layoutIfNeeded()
      
      // Fade in the background effect view
      UIView.animateWithDuration(0.3) { self.effectView.alpha = 1.0 }
      
      // Update the modalView constraints to fly it in
      UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .CurveEaseIn, animations: { () -> Void in
        self.modalViewTopConstraint?.active = false
        self.modalViewTopConstraint = self.modalView.topAnchor.constraintEqualToAnchor(self.view.layoutMarginsGuide.topAnchor, constant: 30)
        self.modalViewTopConstraint?.active = true
        
        // constrain the modalView to the bottom layout guide
        self.modalViewBottomConstraint = self.modalView.bottomAnchor.constraintLessThanOrEqualToAnchor(self.view.layoutMarginsGuide.bottomAnchor)
        self.modalViewBottomConstraint?.active = true
        
        self.view.layoutIfNeeded()
        }, completion: { done in
          completionHandler?()
      })
    }
  }
  
  public func dismiss() {
    self.view.layoutIfNeeded()
    UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
      () -> Void in
      // Fade out the effect view
      self.effectView.alpha = 0.0
      
      // Fly the modalView out of the frame
      self.modalViewBottomConstraint?.active = false
      self.modalViewTopConstraint?.active = false
      self.modalViewTopConstraint = self.modalView.topAnchor.constraintEqualToAnchor(self.view.bottomAnchor)
      self.modalViewTopConstraint?.active = true
      
      self.view.layoutIfNeeded()
      }) { done in self.dismissViewControllerAnimated(false, completion: nil) }
  }
}

extension YNModalViewController: ContentViewDelegate {
  func dismissButtonTapped(sender: AnyObject) {
    self.dismiss()
  }
}