
import UIKit

class CityTalentViewController: UITableViewController  {

    
    var CityTechTalents = [CityTechTalent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.navigationController?.isNavigationBarHidden = false
    
        title = "City Tech Talent"
        //Get Data , we can do this in different thread if any performance issues.any
        
       CityTechTalents =  getCityTechTalents()
        
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return CityTechTalents.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CityTechTalents[section].langPerc.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return CityTechTalents[section].city + ":"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("TableViewCell1", owner: self, options: nil)?.first as! TableViewCell1
        
        cell.label1.text = "- " +  CityTechTalents[indexPath.section].langPerc[indexPath.row].name
         + " : " +  String(CityTechTalents[indexPath.section].langPerc[indexPath.row].value) + "%"
        
            return cell
        

}

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Info:",
                                      message: (
                                         " In \(CityTechTalents[indexPath.section].city), \(String(CityTechTalents[indexPath.section].langPerc[indexPath.row].value))% of all current programming jobs are for \(CityTechTalents[indexPath.section].langPerc[indexPath.row].name) " ),
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        
        let cancelAction = UIAlertAction(title: "Ok!",
                                         style: .cancel, handler: { _ in
                                            
        })
        
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}

