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
  var modalViewCenterYConstraint: NSLayoutConstraint?
  
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
    
    self.view.addSubview(self.modalView)
    if let size = self.modalViewSize {
      self.modalView.heightAnchor.constraintEqualToConstant(size.height).active = true
      self.modalView.widthAnchor.constraintEqualToConstant(size.width).active = true
    } else {
      self.modalView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, constant: -60).active = true
      self.modalView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, constant: -30).active = true
    }
    self.modalView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
    self.modalViewTopConstraint = self.modalView.topAnchor.constraintEqualToAnchor(self.view.bottomAnchor)
    self.modalViewTopConstraint?.active = true
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