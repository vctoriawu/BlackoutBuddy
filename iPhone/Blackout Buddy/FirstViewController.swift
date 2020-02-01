//
//  FirstViewController.swift
//  Blackout Buddy
//
//  Created by Victoria Armstrong on 2020-01-31.
//  Copyright © 2020 Victoria Armstrong. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var lfg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonWasPressed(_ sender: Any) {
        lfg.text = "let's fucking go"
    }
}

