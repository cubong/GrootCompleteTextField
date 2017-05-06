# GrootCompleteTextField

*Base on [AutocompleteField](https://github.com/filipstefansson/AutocompleteField)*


![Baby Groot](https://images.moviepilot.com/images/c_limit,q_auto:good,w_600/yumrfneyjfepdytstiev/baby-groot-by-dariusartshed.jpg)

Auto-complete words for your UITextField

  - Auto-complete when typing in UITextField
  - Custom completion text color
  - Completion by Word or by Sentence


## Installation
### CocoaPods(updating)

```
platform :ios, '8.0'
pod "GrootCompleteTextField", "~> 1.0" 
```

### Manual installation
Add GrootCompleteTextField.swift into your project.



## Usage
**Storyboard**

Add a UITextField in your Storyboard, and then giving it the GrootCompleteTextField subclass.

**Code**
```
import GrootCompleteTextField

let textField = GrootCompleteTextField(frame: CGRectMake(10, 10, 200, 40), suggestions: ["Mesut Özil","Alexis Sánchez","Laurent Koscielny","Aaron Ramsey"]
view.addSubview(textField)
```
License
----

GrootCompleteTextFeild is released under the [MIT license](https://github.com/cubong/GrootCompleteTextFeild/blob/master/LICENSE)
