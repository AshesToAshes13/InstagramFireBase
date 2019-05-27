//
//  CommentInputAccessoryView.swift
//  instagramFirebase
//
//  Created by Егор Бамбуров on 03.08.2018.
//  Copyright © 2018 Егор Бамбуров. All rights reserved.
//

import UIKit

protocol CommentInputAccessoryViewDelegate {
    func didSubmit(for comment: String)
}

class CommentInputAccessoryView: UIView {
    
    var delegate: CommentInputAccessoryViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = .flexibleHeight
        backgroundColor = .white
        
        addSubview(sendButton)
        addSubview(commentTextField)
        addSubview(lineSeparator)
        
        commentTextField.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: sendButton.leftAnchor, paddingTop: 8, paddingLeft: 6, paddingBottom: 8, paddingRight: 0, width: 0, height: 0)
        sendButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 6, width: 86, height: 50)
        lineSeparator.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        
    }
    
    
    let commentTextField: CommentImputTextView = {
        let tv = CommentImputTextView()
        tv.font = UIFont.boldSystemFont(ofSize: 18)
        tv.layer.cornerRadius = 5
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.lightGray.cgColor
        return tv
    }()
    
    let sendButton: UIButton = {
        let sb = UIButton(type: .system)
        sb.setTitle("Отправить", for: .normal)
        sb.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        sb.setTitleColor(.black, for: .normal)
        sb.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return sb
    }()
    
    let lineSeparator: UIView = {
        let ls = UIView()
        ls.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        return ls
    }()
    
    @objc func handleSend() {
        print(123)
        guard let commentText = commentTextField.text else {return}
        delegate?.didSubmit(for: commentText)
        commentTextField.text = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
