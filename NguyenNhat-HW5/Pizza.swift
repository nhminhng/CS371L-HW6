// Project: NguyenNhat-HW5
// EID: nn7294
// Course: CS371L
//
//  Pizza.swift
//  NguyenNhat-HW5
//
//  Created by Minh Nguyen on 6/19/22.
//

import Foundation

class Pizza {

    //defining propertises
    var pSize:String
    var crust:String
    var cheese:String
    var meat:String
    var veggies:String
    
    //initializer
    init (_ pSize: String, _ crust: String, _ cheese: String, _ meat: String, _ veggies: String) {
        self.pSize = pSize
        self.crust = crust
        self.cheese = cheese
        self.meat = meat
        self.veggies = veggies
    }
    
    //printing detail of a pizza inside a
    //CreatePizzaViewController when one is created
    static func printDetail(_ pizza: Pizza) -> String {
        return ("One \(pizza.pSize) pizza with:\n\t\(pizza.crust)\n\t\(pizza.cheese)\n\t\(pizza.meat)\n\t\(pizza.veggies)")
    }
    
    //print string for subtitle of a pizza in a table cell
    static func printDetailTabelCell(_ pizza: Pizza) -> String {
        return ("\t\(pizza.crust)\n\t\(pizza.cheese)\n\t\(pizza.meat)\n\t\(pizza.veggies)")
    }
}
