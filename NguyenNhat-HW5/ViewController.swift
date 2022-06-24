// Project: NguyenNhat-HW5
// EID: nn7294
// Course: CS371L
//
//  ViewController.swift
//  NguyenNhat-HW5
//
//  Created by Minh Nguyen on 6/19/22.
//

import UIKit
import FirebaseAuth
import CoreData



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let createPizzaSegueIdentifier = "CreatePizzaSegue"
    let pizzaCellIdentifier = "PizzaCell"
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == createPizzaSegueIdentifier,
           let nextVC = segue.destination as? CreatePizzaViewController {
            nextVC.delegate = self
        }
    }
    
    
    //override viewWillAppear to make table view reload data
    //and hide back button in the main view controller
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        self.navigationItem.hidesBackButton = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell (withIdentifier: pizzaCellIdentifier, for: indexPath as IndexPath)
        //let row = indexPath.row
        let fetchResults = retrievePizzas()
        let pizza = fetchResults[indexPath.row]
        if let pSize = pizza.value(forKey:"pSize") {
            if let crust = pizza.value(forKey:"crust") {
                if let cheese = pizza.value(forKey: "cheese") {
                    if let meat = pizza.value(forKey: "meat") {
                        if let veggies = pizza.value(forKey: "veggies") {
                            cell.textLabel?.text = pSize as! String
                            cell.detailTextLabel?.text = printDetailTabelCell(crust as! String, cheese as! String, meat as! String, veggies as! String)
                        }
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fetchResults = retrievePizzas()
        return fetchResults.count
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchResults = retrievePizzas()
            let pizza = fetchResults[indexPath.row]
            context.delete(pizza)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do {
                try context.save()
            } catch {
                // If an error occurs
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

    
    
    @IBAction func logOutBtnPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch {
            print("Sign out error")
        }
        
    }
    
    func clearCoreData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Pizza")
        var fetchedResults:[NSManagedObject]
        
        do {
            try fetchedResults = context.fetch(request) as! [NSManagedObject]
            
            if fetchedResults.count > 0 {
                
                for result:AnyObject in fetchedResults {
                    context.delete(result as! NSManagedObject)
                    print("\(result.value(forKey: "name")!) has been Deleted")
                }
            }
            try context.save()
            
        } catch {
            // If an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
    }
    
    func retrievePizzas() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Pizza")
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
        } catch {
            // If an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        return(fetchedResults)!
        
    }
    
    //print string for subtitle of a pizza in a table cell
    func printDetailTabelCell(_ crust: String, _ cheese: String, _ meat: String, _ veggies: String) -> String {
        return ("\t\(crust)\n\t\(cheese)\n\t\(meat)\n\t\(veggies)")
    }
}

