//
//  ViewController.swift
//  ComposerSheet
//
//  Created by Nico Prananta on 6/30/15.
//  Copyright (c) 2015 DelightfulDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        let navigation = UINavigationController(rootViewController: composer)
        navigation.modalPresentationStyle = UIModalPresentationStyle.Custom
        self.presentViewController(navigation, animated: true, completion: nil)
        
    }

}

