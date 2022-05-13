import Foundation
import FoundationNetworking

class CatDataService{
    static let instance:CatDataService =  CatDataService();
    let keysOfUserDefaults = KeysOfUserDefaults()
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func getBreeds(completion: @escaping ([Cat]) -> ()) {
        
        let url = URL(string: "https://api.thecatapi.com/v1/breeds?limit=4")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task:() = URLSession.shared.dataTask(with: request){ (data, response , error) in
        
            guard let data = data else {
                return
            }

            do{
                let decodeData:[Cat] = try JSONDecoder().decode([Cat].self, from: data)
                completion(decodeData)
            }catch{ 
                print("*****")
                print(error)
                return
            }
        
        }.resume()

    }

    func getCatsListOfUserDefaults()throws -> [Cat]{
        let dataCatsList = UserDefaults.standard.data(forKey: keysOfUserDefaults.getKeyOfCatsList())
        guard let catsList = try? decoder.decode([Cat].self, from: dataCatsList!)else {            
            throw Errors.dataIsNotDecodable
        }
        return catsList
    }

    func getVowsListOfUserDefaults()throws -> [Vote]{
        let dataVowsList = UserDefaults.standard.data(forKey: keysOfUserDefaults.getKeyOfVowsList())
        guard let vowsList = try? decoder.decode([Vote].self, from: dataVowsList!)else {            
            throw Errors.dataIsNotDecodable
        }
        return vowsList
    }

    func setCatsListInUserDefault(data: [Cat])throws{
        guard let dataList = try? encoder.encode(data) else {
            throw Errors.dataIsNotEncodable
        }
        UserDefaults.standard.set(dataList, forKey: keysOfUserDefaults.getKeyOfCatsList())
        UserDefaults.standard.synchronize()
    }

    func setVowsListInUserDefault(data: [Vote])throws{
        guard let dataList = try? encoder.encode(data) else {
            throw Errors.dataIsNotEncodable
        }
        UserDefaults.standard.set(dataList, forKey: keysOfUserDefaults.getKeyOfVowsList())
        UserDefaults.standard.synchronize()
    }
}

