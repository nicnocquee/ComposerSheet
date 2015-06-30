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
    
    init() {
        sheetView = UIView(frame: CGRectZero)
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
        self.view.addSubview(sheetView)
        self.view.addConstraints(sheetComposerConstraints())
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

