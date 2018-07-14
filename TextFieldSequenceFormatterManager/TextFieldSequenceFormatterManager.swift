//
//  TextFieldSequenceFormatterManager.swift
//  TextFieldSequenceFormatterManager
//
//  Created by Luis  Costa on 07/07/18.
//  Copyright © 2018 Luis  Costa. All rights reserved.
//

import UIKit

public class TextFieldSequenceFormatterManager: NSObject {
    
    public typealias TextFieldHandler = (UITextField) -> Void
    
    // MARK: - Private Properties
    fileprivate var dictionary = [UITextField: TextFieldSequenceFormatterInternalModel]()
    
    // MARK: Public properties
    public var separator: Seperator = .space
    public var filledSequenceHandler: TextFieldHandler?
    public var dischargedSequenceHandler: TextFieldHandler?
    
}

// MARK: Seperator Types
public extension TextFieldSequenceFormatterManager {
    public enum Seperator: String {
        case slash = "/"
        case dash = "-"
        case space = " "
        case backslash = "\\"
    }
}

// MARK: - Private Functions
fileprivate extension TextFieldSequenceFormatterManager {
    func calculateIndexes(nElementsPerGroup: Int, total: Int) -> [Int] {
        var spacesArray = [Int]()
        
        var i = nElementsPerGroup
        while i < total {
            spacesArray.append(i)
            i += nElementsPerGroup + 1
        }
        
        return spacesArray
    }
}

// MARK: - Private Structs
fileprivate extension TextFieldSequenceFormatterManager {
    struct TextFieldSequenceFormatterInternalModel {
        let nElements: Int
        let nElementsPerGroup: Int
        let filledSequenceHandler: TextFieldHandler?
        let dischargedSequenceHandler: TextFieldHandler?
        let didEndEditingHandler: TextFieldHandler?
        let separator: Seperator
    }
}

// MARK: UITextFieldDelegate
extension TextFieldSequenceFormatterManager: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let value = dictionary[textField] else { return false }
        
        let nGroups = Int((Double(value.nElements) / Double(value.nElementsPerGroup)).rounded(.toNearestOrAwayFromZero))
        let total = value.nElements + nGroups - 1
        let indexes = calculateIndexes(nElementsPerGroup: value.nElementsPerGroup, total: total)
        
        if range.location == total { return false }
        
        if range.location == total - 1 {
            if range.length == 0 {
                value.filledSequenceHandler?(textField)
            }
            else {
                value.dischargedSequenceHandler?(textField)
            }
            
            return true
        }
        
        if indexes.contains(range.location) && range.length == 0 {
            let newText = (textField.text ?? "") + value.separator.rawValue
            textField.text = newText
        }
        
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = dictionary[textField] else { return }
        
        value.didEndEditingHandler?(textField)
    }
}

// MARK: - Public Functions
extension TextFieldSequenceFormatterManager {
    public func setTextField(with entity: TextFieldSequenceFormatterEntity) {
        entity.textField.delegate = self
        let value = TextFieldSequenceFormatterInternalModel(nElements: entity.nElements, nElementsPerGroup: entity.nElementsPerGroup, filledSequenceHandler: entity.filledSequenceHandler, dischargedSequenceHandler: entity.dischargedSequenceHandler, didEndEditingHandler: entity.didEndEditingHandler, separator: entity.separator)
        dictionary[entity.textField] = value
    }
}

// MARK: - TextFieldSequenceFormatterEntity
public class TextFieldSequenceFormatterEntity {
    init(textField: UITextField, nElements: Int, nElementsPerGroup: Int, filledSequenceHandler: TextFieldSequenceFormatterManager.TextFieldHandler?, dischargedSequenceHandler: TextFieldSequenceFormatterManager.TextFieldHandler?, didEndEditingHandler: TextFieldSequenceFormatterManager.TextFieldHandler?, separator: TextFieldSequenceFormatterManager.Seperator) {
        self.textField = textField
        self.nElements = nElements
        self.nElementsPerGroup = nElementsPerGroup
        self.filledSequenceHandler = filledSequenceHandler
        self.dischargedSequenceHandler = dischargedSequenceHandler
        self.didEndEditingHandler = didEndEditingHandler
        self.separator = separator
    }
    
    let textField: UITextField
    let nElements: Int
    let nElementsPerGroup: Int
    let filledSequenceHandler: TextFieldSequenceFormatterManager.TextFieldHandler?
    let dischargedSequenceHandler: TextFieldSequenceFormatterManager.TextFieldHandler?
    let didEndEditingHandler: TextFieldSequenceFormatterManager.TextFieldHandler?
    let separator: TextFieldSequenceFormatterManager.Seperator
}
