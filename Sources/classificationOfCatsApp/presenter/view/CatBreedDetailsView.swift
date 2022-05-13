import Foundation

class CatBreedDetailsView{
    static let instance: CatBreedDetailsView = CatBreedDetailsView()
    let catDataService = CatDataService.instance
    let viewUtilities = ViewUtilities()
    var catsList: [Cat]?

    func loadCatBreedsList(){
        do{
            catsList = try? catDataService.getCatsListOfUserDefaults() 
            var exit = false
            repeat{
                viewUtilities.clearScreem()
                var graphicCatsList = "*************************\n"
                var catIndexForTheUser = 1
                for cat in catsList! {
                    graphicCatsList.append("* \(catIndexForTheUser) \(cat.name)\n" +
                                            "*************************\n")
                    catIndexForTheUser += 1
                }
                graphicCatsList.append("* 0 Exit    \n" +
                                       "*************************\n")
                print(graphicCatsList)
                print("\nPlease select a breed")
                let selectedBreedTypeString = readLine()!
                if let selectedBreedTypeInt = Int(selectedBreedTypeString){
                    let exitOption = 0
                    if(selectedBreedTypeInt == exitOption){
                        exit = true
                    }else{
                        if selectedBreedIsAvailable(selectedBreed: selectedBreedTypeInt) {
                            viewUtilities.clearScreem();
                            let catIndexInTheCatsList = selectedBreedTypeInt - 1
                            let catSelected = catsList![catIndexInTheCatsList]
                            let catDescription = catSelected.description
                            print(catDescription)
                        }else{
                            print("\nOption Is not available")
                        }
                        print("\nPress any key to continue")
                        readLine()!
                    }

                }else {
                    print("Option Is not available\nPlease input a number")
                    print("\nPress any key to continue")
                    readLine()!
                }

            }while exit == false
        }catch Errors.dataIsNotDecodable {
            print("Error trying to get cats list")
        }
    }

    func selectedBreedIsAvailable(selectedBreed: Int) -> Bool{
        let positionOfCatInTheList = selectedBreed - 1 
        let firstCatPosition = 0
        let lastCatPosition = catsList!.count - 1 
        let selectedBreedIsBetweenRangeAvailable = positionOfCatInTheList >= firstCatPosition && positionOfCatInTheList <= lastCatPosition
        return selectedBreedIsBetweenRangeAvailable
    }
}