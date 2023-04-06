//
//  FirstTableVC.swift
//  ToDoMe
//
//  Created by Evgenii Kutasov on 29.03.2023.
//

import UIKit

class FirstTableVC: UITableViewController{
    
    let addBarButton = UIBarButtonItem()
    var tupleData: [(date: String, textdate: String)] = [("4343434", "43434")]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "To Do Me Test"
        let rightBarButton = UIBarButtonItem(title: "➕", style: .plain, target: self, action: #selector(didTapNewNote(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        let leftBarButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.myLeftSideBarButtonItemTapped(_:)))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    
    @objc func didTapNewNote(_ sender: UIBarButtonItem!){
        let vc = NewNotesVC()
        
        vc.title = "Notes"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { data, date in
            self.navigationController?.popViewController(animated: true)
            self.tupleData.append((date: data, textdate: date))
            self.tableView.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func myLeftSideBarButtonItemTapped(_ sender: UIBarButtonItem!){
        print("myLeftSideBarButtonItemTapped")
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tupleData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = tupleData[indexPath.row].textdate
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let tuple = tupleData[indexPath.row]
        
        let vc = PreviewVC()
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Note"
        vc.dataText = tuple.date
        vc.text = tuple.textdate
        
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        tableView.beginUpdates()
        if editingStyle == .delete {
            self.tupleData.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.endUpdates()
    }
    
}



