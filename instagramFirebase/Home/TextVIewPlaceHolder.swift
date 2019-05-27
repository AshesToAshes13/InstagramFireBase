//
//  TextVIewPlaceHolder.swift
//  instagramFirebase
//
//  Created by Егор Бамбуров on 03.08.2018.
//  Copyright © 2018 Егор Бамбуров. All rights reserved.
//

import UIKit

class TextVIewPlaceHolder: NSObject, UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "placeholder text here...")
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "placeholder text here..."
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}
