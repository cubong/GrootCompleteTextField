//
//  ViewController.swift
//  Demo
//
//  Created by AnhDN on 5/5/17.
//  Copyright © 2017 AnhDN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var grootCompleteTextField: GrootCompleteTextField!
    
    let players = ["Mesut Özil","Alexis Sánchez","Laurent Koscielny","Aaron Ramsey","Theo Walcott","Petr Čech", "Danny Welbeck"]

    override func viewDidLoad() {
        super.viewDidLoad()
        //UITextField Delegate
        grootCompleteTextField.delegate = self
        
        //Set suggestions for textfield
        grootCompleteTextField.suggestions = players
        
        //Set autocomplete type, default is Sentence
        grootCompleteTextField.autocompleteType = .Sentence
        
        //Set completion color
        grootCompleteTextField.completionColor = UIColor.cyan
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        grootCompleteTextField.text = grootCompleteTextField.suggestionWord
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

