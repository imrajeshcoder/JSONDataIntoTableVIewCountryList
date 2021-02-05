//
//  ViewController.swift
//  tableviewDisplayJSONDataIntoTableVIew
//
 
//

import UIKit

class ViewController: UIViewController {

    var arrayCountry = [[String: Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let path = Bundle.main.path(forResource: "county", ofType: "json") else { return }
                let url = URL(fileURLWithPath: path)
                
                do {
                    let data = try Data(contentsOf: url)
                    let json = try JSONSerialization.jsonObject(with: data)as? [String: Any]
                    guard let array = json?["country_info"] as? [[String: Any]]  else { return }
                    self.arrayCountry = array
                    print(self.arrayCountry[0]["country_name"])
                
                }
                catch {
                    print(error)
                }
    }
        
}

