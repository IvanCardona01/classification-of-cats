import Foundation

class Presenter{
    static let instance: Presenter = Presenter()
    let catDataService = CatDataService.instance

    func loadCatLists(){
        catDataService.getBreeds(){ (cats) in
            do{
                try? self.catDataService.setCatsListInUserDefault(data: cats)
            }catch Errors.dataIsNotEncodable{
                print("An unexpected error occurred while trying to save the data list")
            }
        }
    }

    func loadVowsLists(){
        do{
            let vows: [Vote] = []
            try? self.catDataService.setVowsListInUserDefault(data: vows)
        }catch Errors.dataIsNotEncodable{
            print("An unexpected error occurred while trying to save the data list")
        }
    }

    func getVowsList() -> [Vote]?{
        UserDefaults.standard.synchronize()
        guard let vowsList:[Vote] = try? catDataService.getVowsListOfUserDefaults() else {
            return nil
        }
        return vowsList
    }

    func getCatsList() -> [Cat]?{
        UserDefaults.standard.synchronize()
        guard let catsList = try? catDataService.getCatsListOfUserDefaults() else{
            return nil
        }
        return catsList
    }

    func updateVowsLit(newVows: [Vote]){
        do{
            try? catDataService.setVowsListInUserDefault(data: newVows)
        }catch Errors.dataIsNotEncodable{
            print("An unexpected error occurred while trying to save the data list")
        }
        UserDefaults.standard.synchronize()
    }

}