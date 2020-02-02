//
//  ContactCell.swift
//  Blackout Buddy
//
//  Created by John David Anthony on 2020-02-01.
//  Copyright © 2020 CornBenders. All rights reserved.
//

import Foundation
import Contacts
import ContactsUI
import Eureka


public class ContactCellOf<T: Equatable>: Cell<T>, CellType, CNContactPickerDelegate {
    required public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    public override func setup(){
        super.setup()
        self.bindContact()
    }


    public override func update() {
        super.update()
        self.bindContact()
    }


    private func bindContact(){
        switch CNContactStore.authorizationStatus(for: .contacts){
        case .authorized: //Update our UI if the user has granted access to their Contacts
            selectionStyle = row.isDisabled ? .none : .default

            if let id = self.row.value as? String, let contact = contactFromIdentifier(identifier: id){
                detailTextLabel?.text = CNContactFormatter.string(from: contact, style: .fullName)
            }

        case .notDetermined: //Prompt the user for access to Contacts if there is no definitive answer
            CNContactStore().requestAccess(for: .contacts) { granted, error in
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        // Run UI Updates
                    }
                    self.row.disabled = Condition.init(booleanLiteral: !granted)
                    self.selectionStyle = self.row.isDisabled ? .none : .default

                    if granted, let id = self.row.value as? String, let contact = self.contactFromIdentifier(identifier: id){
                        self.detailTextLabel?.text = CNContactFormatter.string(from: contact, style: .fullName)
                    }
                }
            }

        case .denied, .restricted:
            self.row.disabled = true
            selectionStyle = row.isDisabled ? .none : .default
        }
    }


    private func contactFromIdentifier(identifier: String) -> CNContact?{
        do{
            return try CNContactStore().unifiedContact(withIdentifier: identifier, keysToFetch: [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)])

        } catch let error as NSError{
            NSLog(error.localizedDescription)
            return nil
        }
    }


    public override func didSelect() {
        super.didSelect()

        let controller = CNContactPickerViewController()
        controller.delegate = self

        self.formViewController()?.present(controller, animated: true, completion: nil)
    }


    public func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
        let name = contact.givenName + " " + contact.familyName
        
        self.row.title = name

        
    }
}
public typealias ContactCell = ContactCellOf<String>
