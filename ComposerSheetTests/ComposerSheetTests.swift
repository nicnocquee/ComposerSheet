//
//  ComposerSheetTests.swift
//  ComposerSheetTests
//
//  Created by Nico Prananta on 6/30/15.
//  Copyright (c) 2015 DelightfulDev. All rights reserved.
//

import UIKit
import XCTest

class ComposerSheetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit() {
        // This is an example of a functional test case.
        let composerController = DLFComposeViewController()
        XCTAssertNotNil(composerController.sheetView, "Sheet view should not be nil")
        XCTAssertTrue(CGPointEqualToPoint(composerController.sheetView.frame.origin, CGPointZero), "Initialized sheet view should contain point zero")
        XCTAssertTrue(composerController.sheetView.frame.width == 0, "Initialized sheet view width should be zero")
    }
    
    func testSheetComposetConstraints () {
        let composerController = DLFComposeViewController()
        let view = composerController.view
        let window = UIApplication.sharedApplication().delegate?.window!
        view.frame = window!.frame
        let constraints = composerController.sheetComposerConstraints()
        XCTAssertNotNil(constraints, "Constraints should not be nil")
        view.setNeedsLayout()
        view.layoutIfNeeded()
        XCTAssertFalse(CGRectEqualToRect(CGRectZero, composerController.sheetView.frame), "Sheet composer controller view should not be zero rect")
    }
    
    func testSheetComposerTitleConstraints () {
        let composerController = DLFComposeViewController()
        let view = composerController.view
        let window = UIApplication.sharedApplication().delegate?.window!
        view.frame = window!.frame
        let constraints = composerController.sheetComposerTitleConstraints()
        XCTAssertNotNil(constraints, "Constraints should not be nil")
        view.setNeedsLayout()
        view.layoutIfNeeded()
        XCTAssertFalse(CGRectEqualToRect(CGRectZero, composerController.cancelButton.frame), "Sheet composer controller cancelButton should not be zero rect")
        XCTAssertFalse(CGRectEqualToRect(CGRectZero, composerController.nextButton.frame), "Sheet composer controller nextButton should not be zero rect")
        XCTAssertFalse(CGRectEqualToRect(CGRectZero, composerController.sheetTitle.frame), "Sheet composer controller sheetTitle should not be zero rect")
        XCTAssertTrue(composerController.sheetTitle.center.y == composerController.cancelButton.center.y, "Cancel button and Title button should be same vertical center")
        XCTAssertTrue(composerController.sheetTitle.center.y == composerController.nextButton.center.y, "Cancel button and Title button should be same vertical center")
    }
    
    func testCancelButton () {
        let window = UIWindow(frame: CGRectZero)
        window.makeKeyAndVisible()
        let composerController = DLFComposeViewController()
        let viewController = UIViewController()
        window.rootViewController = viewController
        viewController.presentViewController(composerController, animated: false, completion: nil)
        XCTAssertTrue(composerController.respondsToSelector("didTapCancelButton"), "didTapCancelButton ")
        let actions = composerController.cancelButton.actionsForTarget(composerController, forControlEvent: UIControlEvents.TouchUpInside)
        XCTAssertTrue(actions?.count == 1, "Cancel button should have one action for touch up inside")
        let touchUpInside: AnyObject? = actions?.first
        XCTAssertEqual(touchUpInside as! String, "didTapCancelButton", "Cancel touch up inside action should be didTapCancelButton")
        composerController.cancelButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        
        NSRunLoop.mainRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 0.01))
        
        XCTAssertNil(viewController.presentedViewController, "Cancel button should dismiss DLFComposeViewController")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
