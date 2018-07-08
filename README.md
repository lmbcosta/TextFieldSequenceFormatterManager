# TextFieldSequenceFormatterManager
Format textfield input sequentially giving a total of elements and a number of elements per group.

:basketball::soccer::tennis:      -      :basketball::soccer::tennis:      -      :basketball::soccer::tennis:      -      :basketball::soccer::tennis:

[See demo](https://gfycat.com/WellinformedDisgustingBellfrog)

## Requirements
* ARC
* iOS 8.0

### Installation
TextFieldSequenceFormatterManager is is available through [CocoaPods](https://cocoapods.org)<br/>
```ruby
pod 'TextFieldSequenceFormatterManager', :git => "https://github.com/lmbcosta/TextFieldSequenceFormatterManager.git"
```

## Usage
Like other CocoaPods just need the import TextFieldSequenceFormatterManager and you are ready to use it

```swift
import UIKit
import TextFieldSequenceFormatterManager

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var formatterManager: TextFieldSequenceFormatterManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatterManager = TextFieldSequenceFormatterManager()
        
        let entity = TextFieldSequenceFormatterEntity(textField: textField, nElements: 16, nElementsPerGroup: 4, filledSequenceHandler: { textField in textField.backgroundColor = .green }, dischargedSequenceHandler: { textField in textField.backgroundColor = .white}, separator: .space)
        
        formatterManager.setTextField(with: entity)
    }
}
```

## Author
Luís Costa - lmbcosta@hotmail.com<br/>

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/lmbcosta/TextFieldSequenceFormatterManager/blob/master/LICENCE) file for details


