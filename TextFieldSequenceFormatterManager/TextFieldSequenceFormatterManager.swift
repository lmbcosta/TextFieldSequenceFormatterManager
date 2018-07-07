//
//  TextFieldSequenceFormatterManager.swift
//  TextFieldSequenceFormatterManager
//
//  Created by Luis  Costa on 07/07/18.
//  Copyright © 2018 Luis  Costa. All rights reserved.
//

import UIKit

@objc public protocol TextFieldSequenceFormatterManagerDelegate: class {
    func textFieldSequenceFormatterManager(_ textFieldSequenceFormatterManager: TextFieldSequenceFormatterManager, didCompletedFillWith text: String?)
    
    @objc optional func willDischargeTextFieldText(_ textFieldSequenceFormatterManager: TextFieldSequenceFormatterManager)
}

public class TextFieldSequenceFormatterManager: NSObject {
    
    // MARK: - Private Properties
    fileprivate let nElements: Int
    fileprivate let nElementsPerGroup: Int
    fileprivate lazy var indexes: [Int] = self.calculateIndexes()
    fileprivate let nGroups: Int
    fileprivate var total: Int
    
    // MARK: TextFieldSequenceFormatterManagerDelegate
    public weak var delegate: TextFieldSequenceFormatterManagerDelegate?
    
    // MARK: Public properties
    public var separator: Seperator = .space
    
    public init(nElements: Int, nElementsPerGroup: Int) {
        self.nElements = nElements
        self.nElementsPerGroup = nElementsPerGroup
        self.nGroups = Int((Double(self.nElements) / Double(self.nElementsPerGroup)).rounded(.toNearestOrAwayFromZero))
        self.total = self.nElements + nGroups - 1
        
        super.init()
    }
}

// MARK: Seperator Types
extension TextFieldSequenceFormatterManager {
    public enum Seperator: String {
        case slash = "/"
        case dash = "-"
        case space = " "
        case backslash = "\\"
    }
}

// MARK: - Private Functions
extension TextFieldSequenceFormatterManager {
    fileprivate func calculateIndexes() -> [Int] {
        var spacesArray = [Int]()
        
        var i = Int(self.nElementsPerGroup)
        while i < total {
            spacesArray.append(i)
            i += Int(nElementsPerGroup) + 1
        }
        
        return spacesArray
    }
}

// MARK: UITextFieldDelegate
extension TextFieldSequenceFormatterManager: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if range.location == total { return false }
        
        if range.location == total - 1 {
            if range.length == 0 {
                delegate?.textFieldSequenceFormatterManager(self, didCompletedFillWith: textField.text)
            }
            else {
                delegate?.willDischargeTextFieldText?(self)
            }
            
            return true
        }
        
        if indexes.contains(range.location) && range.length == 0 {
            let newText = (textField.text ?? "") + separator.rawValue
            textField.text = newText
        }
        
        return true
    }
}
