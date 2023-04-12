//
//  SecondVC.swift
//  ToDoMe
//
//  Created by Evgenii Kutasov on 30.03.2023.
//

import UIKit

class NewNotesVC: UIViewController{
    var mytextView = UITextView()
    let mylabel = UILabel()
    var scrollView = UIScrollView()
    public var completion: ((String, String) -> Void)?
    let placeHolderText = "Write text please..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupTextView()
        mytextView.delegate = self
        let saveBarButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(myRightSideBarButtonItemTapped(_:)))
        self.navigationItem.rightBarButtonItem = saveBarButton
        
    }
    func setupTextView() {
       
        mytextView = UITextView(frame: CGRect(x: 20, y: 200, width: self.view.bounds.width - 50, height: self.view.bounds.height / 2 + 20))
        mytextView.text = placeHolderText
        mytextView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        mytextView.layer.cornerRadius = 10
        mytextView.textColor = .white
        mytextView.font = UIFont(name: "Courier", size: 20)
        mytextView.backgroundColor = .systemGray6
        mytextView.textColor = .lightGray

        self.view.addSubview(mytextView)
        
        
    }
    

    
    @objc func myRightSideBarButtonItemTapped(_ sender: UIBarButtonItem!){
        if let data = mytextView.text {
            if data != "" {
                completion?(currentData(), data)
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
}

extension NewNotesVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if mytextView.textColor == UIColor.lightGray {
            mytextView.text = ""
            mytextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

        if mytextView.text == "" {
            mytextView.text = "Placeholder text ..."
            mytextView.textColor = UIColor.lightGray
        }
    }
    
    
}

