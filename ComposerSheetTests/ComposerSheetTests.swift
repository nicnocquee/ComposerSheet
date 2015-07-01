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
        let composerController = DLFComposerViewController()
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
        let composerController = DLFComposerViewController()
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
        let composerController = DLFComposerViewController()
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
        let composerController = DLFComposerViewController()
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
        
        XCTAssertNil(viewController.presentedViewController, "Cancel button should dismiss DLFComposerViewController")
    }
    
    func testHeaderLineConstraints () {
        let composerController = DLFComposerViewController()
        let view = composerController.view
        let window = UIApplication.sharedApplication().delegate?.window!
        view.frame = window!.frame
        let constraints = composerController.headerLineConstraints()
        XCTAssertNotNil(constraints, "header line constraints should not be nil")
    }
    
    func testCharactersLabelConstraints () {
        let composerController = DLFComposerViewController()
        let view = composerController.view
        let window = UIApplication.sharedApplication().delegate?.window!
        view.frame = window!.frame
        let constraints = composerController.charactersLabelConstraints()
        XCTAssertNotNil(constraints, "character label constraints should not be nil")
    }
    
    func testTextViewConstraints () {
        let composerController = DLFComposerViewController()
        let view = composerController.view
        let window = UIApplication.sharedApplication().delegate?.window!
        view.frame = window!.frame
        let constraints = composerController.textViewConstraints()
        XCTAssertNotNil(constraints, "text view constraints should not be nil")
    }
    
    func testNextButton () {
        let composerController = DLFComposerViewController()
        let view = composerController.view
        
        class ComposeDelegate: DLFComposerViewControllerDelegate {
            var counter = 0
            
            @objc func didTweet(composeViewController: DLFComposerViewController) {
                ++counter
            }
        }
        
        let composeDelegate = ComposeDelegate()
        composerController.delegate = composeDelegate
        composerController.nextButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        XCTAssertTrue(composeDelegate.counter == 0, "delegate should not be called on tapping next when there are no characters")
        composerController.numberOfChars = 1
        composerController.nextButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        XCTAssertTrue(composeDelegate.counter != 0, "delegate should be called on tapping next")
    }
    
    func testCharactersTooMany () {
        let composerController = DLFComposerViewController()
        let view = composerController.view
        
        composerController.textView.text = "we're all stories, in the end. Just make it a good one, eh? Because it was, you know, it was the best: a daft old man, who stole a magic box and ran away. Did I ever tell you I stole it? Well, I borrowed it; I was always going to take it back. Oh, that box, Amy, you'll dream about that box. It'll never leave you. Big and little at the same time, brand-new and ancient, and the bluest blue, ever."
        composerController.numberOfChars = count(composerController.textView.text)
        XCTAssertFalse(composerController.nextButton.enabled, "Next button should be disabled when character + media url is more than 140")
        XCTAssertTrue(composerController.charactersLabel.textColor.isEqual(UIColor.redColor()), "Character label should be red when more than 140 characters")
    }
    
    func testTextViewDelegate () {
        let composerController = DLFComposerViewController()
        let view = composerController.view
        
        XCTAssertTrue(composerController.textView.delegate === composerController, "Text view should have delegate")
        XCTAssertTrue(composerController.numberOfChars == 0, "Initial number of chars should be zero")
        
        composerController.textView.text = ""
        composerController.textView(composerController.textView, shouldChangeTextInRange: NSMakeRange(0, 0), replacementText: "a")
        XCTAssertTrue(composerController.numberOfChars == 1, "numberOfChars should be updated when text view delegate is called")
        XCTAssertTrue(composerController.charactersLabel.text == "116", "when numberOfChars is updated charactersLabel text should be updated too")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
