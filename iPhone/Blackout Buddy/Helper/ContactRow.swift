//
//  ContactRow.swift
//  Blackout Buddy
//
//  Created by John David Anthony on 2020-02-01.
//  Copyright © 2020 CornBenders. All rights reserved.
//

import UIKit

import Foundation
import Eureka


public class _ContactRow: Row<ContactCell> {
    required public init(tag: String?){
        super.init(tag: tag)
    }
}


public final class ContactRow: _ContactRow, RowType{

    required public init(tag: String?) {
        super.init(tag: tag)
        self.displayValueFor = nil
    }
}
