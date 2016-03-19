//
//  ViewController.swift
//  ComposerSheet
//
//  Created by Nico Prananta on 6/30/15.
//  Copyright (c) 2015 DelightfulDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DLFComposerViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapButton(sender: AnyObject) {
        let composer = DLFComposerViewController()
        composer.delegate = self
        composer.topMargin = 40
        composer.textView.text = " via @lovely_app"
        composer.modalPresentationStyle = UIModalPresentationStyle.Custom
        self.presentViewController(composer, animated: true, completion: nil)
        
    }
    
    func didTweet(composeViewController: DLFComposerViewController) {
        print("did tweet")
    }

}

