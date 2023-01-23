//
//  Contact.swift
//  UITableView
//
//  Created by Konstantyn Koroban on 16/12/2021.
//

import Foundation
import UIKit

protocol ContactProtocol {
    var title: String { get set }
    var phone: String { get set }
}

struct Contact: ContactProtocol {
    var title: String
    var phone: String
}

