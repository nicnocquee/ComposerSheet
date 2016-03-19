//
//  DLFComposerViewController.swift
//  ComposerSheet
//
//  Created by Nico Prananta on 6/30/15.
//  Copyright (c) 2015 DelightfulDev. All rights reserved.
//

import Foundation
import UIKit

@objc protocol DLFComposerViewControllerDelegate {
    optional func didTweet(composeViewController: DLFComposerViewController)
}

public class DLFComposerViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: DLFComposerViewControllerDelegate?
    
    let sheetView: UIView
    let cancelButton: UIButton
    let nextButton: UIButton
    let sheetTitle: UILabel
    let charactersLabel: UILabel
    let headerLine: UIView
    let textView: UITextView
    let mediaURLLength = 23
    let maxTweetLength = 140
    var topMargin = 20
    
    var numberOfChars: Int = 0 {
        didSet {
            let remaining = maxTweetLength-mediaURLLength-numberOfChars
            charactersLabel.text = "\(remaining)"
            nextButton.enabled = (remaining >= 0 && numberOfChars > 0)
            charactersLabel.textColor = remaining >= 0 && numberOfChars > 0 ? UIColor(red: 0, green: 0, blue: 0, alpha: 0.2) : UIColor.redColor()
        }
    }
    
    init() {
        sheetView = UIView(frame: CGRectZero)
        cancelButton = UIButton(frame: CGRectZero)
        nextButton = UIButton(frame: CGRectZero)
        sheetTitle = UILabel(frame: CGRectZero)
        headerLine = UIView(frame: CGRectZero)
        charactersLabel = UILabel(frame: CGRectZero)
        textView = UITextView(frame: CGRectZero)
        
        cancelButton.setTitle(NSLocalizedString("Cancel", comment: ""), forState: UIControlState.Normal)
        nextButton.setTitle(NSLocalizedString("Tweet", comment: ""), forState: UIControlState.Normal)
        sheetTitle.text = NSLocalizedString("Twitter", comment: "")
        super.init(nibName: nil, bundle: nil)
    }

    required convenience public init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        sheetView.backgroundColor = UIColor.whiteColor()
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        sheetView.layer.cornerRadius = 8
        self.view.addSubview(sheetView)
        self.view.addConstraints(sheetComposerConstraints() )
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        sheetTitle.translatesAutoresizingMaskIntoConstraints = false
        headerLine.translatesAutoresizingMaskIntoConstraints = false
        
        cancelButton.setTitleColor(self.view.tintColor, forState: UIControlState.Normal)
        cancelButton.titleLabel!.font = UIFont.systemFontOfSize(15)
        cancelButton.setContentHuggingPriority(1000, forAxis: UILayoutConstraintAxis.Horizontal)
        cancelButton.setContentCompressionResistancePriority(1000, forAxis: UILayoutConstraintAxis.Horizontal)
        cancelButton.showsTouchWhenHighlighted = true
        cancelButton.addTarget(self, action: "didTapCancelButton", forControlEvents: UIControlEvents.TouchUpInside)
        cancelButton.sizeToFit()
        
        nextButton.setTitleColor(self.view.tintColor, forState: UIControlState.Normal)
        nextButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Disabled)
        nextButton.setContentHuggingPriority(1000, forAxis: UILayoutConstraintAxis.Horizontal)
        nextButton.setContentCompressionResistancePriority(1000, forAxis: UILayoutConstraintAxis.Horizontal)
        nextButton.addTarget(self, action: "didTapNextButton", forControlEvents: UIControlEvents.TouchUpInside)
        nextButton.showsTouchWhenHighlighted = true
        nextButton.titleLabel!.font = UIFont.boldSystemFontOfSize(15)
        nextButton.sizeToFit()
        
        sheetTitle.font = UIFont.boldSystemFontOfSize(15)
        
        sheetView.addSubview(cancelButton)
        sheetView.addSubview(nextButton)
        sheetView.addSubview(sheetTitle)
        sheetView.addConstraints(sheetComposerTitleConstraints())
        
        headerLine.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        sheetView.addSubview(headerLine)
        sheetView.addConstraints(headerLineConstraints())
        
        charactersLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfChars = 0
        charactersLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        charactersLabel.font = UIFont.systemFontOfSize(12)
        sheetView.addSubview(charactersLabel)
        sheetView.addConstraints(charactersLabelConstraints())
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.font = UIFont.systemFontOfSize(15)
        sheetView.addSubview(textView)
        sheetView.addConstraints(textViewConstraints())
    }
    
    override public func viewDidAppear(animated: Bool) {
        textView.becomeFirstResponder()
        
    }
    
    func sheetComposerConstraints () -> [NSLayoutConstraint]{
        let viewBindings = ["topLayoutGuide": self.topLayoutGuide, "sheet": sheetView]
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[sheet]-30-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewBindings as! [String : AnyObject])
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[topLayoutGuide]-\(topMargin)-[sheet]", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: viewBindings as! [String : AnyObject])
        let heightConstraint = NSLayoutConstraint(item: sheetView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: sheetView, attribute: NSLayoutAttribute.Width, multiplier: 0.6, constant: 0)
        return  verticalConstraints + horizontalConstraints + [heightConstraint]
    }
    
    func sheetComposerTitleConstraints () -> [NSLayoutConstraint] {
        let viewBindings = [
            "sheet": sheetView,
            "cancelButton": cancelButton,
            "nextButton": nextButton,
            "sheetTitle": sheetTitle
        ]
        sheetTitle.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: UILayoutConstraintAxis.Horizontal)
        cancelButton.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: UILayoutConstraintAxis.Horizontal)
        nextButton.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: UILayoutConstraintAxis.Horizontal)
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[cancelButton]->=0-[sheetTitle]->=0-[nextButton]-10-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewBindings)
        let sheetTitleCenterXConstraint = NSLayoutConstraint(item: sheetTitle, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: sheetView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        sheetTitleCenterXConstraint.priority = 1000
        let sheetTitleTopConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-15-[sheetTitle]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewBindings)
        let cancelTitleTopConstraint = NSLayoutConstraint(item: cancelButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: sheetTitle, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        let nextTitleTopConstraint = NSLayoutConstraint(item: nextButton, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: sheetTitle, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        
        return horizontalConstraints + sheetTitleTopConstraints + [sheetTitleCenterXConstraint, cancelTitleTopConstraint, nextTitleTopConstraint]
    }
    
    func headerLineConstraints () -> [NSLayoutConstraint] {
        let viewBindings = ["headerLine": headerLine, "sheetTitle": sheetTitle]
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[headerLine]-0-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewBindings)
        let heightConstraint = NSLayoutConstraint(item: headerLine, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 1)
        let topConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[sheetTitle]-15-[headerLine]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: viewBindings)
        
        return horizontalConstraints + topConstraints + [heightConstraint]
    }
    
    func charactersLabelConstraints () -> [NSLayoutConstraint] {
        let viewBindings = ["charactersLabel": charactersLabel]
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[charactersLabel]-10-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewBindings)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[charactersLabel]-10-|", options: NSLayoutFormatOptions.AlignAllLeading, metrics: nil, views: viewBindings)
        
        return horizontalConstraints + verticalConstraints
    }
    
    func textViewConstraints () -> [NSLayoutConstraint] {
        let viewBindings = ["headerLine": headerLine, "textView": textView, "charactersLabel": charactersLabel]
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[textView]-8-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewBindings)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[headerLine]-0-[textView]-0-[charactersLabel]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: viewBindings)
        
        return horizontalConstraints + verticalConstraints
    }
    
    func didTapNextButton () {
        if numberOfChars > 0 {
            delegate?.didTweet?(self)
        }
    }
    
    func didTapCancelButton () {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let string = textView.text as NSString
        let newText = string.stringByReplacingCharactersInRange(range, withString: text)
        numberOfChars = newText.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        return true
    }
    
    public func textViewDidBeginEditing(textView: UITextView) {
        textView.selectedRange = NSMakeRange(0, 0)
    }
    
}

