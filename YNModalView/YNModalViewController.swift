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
    effectView.effect = UIBlurEffect(style: .light)
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
    
    self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    
    if let contentView = self.modalView as? ContentView {
      contentView.delegate = self
    }
  }
  
  required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .clear()
    
    // constrain the vibrancy view
    self.view.addSubview(self.effectView)
    self.effectView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    self.effectView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    self.effectView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    self.effectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    
    let heightAnchor: NSLayoutConstraint
    self.view.addSubview(self.modalView)
    if let size = self.modalViewSize {
      heightAnchor = self.modalView.heightAnchor.constraint(equalToConstant: size.height)
      self.modalView.widthAnchor.constraint(equalToConstant: size.width).isActive = true
    } else {
      heightAnchor = self.modalView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: -60)
      self.modalView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -30).isActive = true
    }
    heightAnchor.priority = 750
    heightAnchor.isActive = true
    
    self.modalView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    self.modalViewTopConstraint = self.modalView.topAnchor.constraint(equalTo: self.view.bottomAnchor)
    self.modalViewTopConstraint?.isActive = true
  }
  
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(self, selector: #selector(YNModalViewController.keyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(YNModalViewController.keyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  public override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  func keyboardWillShowNotification(_ notification: Notification) {
    updateBottomLayoutConstraintWithNotification(notification)
  }
  
  func keyboardWillHideNotification(_ notification: Notification) {
    updateBottomLayoutConstraintWithNotification(notification)
  }
  
  
  // MARK: - Private
  
  func updateBottomLayoutConstraintWithNotification(_ notification: Notification) {
    guard let userInfo = (notification as NSNotification).userInfo else { return }
    
    let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
    let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue()
    let convertedKeyboardEndFrame = view.convert(keyboardEndFrame!, from: view.window)
    let rawAnimationCurve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)!.uint32Value << 16
    let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
    
    let keyboardOffset = -(view.bounds.maxY - convertedKeyboardEndFrame.minY) - 8
    self.modalViewBottomConstraint?.isActive = false
    self.modalViewBottomConstraint = self.modalView.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor, constant: keyboardOffset)
    self.modalViewBottomConstraint?.isActive = true
    
    UIView.animate(withDuration: animationDuration!, delay: 0.0, options: [.beginFromCurrentState, animationCurve], animations: {
      self.view.layoutIfNeeded()
      }, completion: nil)
  }
  
  public func presentFromViewController(_ viewController: UIViewController, withCompletionHandler completionHandler: (() -> Void)? = nil) {
    viewController.present(self, animated: false) {
      self.view.layoutIfNeeded()
      
      // Fade in the background effect view
      UIView.animate(withDuration: 0.3) { self.effectView.alpha = 1.0 }
      
      // Update the modalView constraints to fly it in
      UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: { () -> Void in
        self.modalViewTopConstraint?.isActive = false
        self.modalViewTopConstraint = self.modalView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30)
        self.modalViewTopConstraint?.isActive = true
        
        // constrain the modalView to the bottom layout guide
        self.modalViewBottomConstraint = self.modalView.bottomAnchor.constraint(lessThanOrEqualTo: self.view.layoutMarginsGuide.bottomAnchor)
        self.modalViewBottomConstraint?.isActive = true
        
        self.view.layoutIfNeeded()
        }, completion: { done in
          completionHandler?()
      })
    }
  }
  
  public func dismiss() {
    self.view.layoutIfNeeded()
    UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
      () -> Void in
      // Fade out the effect view
      self.effectView.alpha = 0.0
      
      // Fly the modalView out of the frame
      self.modalViewBottomConstraint?.isActive = false
      self.modalViewTopConstraint?.isActive = false
      self.modalViewTopConstraint = self.modalView.topAnchor.constraint(equalTo: self.view.bottomAnchor)
      self.modalViewTopConstraint?.isActive = true
      
      self.view.layoutIfNeeded()
      }) { done in self.dismiss(animated: false, completion: nil) }
  }
}

extension YNModalViewController: ContentViewDelegate {
  func dismissButtonTapped(_ sender: AnyObject) {
    self.dismiss()
  }
}
