//
//  SecondVC.swift
//  ToDoMe
//
//  Created by Evgenii Kutasov on 30.03.2023.
//

import UIKit

class NewNotesVC: UIViewController, UITextViewDelegate {
    
    var mytextView = UITextView()
    let mylabel = UILabel()
    public var completion: ((String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupTextView()
        mytextView.delegate = self

        let saveBarButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(myRightSideBarButtonItemTapped(_:)))
        self.navigationItem.rightBarButtonItem = saveBarButton
        

    }
    @objc func NameOfSelector() {
        //Actions when notification is received
     }
    
    func setupTextView() {
        mytextView = UITextView(frame: CGRect(x: 20, y: 200, width: self.view.bounds.width - 50, height: self.view.bounds.height / 2 + 20))
        mytextView.text = "Введите текст..."
        mytextView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        mytextView.layer.cornerRadius = 10
        mytextView.textColor = .white
        mytextView.font = UIFont(name: "Courier", size: 20)
        mytextView.backgroundColor = .systemCyan
        
        
        self.view.addSubview(mytextView)
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender: UIBarButtonItem!){
        if let data = mytextView.text {
            if data != "" {
                completion?(data, currentData())
            }
        }else {
            alertController()
        }
        
    }
    func alertController() {
        let alert = UIAlertController(title: "Внимание ошибка", message: "Введите текст заметки", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func currentData() -> String {
        let date = Date()
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let currrentData = "\(day).\(month).\(year)"
        
        return currrentData
        
    }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        print("Click")

        
        return true
    }
    
    
}
