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

        //Initialize a revealing Splash with with the iconImage, the initial size and the background color
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "Pink Cocktail Bar Logo-1024")!,iconInitialSize: CGSize(width: 70, height: 70), backgroundColor: UIColor(red: 0.2667, green: 0.8275, blue: 0.1686, alpha: 1.0))

        //Adds the revealing splash view as a sub view
        self.view.addSubview(revealingSplashView)

        //Starts animation
        revealingSplashView.startAnimation(){
            print("Completed")
        }

    }

    @IBAction func buttonWasPressed(_ sender: Any) {
        lfg.text = "let's fucking go"
    }
}

