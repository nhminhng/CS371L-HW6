// Project: NguyenNhat-HW6
// EID: nn7294
// Course: CS371L
//
//  CreatePizzaViewController.swift
//  NguyenNhat-HW6
//
//  Created by Minh Nguyen on 6/19/22.
//

import UIKit
import CoreData

class CreatePizzaViewController: UIViewController {

    @IBOutlet weak var pizzaSizeSegCtrl: UISegmentedControl!
    @IBOutlet weak var summaryLabel: UILabel!
    var pSize:String = "small"
    var crust:String = ""
    var cheese:String = ""
    var meat:String = ""
    var veggies:String = ""
    var delegate: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        summaryLabel.text = ""
    }
    
    //select the size of a pizza basing on which
    //segment is selected
    @IBAction func onSegmentChanged(_ sender: Any) {
        switch pizzaSizeSegCtrl.selectedSegmentIndex {
        case 0:
            pSize = "small"
        case 1:
            pSize = "medium"
        case 2:
            pSize = "large"
        default:
            print("Error")
        }
    }
    
    //called when select crust button is pressed
    @IBAction func selectCrustBtnPressed(_ sender: Any) {
        let controller = UIAlertController(title: "Select crust", message: "Choose a crust style:", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Thin crust", style: .default, handler: {
            (action) in self.crust = "thin crust"}))
        controller.addAction(UIAlertAction(title: "Thick crust", style: .default, handler: {
            (action) in self.crust = "thick crust"}))
        present(controller, animated: true, completion: nil)
    }
    
    //called when select cheese button is pressed
    @IBAction func selectCheeseBtnPressed(_ sender: Any) {
        let controller = UIAlertController(title: "Select cheese", message: "Choose a cheese type:", preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "Regular cheese", style: .default, handler: {(action) in self.cheese = "regular cheese"}))
        controller.addAction(UIAlertAction(title: "No cheese", style: .default, handler: {(action) in self.cheese = "no cheese"}))
        controller.addAction(UIAlertAction(title: "Double cheese", style: .default, handler: {(action) in self.cheese = "double cheese"} ))
        present(controller, animated: true, completion: nil)
    }
    
    //called when select meat button is pressed
    @IBAction func selectMeatBtnPressed(_ sender: Any) {
        let controller = UIAlertController(title: "Select meat", message: "Choose one meat:", preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "Pepperoni", style: .default, handler: {(action) in self.meat = "pepperoni"}))
        controller.addAction(UIAlertAction(title: "Sausage", style: .default, handler: {(action) in self.meat = "sausage"}))
        controller.addAction(UIAlertAction(title: "Canadian Bacon", style: .default, handler: {(action) in self.meat = "canadian bacon"}))
        present(controller, animated: true, completion: nil)
    }
    
    //called when select veggies button is pressed
    @IBAction func selectVeggiesBtnPressed(_ sender: Any) {
        let controller = UIAlertController(title: "Select veggies", message: "Choose your veggies:", preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "Mushroom", style: .default, handler: {(action) in self.veggies = "mushroom"}))
        controller.addAction(UIAlertAction(title: "Onion", style: .default, handler: {(action) in self.veggies = "onion"}))
        controller.addAction(UIAlertAction(title: "Green Olive", style: .default, handler: {(action) in self.veggies = "green olive"}))
        controller.addAction(UIAlertAction(title: "Black Olive", style: .default, handler: {(action) in self.veggies = "black olive"}))
        controller.addAction(UIAlertAction(title: "None", style: .default, handler: {(action) in self.veggies = "none"}))
        present(controller, animated: true, completion: nil)
    }
    
    //called when done button is pressed
    @IBAction func doneBtnPressed(_ sender: Any) {
        if let missingIngredient = checkingMissingIngredientAlert() {
            //there is at least one missing ingredient
            let controller = UIAlertController(title: "Missing ingredient", message: "Please select a \(missingIngredient) type.", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(controller, animated: true, completion: nil)
        } else {
                storePizza(pSize, crust, cheese, meat, veggies)
                summaryLabel.text = printDetail(pSize, crust, cheese, meat, veggies)
        }
    }
    
    //checking if there are any missing ingredient
    //return the string representing the first missing ingredient founded
    //return nil if all ingredient have been selected
    func checkingMissingIngredientAlert() -> String? {
        if crust == "" {
            return "crust"
        }
        else if cheese == "" {
            return "cheese"
        }
        else if meat == "" {
            return "meat"
        }
        else if veggies == ""{
            return "veggies"
        }
        else {
            return nil
        }
    }
    
    //printing detail of a pizza inside a
    //CreatePizzaViewController when one is created
    func printDetail(_ pSize: String, _ crust: String, _ cheese: String, _ meat: String, _ veggies: String) -> String {
        return ("One \(pSize) pizza with:\n\t\(crust)\n\t\(cheese)\n\t\(meat)\n\t\(veggies)")
    }
    
    //storing a pizza into core data
    func storePizza(_ pSize: String, _ crust: String, _ cheese: String, _ meat: String, _ veggies: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let pizza = NSEntityDescription.insertNewObject(
            forEntityName: "Pizza", into: context)
        // Set the attribute values
        pizza.setValue(pSize, forKey: "pSize")
        pizza.setValue(crust, forKey: "crust")
        pizza.setValue(cheese, forKey: "cheese")
        pizza.setValue(meat, forKey: "meat")
        pizza.setValue(veggies, forKey: "veggies")
        // Commit the changes
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
