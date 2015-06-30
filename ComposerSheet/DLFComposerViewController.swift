//
//  DLFComposerViewController.swift
//  ComposerSheet
//
//  Created by Nico Prananta on 6/30/15.
//  Copyright (c) 2015 DelightfulDev. All rights reserved.
//

import Foundation
import UIKit

class DLFComposeViewController: UIViewController {
    
    let sheetView: UIView
    let cancelButton: UIButton
    let nextButton: UIButton
    let sheetTitle: UILabel
    
    init() {
        sheetView = UIView(frame: CGRectZero)
        cancelButton = UIButton(frame: CGRectZero)
        nextButton = UIButton(frame: CGRectZero)
        sheetTitle = UILabel(frame: CGRectZero)
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        sheetView.backgroundColor = UIColor.whiteColor()
        sheetView.setTranslatesAutoresizingMaskIntoConstraints(false)
        sheetView.layer.cornerRadius = 8
        self.view.addSubview(sheetView)
        self.view.addConstraints(sheetComposerConstraints())
        
        cancelButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        nextButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        sheetTitle.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        cancelButton.setTitle(NSLocalizedString("Cancel", comment: ""), forState: UIControlState.Normal)
        cancelButton.setTitleColor(self.view.tintColor, forState: UIControlState.Normal)
        cancelButton.titleLabel!.font = UIFont.systemFontOfSize(15)
        cancelButton.setContentHuggingPriority(1000, forAxis: UILayoutConstraintAxis.Horizontal)
        cancelButton.setContentCompressionResistancePriority(1000, forAxis: UILayoutConstraintAxis.Horizontal)
        cancelButton.showsTouchWhenHighlighted = true
        cancelButton.addTarget(self, action: "didTapCancelButton", forControlEvents: UIControlEvents.TouchUpInside)
        cancelButton.sizeToFit()
        
        nextButton.setTitle(NSLocalizedString("Tweet", comment: ""), forState: UIControlState.Normal)
        nextButton.setTitleColor(self.view.tintColor, forState: UIControlState.Normal)
        nextButton.setContentHuggingPriority(1000, forAxis: UILayoutConstraintAxis.Horizontal)
        nextButton.setContentCompressionResistancePriority(1000, forAxis: UILayoutConstraintAxis.Horizontal)
        nextButton.addTarget(self, action: "didTapNextButton", forControlEvents: UIControlEvents.TouchUpInside)
        nextButton.showsTouchWhenHighlighted = true
        nextButton.titleLabel!.font = UIFont.boldSystemFontOfSize(15)
        nextButton.sizeToFit()
        
        sheetTitle.text = NSLocalizedString("Twitter", comment: "")
        sheetTitle.font = UIFont.boldSystemFontOfSize(15)
        
        sheetView.addSubview(cancelButton)
        sheetView.addSubview(nextButton)
        sheetView.addSubview(sheetTitle)
        sheetView.addConstraints(sheetComposerTitleConstraints())
    }
    
    func sheetComposerConstraints () -> [AnyObject]{
        let views: NSMutableDictionary = NSMutableDictionary()
        views.setValue(sheetView, forKey: "sheet")
        views.setValue(self.topLayoutGuide, forKey: "topLayoutGuide")
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[sheet]-30-|", options: nil, metrics: nil, views: views as [NSObject : AnyObject])
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[topLayoutGuide]-20-[sheet]", options: nil, metrics: nil, views: views as [NSObject : AnyObject])
        let heightConstraint = NSLayoutConstraint(item: sheetView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: sheetView, attribute: NSLayoutAttribute.Width, multiplier: 0.6, constant: 0)
        return  verticalConstraints + horizontalConstraints + [heightConstraint]
    }
    
    func sheetComposerTitleConstraints () -> [AnyObject] {
        let views: NSMutableDictionary = NSMutableDictionary()
        views.setValue(sheetView, forKey: "sheet")
        views.setValue(cancelButton, forKey: "cancelButton")
        views.setValue(nextButton, forKey: "nextButton")
        views.setValue(sheetTitle, forKey: "sheetTitle")
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[cancelButton]->=0-[sheetTitle]->=0-[nextButton]-10-|", options: nil, metrics: nil, views: views as [NSObject : AnyObject])
        let sheetTitleCenterXConstraint = NSLayoutConstraint(item: sheetTitle, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: sheetView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        sheetTitleCenterXConstraint.priority = 1000
        let sheetTitleTopConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-15-[sheetTitle]", options: nil, metrics: nil, views: views as [NSObject : AnyObject])
        let cancelTitleTopConstraint = NSLayoutConstraint(item: cancelButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: sheetTitle, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        let nextTitleTopConstraint = NSLayoutConstraint(item: nextButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: sheetTitle, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        
        return horizontalConstraints + sheetTitleTopConstraints + [sheetTitleCenterXConstraint, cancelTitleTopConstraint, nextTitleTopConstraint]
    }
    
    func didTapNextButton () {
        
    }
    
    func didTapCancelButton () {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

