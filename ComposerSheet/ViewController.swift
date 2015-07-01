//
//  ViewController.swift
//  ComposerSheet
//
//  Created by Nico Prananta on 6/30/15.
//  Copyright (c) 2015 DelightfulDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DLFComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapButton(sender: AnyObject) {
        let composer = DLFComposeViewController()
        composer.delegate = self
        composer.topMargin = 40
        composer.modalPresentationStyle = UIModalPresentationStyle.Custom
        self.presentViewController(composer, animated: true, completion: nil)
        
    }
    
    func didTweet(composeViewController: DLFComposeViewController) {
        println("did tweet")
    }

}

