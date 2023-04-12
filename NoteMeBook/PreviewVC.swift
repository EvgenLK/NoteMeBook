//
//  NoteViewVC.swift
//  ToDoMe
//
//  Created by Evgenii Kutasov on 03.04.2023.
//

import UIKit

class PreviewVC: UIViewController {

    var dateLabel = UILabel()
    var mytextView = UITextView()
    
    public var dataText: String!
    public var text: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextView()
        setupLabel()
        view.backgroundColor = .white

        dateLabel.text = dataText
        mytextView.text = text
        
        setupLabel()
    }
    
    func setupTextView() {
        mytextView = UITextView(frame: CGRect(x: 20, y: 200, width: self.view.bounds.width - 50, height: self.view.bounds.height / 2 + 20))
        mytextView.text = "Введите текст..."
        mytextView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        mytextView.layer.cornerRadius = 10
        mytextView.textColor = .black
        mytextView.font = UIFont(name: "Courier", size: 20)
        mytextView.backgroundColor = .systemGray6
        mytextView.isSelectable = false
        self.view.addSubview(mytextView)
    }

    func setupLabel() {
        dateLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 300, height: 50))
        self.view.addSubview(dateLabel)

    }
}
