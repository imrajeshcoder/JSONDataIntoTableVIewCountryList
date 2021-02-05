//
//  StateViewController.swift
//  tableviewDisplayJSONDataIntoTableVIew
//
//  Created by Vijay on 05/02/21.
//

import UIKit

class StateViewController: UIViewController , UITableViewDelegate , UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var srchbarFilterData: UISearchBar!
    @IBOutlet weak var tblStateDisplay: UITableView!
    
    var arrayStateFullData = [[String: Any]]()
    var arrayStateName = [[String: Any]]()
    var srtCountryID : String = ""
  //  var arraySatate  = [[String]]()
    var arrayFilterState = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //print(srtCountryID)
        tblStateDisplay.delegate = self
        tblStateDisplay.dataSource = self
        srchbarFilterData.delegate = self
        srchbarFilterData.showsCancelButton = true
        fncLoadStateJSONData()
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFilterState.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "StateCellTableViewCell", for: indexPath) as? StateCellTableViewCell
        cell?.lblStateNameDisplay.text = arrayFilterState[indexPath.row]["state_name"] as! String
        //  = arrayCountry[indexPath.row]["country_name"] as! String
        return cell!
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
     {
          print("Searchbar Value Change")
        
        let searchText  = srchbarFilterData.text!
        arrayFilterState = []
        if (searchText != "")
        {
        for state in arrayStateName {
            var strtmpCountryName = state["state_name"] as! String
                if strtmpCountryName.lowercased().contains(searchText.lowercased())
                {
                    arrayFilterState.append(state)
                }
            }
        }
        else
        {
            arrayFilterState = arrayStateName
            
        }
        tblStateDisplay.reloadData()
        
  
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("SerachBAAAAA")
        srchbarFilterData.text = ""
        srchbarFilterData.endEditing(true)
        searchBar.resignFirstResponder()
        fncLoadStateJSONData()
    }
    
    func fncLoadStateJSONData()  {
        guard let url = URL(string: "https://linxko.com/api/app/state_list") else {return}
          let bodyData = "country_id=\(srtCountryID)"
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
           request.httpBody = bodyData.data(using: String.Encoding.utf8);
          
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  print(error?.localizedDescription ?? "Response Error")
                  return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:dataResponse) as? [String: Any]
               // print(jsonResponse) //Response result
                if let success = jsonResponse?["success"] as? Bool,success{
                    guard let array = jsonResponse?["state_info"] as? [[String: Any]]  else { return }
                    self.arrayStateName = array
                    self.arrayFilterState = array
                    DispatchQueue.main.async {
                        self.tblStateDisplay.reloadData()
                    }
                }else{
                    print("Check Country id")
                }
                //print(self.arrayStateName[0]["state_name"])
             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
