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

protocol PizzaProtocol {
    func addPizza(_ newPizza: Pizza)
}

class ViewController: UIViewController, PizzaProtocol, UITableViewDelegate, UITableViewDataSource {
   
    let createPizzaSegueIdentifier = "CreatePizzaSegue"
    let pizzaCellIdentifier = "PizzaCell"
    var testPizza = Pizza("tsize", "tcrust", "tcheese", "tmeat", "tveggies")
    var pizzaList: [Pizza] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == createPizzaSegueIdentifier,
           let nextVC = segue.destination as? CreatePizzaViewController {
            nextVC.delegate = self
        }
    }
    
    //adding a pizza to pizza list
    func addPizza(_ newPizza: Pizza) {
        pizzaList.append(newPizza)
    }
    
    //override viewWillAppear to make table view reload data
    //and hide back button in the main view controller
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        self.navigationItem.hidesBackButton = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell (withIdentifier: pizzaCellIdentifier, for: indexPath as IndexPath)
        let row = indexPath.row
        cell.textLabel?.text = pizzaList[row].pSize
        cell.detailTextLabel?.text = Pizza.printDetailTabelCell(pizzaList[row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaList.count
    }
}

