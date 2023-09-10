//
//  HelpAndSupportVM.swift
//  TravioApp
//
//  Created by Elif Poyraz on 9.09.2023.
//

import Foundation

protocol SendDataDelegate {
    func sendDatatoVC(titleArr:[String])
}

class HelpAndSupportVM{
    
    
    var delegate: SendDataDelegate?
    
    init() {
        delegate?.sendDatatoVC(titleArr: labelTitlesEachRows)
    }
    
    let labelTitlesEachRows = [
    "How can I create a new account on Travio?",
    "How can I save a visit?",
    "How does Travio work?",
    "How does Travio work?",
    "How does Travio work?",
    "How does Travio work?",
    "How does Travio work?"
    ]
}
