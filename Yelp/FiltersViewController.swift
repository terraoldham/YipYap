//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Terra Oldham on 9/21/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    @objc optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String:AnyObject])
}

enum FiltersBlocks : String {
    case categoriesBlock = "Category"
    case dealsBlock = ""
    case sortBlock = "Sort"
    
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate {
    @IBOutlet weak var tableView: UITableView!

    
    weak var delegate: FiltersViewControllerDelegate?
    
    var allFilters = [[String:AnyObject]]()
    var categories: [[String: String]]!
    var deals: [[String:AnyObject]]!
    var sort: [[String:AnyObject]]!
    var switchStates = [Int:Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        categories = yelpCategories()
        deals = yelpDeal()
        sort = yelpSort()
        
        for sorted in sort {
            allFilters.append(sorted as [String : AnyObject])
        }
        for deal in deals {
            allFilters.append(deal as [String : AnyObject])
        }
        for category in categories {
            allFilters.append(category as [String : AnyObject])
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onSaveButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        var filters: [String: AnyObject] = [:]
        var sortFilters = [AnyObject]()
        var categoryFilters = [AnyObject]()
        var dealFilters = [AnyObject]()
        var selectedFilters = [AnyObject]()
        for (row,isSelected) in switchStates {
            if isSelected {
                if allFilters[row]["value"] != nil {
                    selectedFilters.append((allFilters[row]["value"] as? AnyObject)!)
                    categoryFilters.append((allFilters[row]["value"] as? AnyObject)!)
                    print("Category")
                }
                if allFilters[row]["sort_value"] != nil {
                    selectedFilters.append((allFilters[row]["sort_value"] as? AnyObject)!)
                    sortFilters.append((allFilters[row]["sort_value"] as? AnyObject)!)
                    print("Sort Filters")
                    print(sortFilters)
                }
                if allFilters[row]["deal_value"] != nil {
                    selectedFilters.append((allFilters[row]["deal_value"] as? AnyObject)!)
                    dealFilters.append((allFilters[row]["deal_value"] as? AnyObject)!)
                    print("Deal")
                    print(dealFilters)
                }
            }
        }
        
        if selectedFilters.count > 0 {
            filters["allFilters"] = selectedFilters as AnyObject
            print(filters)
            print(categoryFilters)
            print(sortFilters)
            print(dealFilters)
        }
        
        delegate?.filtersViewController?(filtersViewController: self, didUpdateFilters: filters as [String : AnyObject])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFilters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
        
        cell.switchLabel.text = String(describing: allFilters[indexPath.row]["title"])
        cell.delegate = self
        cell.onSwitch.isOn = switchStates[indexPath.row] ?? false
        
        return cell
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)!
        
        switchStates[indexPath.row] = value
        print("Got the switch")
    }
    
    func yelpCategories() -> [[String:String]] {
        return [
            ["title": "Afghan", "value": "afghani"],
            ["title": "African", "value": "african"],
            ["title": "American, New", "value": "newamerican"],
            ["title": "American, Traditional", "value": "tradamerican"],
            ["title": "Arabian", "value": "arabian"],
            ["title": "Argentine", "value": "argentine"],
            ["title": "Armenian", "value": "armenian"],
            ["title": "Asian Fusion", "value": "asianfusion"],
            ["title": "Asturian", "value": "asturian"],
            ["title": "Australian", "value": "australian"],
            ["title": "Austrian", "value": "austrian"],
            ["title": "Baguettes", "value": "baguettes"],
            ["title": "Bangladeshi", "value": "bangladeshi"],
            ["title": "Barbeque", "value": "bbq"],
            ["title": "Basque", "value": "basque"],
            ["title": "Bavarian", "value": "bavarian"],
            ["title": "Beer Garden", "value": "beergarden"],
            ["title": "Beer Hall", "value": "beerhall"],
            ["title": "Beisl", "value": "beisl"],
            ["title": "Belgian", "value": "belgian"],
            ["title": "Bistros", "value": "bistros"],
            ["title": "Black Sea", "value": "blacksea"],
            ["title": "Brasseries", "value": "brasseries"],
            ["title": "Brazilian", "value": "brazilian"],
            ["title": "Breakfast & Brunch", "value": "breakfast_brunch"],
            ["title": "British", "value": "british"],
            ["title": "Buffets", "value": "buffets"],
            ["title": "Bulgarian", "value": "bulgarian"],
            ["title": "Burgers", "value": "burgers"],
            ["title": "Burmese", "value": "burmese"],
            ["title": "Cafes", "value": "cafes"],
            ["title": "Cafeteria", "value": "cafeteria"],
            ["title": "Cajun/Creole", "value": "cajun"],
            ["title": "Cambodian", "value": "cambodian"],
            ["title": "Canadian", "value": "New)"],
            ["title": "Canteen", "value": "canteen"],
            ["title": "Caribbean", "value": "caribbean"],
            ["title": "Catalan", "value": "catalan"],
            ["title": "Chech", "value": "chech"],
            ["title": "Cheesesteaks", "value": "cheesesteaks"],
            ["title": "Chicken Shop", "value": "chickenshop"],
            ["title": "Chicken Wings", "value": "chicken_wings"],
            ["title": "Chilean", "value": "chilean"],
            ["title": "Chinese", "value": "chinese"],
            ["title": "Comfort Food", "value": "comfortfood"],
            ["title": "Corsican", "value": "corsican"],
            ["title": "Creperies", "value": "creperies"],
            ["title": "Cuban", "value": "cuban"],
            ["title": "Curry Sausage", "value": "currysausage"],
            ["title": "Cypriot", "value": "cypriot"],
            ["title": "Czech", "value": "czech"],
            ["title": "Czech/Slovakian", "value": "czechslovakian"],
            ["title": "Danish", "value": "danish"],
            ["title": "Delis", "value": "delis"],
            ["title": "Diners", "value": "diners"],
            ["title": "Dumplings", "value": "dumplings"],
            ["title": "Eastern European", "value": "eastern_european"],
            ["title": "Ethiopian", "value": "ethiopian"],
            ["title": "Fast Food", "value": "hotdogs"],
            ["title": "Filipino", "value": "filipino"],
            ["title": "Fish & Chips", "value": "fishnchips"],
            ["title": "Fondue", "value": "fondue"],
            ["title": "Food Court", "value": "food_court"],
            ["title": "Food Stands", "value": "foodstands"],
            ["title": "French", "value": "french"],
            ["title": "French Southwest", "value": "sud_ouest"],
            ["title": "Galician", "value": "galician"],
            ["title": "Gastropubs", "value": "gastropubs"],
            ["title": "Georgian", "value": "georgian"],
            ["title": "German", "value": "german"],
            ["title": "Giblets", "value": "giblets"],
            ["title": "Gluten-Free", "value": "gluten_free"],
            ["title": "Greek", "value": "greek"],
            ["title": "Halal", "value": "halal"],
            ["title": "Hawaiian", "value": "hawaiian"],
            ["title": "Heuriger", "value": "heuriger"],
            ["title": "Himalayan/Nepalese", "value": "himalayan"],
            ["title": "Hong Kong Style Cafe", "value": "hkcafe"],
            ["title": "Hot Dogs", "value": "hotdog"],
            ["title": "Hot Pot", "value": "hotpot"],
            ["title": "Hungarian", "value": "hungarian"],
            ["title": "Iberian", "value": "iberian"],
            ["title": "Indian", "value": "indpak"],
            ["title": "Indonesian", "value": "indonesian"],
            ["title": "International", "value": "international"],
            ["title": "Irish", "value": "irish"],
            ["title": "Island Pub", "value": "island_pub"],
            ["title": "Israeli", "value": "israeli"],
            ["title": "Italian", "value": "italian"],
            ["title": "Japanese", "value": "japanese"],
            ["title": "Jewish", "value": "jewish"],
            ["title": "Kebab", "value": "kebab"],
            ["title": "Korean", "value": "korean"],
            ["title": "Kosher", "value": "kosher"],
            ["title": "Kurdish", "value": "kurdish"],
            ["title": "Laos", "value": "laos"],
            ["title": "Laotian", "value": "laotian"],
            ["title": "Latin American", "value": "latin"],
            ["title": "Live/Raw Food", "value": "raw_food"],
            ["title": "Lyonnais", "value": "lyonnais"],
            ["title": "Malaysian", "value": "malaysian"],
            ["title": "Meatballs", "value": "meatballs"],
            ["title": "Mediterranean", "value": "mediterranean"],
            ["title": "Mexican", "value": "mexican"],
            ["title": "Middle Eastern", "value": "mideastern"],
            ["title": "Milk Bars", "value": "milkbars"],
            ["title": "Modern Australian", "value": "modern_australian"],
            ["title": "Modern European", "value": "modern_european"],
            ["title": "Mongolian", "value": "mongolian"],
            ["title": "Moroccan", "value": "moroccan"],
            ["title": "New Zealand", "value": "newzealand"],
            ["title": "Night Food", "value": "nightfood"],
            ["title": "Norcinerie", "value": "norcinerie"],
            ["title": "Open Sandwiches", "value": "opensandwiches"],
            ["title": "Oriental", "value": "oriental"],
            ["title": "Pakistani", "value": "pakistani"],
            ["title": "Parent Cafes", "value": "eltern_cafes"],
            ["title": "Parma", "value": "parma"],
            ["title": "Persian/Iranian", "value": "persian"],
            ["title": "Peruvian", "value": "peruvian"],
            ["title": "Pita", "value": "pita"],
            ["title": "Pizza", "value": "pizza"],
            ["title": "Polish", "value": "polish"],
            ["title": "Portuguese", "value": "portuguese"],
            ["title": "Potatoes", "value": "potatoes"],
            ["title": "Poutineries", "value": "poutineries"],
            ["title": "Pub Food", "value": "pubfood"],
            ["title": "Rice", "value": "riceshop"],
            ["title": "Romanian", "value": "romanian"],
            ["title": "Rotisserie Chicken", "value": "rotisserie_chicken"],
            ["title": "Rumanian", "value": "rumanian"],
            ["title": "Russian", "value": "russian"],
            ["title": "Salad", "value": "salad"],
            ["title": "Sandwiches", "value": "sandwiches"],
            ["title": "Scandinavian", "value": "scandinavian"],
            ["title": "Scottish", "value": "scottish"],
            ["title": "Seafood", "value": "seafood"],
            ["title": "Serbo Croatian", "value": "serbocroatian"],
            ["title": "Signature Cuisine", "value": "signature_cuisine"],
            ["title": "Singaporean", "value": "singaporean"],
            ["title": "Slovakian", "value": "slovakian"],
            ["title": "Soul Food", "value": "soulfood"],
            ["title": "Soup", "value": "soup"],
            ["title": "Southern", "value": "southern"],
            ["title": "Spanish", "value": "spanish"],
            ["title": "Steakhouses", "value": "steak"],
            ["title": "Sushi Bars", "value": "sushi"],
            ["title": "Swabian", "value": "swabian"],
            ["title": "Swedish", "value": "swedish"],
            ["title": "Swiss Food", "value": "swissfood"],
            ["title": "Tabernas", "value": "tabernas"],
            ["title": "Taiwanese", "value": "taiwanese"],
            ["title": "Tapas Bars", "value": "tapas"],
            ["title": "Tapas/Small Plates", "value": "tapasmallplates"],
            ["title": "Tex-Mex", "value": "tex-mex"],
            ["title": "Thai", "value": "thai"],
            ["title": "Traditional Norwegian", "value": "norwegian"],
            ["title": "Traditional Swedish", "value": "traditional_swedish"],
            ["title": "Trattorie", "value": "trattorie"],
            ["title": "Turkish", "value": "turkish"],
            ["title": "Ukrainian", "value": "ukrainian"],
            ["title": "Uzbek", "value": "uzbek"],
            ["title": "Vegan", "value": "vegan"],
            ["title": "Vegetarian", "value": "vegetarian"],
            ["title": "Venison", "value": "venison"],
            ["title": "Vietnamese", "value": "vietnamese"],
            ["title": "Wok", "value": "wok"],
            ["title": "Wraps", "value": "wraps"],
            ["title": "Yugoslav", "value": "yugoslav"]
        ]
    }
    
    func yelpSort() -> [[String:AnyObject]] {
        return[["title": "Best Match" as AnyObject, "sort_value": YelpSortMode.bestMatched.rawValue as AnyObject],
               ["title": "Distance" as AnyObject, "sort_value": YelpSortMode.distance.rawValue as AnyObject],
               ["title": "Highest Rated" as AnyObject, "sort_value": YelpSortMode.highestRated.rawValue as AnyObject]]
    }
    
    func yelpDeal() -> [[String:AnyObject]] {
        return [["title": "Offering a Deal" as AnyObject, "deal_value": true as AnyObject]]
    }

}
