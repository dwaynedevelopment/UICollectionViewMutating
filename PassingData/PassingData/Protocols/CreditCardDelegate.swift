//
//  CreditCardDelegate.swift
//  PassingData
//
//  Created by codenroot on 3/14/19.
//  Copyright © 2019 codenroot. All rights reserved.
//

import Foundation

protocol CreditCardDelegate: class {
    func deleteCreditCard(card: CreditCard)
    func editCreditCard(card: CreditCard, mutated: CreditCard)
}
