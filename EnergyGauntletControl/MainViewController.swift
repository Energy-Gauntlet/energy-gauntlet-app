//
//  MainViewController.swift
//  EnergyGauntletControl
//
//  Created by Carl Shotwell on 4/11/15.
//  Copyright (c) 2015 Carl Shotwell. All rights reserved.
//

import UIKit

class MainViewController: UIKit.UIViewController, DRDoubleDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DRDouble.sharedDouble().delegate = self
    }
    
    func doubleDidConnect(theDouble: DRDouble!) {
    }
    
    func doubleStatusDidUpdate(theDouble: DRDouble!) {
    }
    
    @IBAction func moveStandUp(sender: AnyObject) {
        DRDouble.sharedDouble().poleUp()
    }
    
    @IBAction func moveStandDown(sender: AnyObject) {
        DRDouble.sharedDouble().poleDown()
    }
}
