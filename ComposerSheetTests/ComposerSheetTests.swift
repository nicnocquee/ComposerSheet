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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
