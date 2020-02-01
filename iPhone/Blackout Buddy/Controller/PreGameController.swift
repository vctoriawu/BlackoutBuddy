//
//  SecondViewController.swift
//  Blackout Buddy
//
//  Created by Victoria Armstrong on 2020-01-31.
//  Copyright © 2020 Victoria Armstrong. All rights reserved.
//
//WHAT IF WE MADE THIS VIEW THE INITIAL STAGE???

import UIKit
import Eureka
import SplitRow

class PreGameController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form
        +++ Section("Travel Time")
            <<< TimeRow(){
                $0.title = "Reminder to leave"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
            <<< TimeRow(){
                $0.title = "Reminder to head home"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
            
        +++ Section("Budget")
            <<< DecimalRow(){
                $0.title = "Drinks"
                $0.placeholder = "$20.00"
                let currencyFormatter = NumberFormatter()
                currencyFormatter.numberStyle = .currency
                $0.formatter = currencyFormatter
            }
            <<< DecimalRow(){
                $0.title = "Food"
                $0.placeholder = "$20.00"
                let currencyFormatter = NumberFormatter()
                currencyFormatter.numberStyle = .currency
                $0.formatter = currencyFormatter
            }
            
        +++ MultivaluedSection(multivaluedOptions: [.Insert, .Delete], header: "Reminders") {
        
            $0.addButtonProvider = { section in
                return ButtonRow(){
                    $0.title = "Add new reminder"
                }
            }
            $0.multivaluedRowToInsertAt = { index in
                return SplitRow<TextRow, TimeRow>() {
                    $0.rowLeftPercentage = 0.5

                    $0.rowLeft = TextRow(){
                        $0.placeholder = "Title"
                    }
                    
                    $0.rowRight = TimeRow(){
                        $0.value = Date(timeIntervalSinceReferenceDate: 0)
                    }

                }
            }
            $0 <<< SplitRow<TextRow, TimeRow>() {
                $0.rowLeftPercentage = 0.5

                $0.rowLeft = TextRow(){
                    $0.placeholder = "Title"
                }
            
                $0.rowRight = TimeRow(){
                    $0.value = Date(timeIntervalSinceReferenceDate: 0)
                }
            }
        }
    }
}
