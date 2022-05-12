import Foundation
import FoundationNetworking

class CatDataService{
    static let instace:CatDataService =  CatDataService();
    
    func getBreeds()  {
        
        let url = URL(string: "https://api.thecatapi.com/v1/breeds?limit=50")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task:() = URLSession.shared.dataTask(with: request){ data, response , error in
        
            guard let data = data else {
                return
            }

            do{
                let decodeData:[Cat] = try JSONDecoder().decode([Cat].self, from: data)
                
                print(decodeData)
                
            }catch{ 
                print("*****")
                print(error)
                
            }
        
        }.resume()

    }
}

