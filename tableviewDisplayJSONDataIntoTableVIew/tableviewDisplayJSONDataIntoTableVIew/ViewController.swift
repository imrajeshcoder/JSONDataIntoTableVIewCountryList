//
//  ViewController.swift
//  tableviewDisplayJSONDataIntoTableVIew
//
 
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate {
  

    @IBOutlet weak var tblCountry: UITableView!
    var arrayCountry = [[String: Any]]()
    
    @IBOutlet weak var txtSearchText: UITextField!
    var arrayFilterCountry = [[String: Any]]()
     var searchActive : Bool = false
   // var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    var filtered:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tblCountry.dataSource = self
        tblCountry.delegate = self
        txtSearchText.delegate = self
        txtSearchText.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)),
                                for: UIControl.Event.editingChanged)
       // print(arrayCountry.count)
        guard let path = Bundle.main.path(forResource: "county", ofType: "json") else { return }
                let url = URL(fileURLWithPath: path)
                
                do {
                    let data = try Data(contentsOf: url)
                    let json = try JSONSerialization.jsonObject(with: data)as? [String: Any]
                    guard let array = json?["country_info"] as? [[String: Any]]  else { return }
                    
                    self.arrayCountry = array
                    self.arrayFilterCountry = array
                        // print(self.arrayCountry[0]["country_name"])
                }
                catch {
                    print(error)
                }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
     // filter tableViewData with textField.text
        let searchText  = textField.text!
        arrayFilterCountry = []
        if (searchText != "")
        {
        for country in arrayCountry {
            var strtmpSountryName = country["country_name"] as! String
            if strtmpSountryName.lowercased().contains(searchText.lowercased())
            {
                arrayFilterCountry.append(country)
            }
            else
            {
            }
            tblCountry.reloadData()
        }
        }
        else
        {
            arrayFilterCountry = arrayCountry
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFilterCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CountryCellTableViewCell", for: indexPath) as? CountryCellTableViewCell
        cell?.lblCellCountry.text = arrayFilterCountry[indexPath.row]["country_name"] as! String
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "StateViewController") as? StateViewController {
           // print("A")
            vc.srtCountryID = arrayFilterCountry[indexPath.row]["country_id"] as! String
         
            self.navigationController?.pushViewController(vc, animated: true)
          //  print("BBBB")
            
        }
    }
    
        
}

