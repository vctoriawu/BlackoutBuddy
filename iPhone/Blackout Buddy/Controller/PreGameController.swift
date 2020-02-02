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
import ContactsUI
import EventKit


class PreGameController: FormViewController, CNContactPickerDelegate {
    let eventStore = EKEventStore()
    var name = ""
    
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
            $0.tag = "Reminders"
        
            $0.addButtonProvider = { section in
                return ButtonRow(){
                    $0.title = "Add new reminder"
                }
            }
            $0.multivaluedRowToInsertAt = { index in
                return SplitRow<TextRow, TimeRow>() {
                    $0.rowLeftPercentage = 0.75

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
            
        
            
        +++ MultivaluedSection(multivaluedOptions: [.Insert, .Delete], header: "Drunk Texting") {
            $0.tag = "drunk"
        
            $0.addButtonProvider = { section in
                return ButtonRow(){
                    $0.title = "Add new Contact"
                }
            }
//            $0.multivaluedRowToInsertAt = { index in
//
//                return ButtonRow(){
//
//                    $0.title = "Select Contact"
//                    $0.onCellSelection(self.buttonTapped(cell:row:))
//                }
//            }
            $0.multivaluedRowToInsertAt = { index in
                
                return ContactRow(){
                    
                    $0.title = "Select Contact"
                    
                }
            }
        }
                
        +++ Section() <<< ButtonRow() { (row: ButtonRow) -> Void in
           row.title = "Let's Go"
           row.onCellSelection(self.submitForm(cell:row:))
        }
        
        
            
            
        
//        +++ Section("Drunk Texting")
//            <<< ButtonRow(){
//                $0.title = "Add New Tag"
//                $0.onCellSelection(self.buttonTapped(cell:row:))
//        }
    }
    
    func buttonTapped(cell: ButtonCellOf<String>, row: ButtonRow) {
        let contacVC = CNContactPickerViewController()
        contacVC.delegate = self
        self.present(contacVC, animated: true, completion: nil)

    }
    
    func submitForm(cell: ButtonCellOf<String>, row: ButtonRow) {
        tabBarController?.selectedIndex = 2
        let formvalues = self.form.values()
        let reminders = formvalues["Reminders"]!! as! [Any?]
//        print(reminders[0]!)
        let data = reminders[0]! as? SplitRowValue<String,Date>
        let title =  data?.left
        let date = data!.right
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss Z"
        
        let formattedDate = dateFormatter.string(from: date!)
        print(formattedDate)
        
        var calendar = Calendar.current

        if let timeZone = TimeZone(identifier: "EST") {
           calendar.timeZone = timeZone
        }

        let hour = calendar.component(.hour, from: date!)
        let minute = calendar.component(.minute, from: date!)

        print("\(hour):\(minute)")

        

        
    eventStore.requestAccess(to: EKEntityType.reminder, completion: {
    granted, error in
    if (granted) && (error == nil) {
        print("granted \(granted)")


        let reminder:EKReminder = EKReminder(eventStore: self.eventStore)
        reminder.title = title
        reminder.priority = 2

        let date = Date()
        var dateComponents = Calendar.current.dateComponents([.month, .year, .day, .hour, .minute, .second], from: date)
        dateComponents.hour = hour
        dateComponents.minute = minute
        let convertedDateTime = Calendar.current.date(from: dateComponents)

        let alarmTime = date
        
        let alarm = EKAlarm(absoluteDate: convertedDateTime!)
      reminder.addAlarm(alarm)

      reminder.calendar = self.eventStore.defaultCalendarForNewReminders()


      do {
        try self.eventStore.save(reminder, commit: true)
      } catch {
        print("Cannot save")
        return
      }
      print("Reminder saved")
      }
     })

        let reminder:EKReminder = EKReminder(eventStore: self.eventStore)
        reminder.title = "Must do this!"
        reminder.priority = 2

        //  How to show completed
        //reminder.completionDate = Date()

        reminder.notes = "...this is a note"


        let alarmTime = Date().addingTimeInterval(1*60*24*3)
        let alarm = EKAlarm(absoluteDate: alarmTime)
        reminder.addAlarm(alarm)
    }

    
      // MARK: Delegate method CNContectPickerDelegate
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        print(contact)
        self.name = contact.givenName + " " + contact.familyName
        
        print(self.name)
        
        
        print(contact.phoneNumbers)
        let numbers = contact.phoneNumbers.first
        print((numbers?.value)?.stringValue ?? "")
    }

    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        self.dismiss(animated: true, completion: nil)
    }

}
