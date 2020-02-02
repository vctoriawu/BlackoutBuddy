//
//  FourthViewController.swift
//  Blackout Buddy
//
//  Created by Victoria Armstrong on 2020-02-01.
//  Copyright © 2020 Victoria Armstrong. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {

    @IBOutlet weak var goodToDriveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goodToDriveButton.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goodToDriveButtonPressed(_ sender: Any) {
        // Create the alert controller
        let alertController = UIAlertController(title: "No, you're not good to drive", message: "Order an Uber or something Dummy", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
    }
        let cancelAction = UIAlertAction(title: "OK but in red", style: UIAlertAction.Style.destructive) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
