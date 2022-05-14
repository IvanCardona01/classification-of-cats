import Foundation
import FoundationNetworking

class CatDataService{
    static let instance:CatDataService =  CatDataService();
    let keysOfUserDefaults = KeysOfUserDefaults()
    
    func getBreeds(completion: @escaping ([Cat]) -> ()) {
        
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds?limit=40") else{
            print("Data is not available")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let _:() = URLSession.shared.dataTask(with: request){ (data, response , error) in
        
            guard let data = data else {
                return
            }

            do{
                let decodeData:[Cat] = try JSONDecoder().decode([Cat].self, from: data)
                completion(decodeData)
            }catch{ 
                return
            }
        }.resume()
    }

    func getCatsListOfUserDefaults()throws -> [Cat]{
        guard let dataCatsList = UserDefaults.standard.data(forKey: keysOfUserDefaults.getKeyOfCatsList()) else{
            throw Errors.dataIsNotDecodable
        }
        guard let catsList = try? JSONDecoder().decode([Cat].self, from: dataCatsList)else {            
            throw Errors.dataIsNotDecodable
        }
        return catsList
    }

    func getVowsListOfUserDefaults()throws -> [Vote]{
        guard let dataVowsList = UserDefaults.standard.data(forKey: keysOfUserDefaults.getKeyOfVowsList()) else{
            throw Errors.dataIsNotDecodable
        }
        guard let vowsList = try? JSONDecoder().decode([Vote].self, from: dataVowsList)else {            
            throw Errors.dataIsNotDecodable
        }
        return vowsList
    }

    func setCatsListInUserDefault(data: [Cat])throws{
        guard let dataList = try? JSONEncoder().encode(data) else {
            throw Errors.dataIsNotEncodable
        }
        UserDefaults.standard.set(dataList, forKey: keysOfUserDefaults.getKeyOfCatsList())
        UserDefaults.standard.synchronize()
    }

    func setVowsListInUserDefault(data: [Vote])throws{
        guard let dataList = try? JSONEncoder().encode(data) else {
            throw Errors.dataIsNotEncodable
        }
        UserDefaults.standard.set(dataList, forKey: keysOfUserDefaults.getKeyOfVowsList())
        UserDefaults.standard.synchronize()
    }
}