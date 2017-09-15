

import UIKit
import Foundation
import CoreLocation


var CityTechTalents = [CityTechTalent]()

enum ValidationError: Error {
    case missing(String)
    case invalid(String)
}

struct CityTechTalent {
    var city :String
    var langPerc:[(name: String, value: Int)] = []

    
    init?(city:String ,  langPerc : [(name: String, value: Int)] ) throws {
        
        self.city = city
        self.langPerc += langPerc
    }
    
    
}



func  getCityTechTalents() -> [CityTechTalent] {

    /*
     
     // This is if you want to get data from server
     
     let url = URL(string: "http://YourServer/Service/returnsJson")
     URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
        guard let data = data, error == nil else { return }
     */
    
     //Json
    
    let str = "[{\"city\":\"Houston\",  \"cityTalents\": [{\"lang\": \"Python\" , \"perc\":30 },{\"lang\": \"c++\" , \"perc\":10 } ] },{\"city\":\"NewYork\",  \"cityTalents\": [{\"lang\": \"Objective C\" , \"perc\":20 },{\"lang\": \"Swift 4\" , \"perc\":20 } ]},{\"city\":\"San Francisco\",  \"cityTalents\": [{\"lang\": \"Node JS\" , \"perc\":35 },{\"lang\": \"Scala\" , \"perc\":10 },{\"lang\": \"Ruby\" , \"perc\":15 } ] }]"

    
    let data = str.data(using: String.Encoding.utf8, allowLossyConversion: false)!

    // Parse Json
    
    do {
        let jsons = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
        for json in jsons {
        
        var stuff:[(name: String, value: Int)] = []
    
        
            guard let name = json["city"] as? String else {
                throw ValidationError.missing("city")
            }
            
            
        if let cityTalents = json["cityTalents"] as? [[String: Any]] {
            for cityTalent in cityTalents {
                if let lang = cityTalent["lang"] as? String {
                    
                    if let perc = cityTalent["perc"] as? Int
                    {
                        stuff += [(name: lang, value:perc)]
                        
                    }
                }
                
            }
            //Populate Collection object
            let vn = try CityTechTalent(city: name, langPerc: stuff)
            CityTechTalents.append(vn!)
        }
     }
    } catch let error as NSError {
        print("Failed to load: \(error.localizedDescription)")
    }
    
    return CityTechTalents // return collection object
}



