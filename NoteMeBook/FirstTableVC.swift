//
//  FirstTableVC.swift
//  ToDoMe
//
//  Created by Evgenii Kutasov on 29.03.2023.
//

import UIKit
import CoreData

class FirstTableVC: UITableViewController  {
    
    let dateTextField = UITextField()
    let textTextField = UITextField()
    
    let addBarButton = UIBarButtonItem()
    var tupleData: [EntityDataNotes] = []
    var sortedClick = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let featchRequest: NSFetchRequest<EntityDataNotes> = EntityDataNotes.fetchRequest()
        
        if sortedClick == true {
            
            let sort = NSSortDescriptor(key: "date", ascending: false)
            featchRequest.sortDescriptors = [sort]
            
            do{
                tupleData = try! context.fetch(featchRequest)
                
                try context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            tableView.reloadData()
        }else{
            
            
            
            do{
                tupleData = try context.fetch(featchRequest)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButton()
        self.title = "To Do Me"
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self

    }
    

    
    func setupBarButton() {
        let iconImageRevers = UIImage(named: "arrow.up.arrow.down.circle.fill")
        let iconImagePlus = UIImage(named: "plus.circle.fill")
        
        
        let rightBarButton = UIBarButtonItem(image: iconImagePlus, style: .plain, target: self, action: #selector(didTapNewNote(_:)))
        
        let leftBarButton = UIBarButtonItem(title: "Delete all", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.deleteTapNotes(_:)))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let reversBarButton = UIBarButtonItem(image: iconImageRevers, style: UIBarButtonItem.Style.done, target: self, action: #selector(sortedData))
        
        self.navigationItem.rightBarButtonItems = [rightBarButton, reversBarButton]
    }
    
    @objc func sortedData() -> Bool{
        
        if sortedClick == false {
            sortedClick = true
        }else {
            sortedClick = false
            
        }
        viewWillAppear(true)
        return sortedClick

    }
    
    func saveTupleData(data: String, textData: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "EntityDataNotes", in: context) else {return}
        
        let tupleDataObject = EntityDataNotes(entity: entity, insertInto: context)
        tupleDataObject.date = data
        tupleDataObject.text = textData
        
        do{
            try context.save()
            tupleData.append(tupleDataObject)

        }catch _ as NSError {
            
        }
    }
    
    
    
    @objc func didTapNewNote(_ sender: UIBarButtonItem!){
        
        let vc = NewNotesVC()
        vc.title = "Notes"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { data, text in
            self.navigationController?.popViewController(animated: true)
            self.saveTupleData(data: data, textData: text)
            self.tableView.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func deleteTapNotes(_ sender: UIBarButtonItem!){
        
        alertController()
        
    }
    
    func alertController() {
        let alert = UIAlertController(title: "Delete all cells?", message: "After deleting all the cells will disappear.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: { (action) in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let featchRequest: NSFetchRequest<EntityDataNotes> = EntityDataNotes.fetchRequest()
            
            if let tupleData = try? context.fetch(featchRequest) {
                
                for data in tupleData {
                    context.delete(data)
                }
            }
            do{
                try context.save()
            }catch _ as NSError{
                
            }
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tupleData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        
        cell.mylabelDate.text = tupleData[indexPath.row].date
        cell.mylabelText.text = tupleData[indexPath.row].text
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let tuple = tupleData[indexPath.row]
        if tuple.date != nil {
            
            let vc = PreviewVC()
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.title = "Note"
            vc.dataText = tuple.date
            vc.text = tuple.text
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            print("Тут пусто")
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        
        tableView.beginUpdates()
        if editingStyle == .delete {
            
            let eventDel = tupleData[indexPath.row]
            self.tupleData.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            context?.delete(eventDel)
            
            do{
                try context!.save()
            }catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        tableView.endUpdates()
    }
}





