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
        XCTAssertNotNil(composerController.sheetTitle, "Sheet title should not be nil")
        XCTAssertNotNil(composerController.cancelButton, "Sheet cancel button should not be nil")
        XCTAssertNotNil(composerController.nextButton, "Sheet next button should not be nil")
        XCTAssertNotNil(composerController.charactersLabel, "Sheet characters label should not be nil")
        XCTAssertNotNil(composerController.textView, "Sheet text view should not be nil")
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
        
        NSRunLoop.mainRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 0.4))
        
        XCTAssertNil(viewController.presentedViewController, "Cancel button should dismiss DLFComposeViewController")
    }
    
    func testHeaderLineConstraints () {
        let composerController = DLFComposeViewController()
        let view = composerController.view
        let window = UIApplication.sharedApplication().delegate?.window!
        view.frame = window!.frame
        let constraints = composerController.headerLineConstraints()
        XCTAssertNotNil(constraints, "header line constraints should not be nil")
    }
    
    func testCharactersLabelConstraints () {
        let composerController = DLFComposeViewController()
        let view = composerController.view
        let window = UIApplication.sharedApplication().delegate?.window!
        view.frame = window!.frame
        let constraints = composerController.charactersLabelConstraints()
        XCTAssertNotNil(constraints, "character label constraints should not be nil")
    }
    
    func testTextViewConstraints () {
        let composerController = DLFComposeViewController()
        let view = composerController.view
        let window = UIApplication.sharedApplication().delegate?.window!
        view.frame = window!.frame
        let constraints = composerController.textViewConstraints()
        XCTAssertNotNil(constraints, "text view constraints should not be nil")
    }
    
    func testNextButton () {
        let composerController = DLFComposeViewController()
        let view = composerController.view
        
        class ComposeDelegate: DLFComposeViewControllerDelegate {
            var callback: ((composeViewController: DLFComposeViewController) -> Void)?
            
            @objc func didTweet(composeViewController: DLFComposeViewController) {
                if let call = self.callback {
                    call(composeViewController: composeViewController)
                }
            }
        }
        
        let composeDelegate = ComposeDelegate()
        let expectation = expectationWithDescription("...")
        composeDelegate.callback = {(composerViewController) -> Void in
            XCTAssertTrue(composerViewController === composerController, "next button should call delegate on tap")
            expectation.fulfill()
        }
        composerController.delegate = composeDelegate
        
        composerController.nextButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        
        waitForExpectationsWithTimeout(1) { error in
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
