//
//  GrootCompleteTextField.swift
//  Demo
//
//  Created by AnhDN on 5/5/17.
//  Copyright © 2017 AnhDN. All rights reserved.
//

import Foundation
import UIKit


public enum CompleteType{
    case Word
    case Sentence
}

@IBDesignable public class GrootCompleteTextField: UITextField
{
    // MARK: - public properties
    
    // left/right padding
    @IBInspectable public var padding : CGFloat = 0
    
    // the color of the suggestion. Matches the default placeholder color
    @IBInspectable public var completionColor : UIColor = UIColor(white: 0, alpha: 0.22)
    
    // Array of suggestions
    public var suggestions : [String] = [""]
    
    // The current suggestion shown. Can also be used to force a suggestion
    public var suggestionWord : String? {
        didSet {
            if let val = suggestionWord {
                setLabelContent(text: val)
            }
        }
    }
    
    // Move the suggestion label up or down. Sometimes there's a small difference, and this can be used to fix it.
    public var pixelCorrection : CGFloat = 0
    
    // Update the suggestion when the text is changed using 'field.text'
    override public var text : String? {
        didSet {
            if let text = text {
                self.setLabelContent(text: text)
            }
        }
    }
    
    // The type of autocomplete that should be used
    public var autocompleteType : CompleteType = .Sentence
    
    
    // MARK: - private properties
    
    // the suggestion label
    private var label = UILabel()
    
    
    // MARK: - init functions
    
    override public init(frame: CGRect)
    {
        super.init(frame: frame)
        
        createNotification()
        setupLabel()
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        createNotification()
        setupLabel()
    }
    
    /**
     Create an instance of a AutocompleteField.
     - parameter
     frame: The fields frame
     suggestion: Array of autocomplete strings
     */
    public init(frame: CGRect, suggestions: [String])
    {
        super.init(frame: frame)
        
        self.suggestions = suggestions
        createNotification()
        setupLabel()
    }
    
    
    // ovverride to set frame of the suggestion label whenever the textfield frame changes.
    public override func layoutSubviews()
    {
        self.label.frame = CGRect(x: self.padding, y: self.pixelCorrection,width: self.frame.width - (self.padding * 2),height: self.frame.height)
        super.layoutSubviews()
    }
    
    // MARK: - public methods
    public func currentSuggestion() -> NSString?
    {
        return self.suggestionWord as NSString?
        
    }
    
    
    // MARK: - private methods
    
    /**
     Create a notification whenever the text of the field changes.
     */
    private func createNotification()
    {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.textChanged(notification:)),
            name: NSNotification.Name.UITextFieldTextDidChange,
            object: self)
    }
    
    /**
     Sets up the suggestion label with the same font styling and alignment as the textfield.
     */
    private func setupLabel()
    {
        setLabelContent()
        
        self.label.lineBreakMode = .byClipping
        
        // If the textfie
        //ld has one of the default styles, we nee
        //d to create some padding
        // otherwise there will be a offset in x-led.
        switch self.borderStyle
        {
        case .roundedRect, .bezel, .line:
            self.padding = 8
            break;
        default:
            break;
        }
        
        self.addSubview(self.label)
    }
    
    
    /**
     Set content of the suggestion label.
     - parameter text: Suggestion text
     */
    private func setLabelContent( text : String = "")
    {
        // label string
        var text = text
        if(text.characters.count < 1) {
            label.attributedText = nil
            return
        }
        
        // only return first word if in word mode
        if(self.autocompleteType == .Word)
        {
            let words = self.text!.components(separatedBy: " ")
            let suggestionWords = text.components(separatedBy: " ")
            
            var string : String = ""
            
            for index in 0..<words.count{
                string = string.appending(suggestionWords[index]) + " "
            }
            
            
            text = string
        }
        
        // create an attributed string instead of the regular one.
        // In this way we can hide the letters in the suggestion that the user has already written.
        let attributedString = NSMutableAttributedString(
            string: text,
            attributes: [
                NSFontAttributeName:UIFont(
                    name: self.font!.fontName,
                    size: self.font!.pointSize
                    )!,
                NSForegroundColorAttributeName: self.completionColor
            ]
        )
        
        // Hide the letters that are under the fields text.
        // If the suggestion is abcdefgh and the user has written abcd
        // we want to hide those letters from the suggestion.
        if let inputText = self.text
        {
            attributedString.addAttribute(NSForegroundColorAttributeName,
                                          value: UIColor.clear,
                                          range: NSRange(location:0, length:inputText.characters.count)
            )
        }
        
        label.attributedText = attributedString
        label.textAlignment = self.textAlignment
    }
    
    /**
     Scans through the suggestions array and finds a suggestion that
     matches the searchTerm.
     - parameter searchTerm: What to search for
     - returns A string or nil
     */
    private func suggestionToShow(searchTerm : String) -> String
    {
        var returnString = ""
        for suggestion in self.suggestions
        {
            // Search the suggestion array. User lowercase on both to get a match.
            // Also, if the match is exact we move on.
            if( (suggestion != searchTerm) && suggestion.lowercased().hasPrefix(searchTerm.lowercased()))
            {
                var suggestionToReturn = searchTerm
                //suggestionToReturn = suggestionToReturn + suggestion.substringWithRange(Range<String.Index>(start: suggestion.startIndex.advancedBy(searchTerm.characters.count), end: suggestion.endIndex))
                let start = suggestion.index(suggestion.startIndex, offsetBy: searchTerm.characters.count)
                let end = suggestion.endIndex
                let range = start..<end
                suggestionToReturn = suggestionToReturn + suggestion.substring(with: range)
                
                returnString = suggestionToReturn
                break
            }
        }
        self.suggestionWord = returnString
        
        return returnString
    }
    
    
    // MARK: - Events
    
    /**
     Triggered whenever the field text changes.
     - parameter notification: The NSNotifcation attached to the event
     */
    func textChanged(notification: NSNotification)
    {
        
        if(self.text == ""){
            setLabelContent(text: "")
        }else{
            let suggestion = suggestionToShow(searchTerm: self.text!)
            //print("suggestion" + suggestion)
            setLabelContent(text: suggestion)
        }
        
    }
    
    // ovverride to set padding
    public override func textRect(forBounds bounds: CGRect) -> CGRect
    {
        return CGRect(x: bounds.origin.x + self.padding,y: bounds.origin.y,
                      width: bounds.size.width - (self.padding * 2),height: bounds.size.height);
    }
    
    // ovverride to set padding
    public override func editingRect(forBounds bounds: CGRect) -> CGRect
    {
        return self.textRect(forBounds: bounds)
    }
    
    // ovverride to set padding on placeholder
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect
    {
        
        
        return self.textRect(forBounds: bounds)
    }
    
    // remove observer on deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
