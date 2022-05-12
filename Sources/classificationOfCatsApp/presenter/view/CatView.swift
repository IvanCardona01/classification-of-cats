import Foundation

class CatView{
    static let instace:CatView = CatView()
    let catDataService = CatDataService.instace

    func start(){
        catDataService.getBreeds()
        readLine()!
    }

}