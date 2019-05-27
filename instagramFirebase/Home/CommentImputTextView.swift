//
//  CommentImputTextView.swift
//  instagramFirebase
//
//  Created by Егор Бамбуров on 03.08.2018.
//  Copyright © 2018 Егор Бамбуров. All rights reserved.
//

import UIKit

class CommentImputTextView: UITextView {
    
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите комментарий"
        label.textColor = UIColor.lightGray
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: .UITextViewTextDidChange, object: nil)
        addSubview(placeHolderLabel)
        placeHolderLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc func handleTextChange() {
        placeHolderLabel.isHidden = !self.text.isEmpty
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
