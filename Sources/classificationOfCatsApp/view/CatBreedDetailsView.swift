import Foundation

class CatBreedDetailsView{
    static let instance: CatBreedDetailsView = CatBreedDetailsView()
    let presenter = Presenter.instance
    var catsList: [Cat]?

    func loadCatBreedsList(){
        do{
            guard let cats = presenter.getCatsList() else {
                print("Error loading cats list")
                return
            }
            catsList = cats
            var exit = false
            repeat{
                ViewUtilities.clearScreem()

                printGraphicCatsList()
                print("\nPlease select a breed")
                guard let selectedBreedTypeString = readLine() else{
                    print("Error input text is not available")
                    return
                }

                if let selectedBreedTypeInt = Int(selectedBreedTypeString){
                    let exitOption = 0
                    if(selectedBreedTypeInt == exitOption){
                        exit = true
                    }else{
                        printCatDescription(selectedBreed: selectedBreedTypeInt)
                    }
                }else {
                    print("Option Is not available\nPlease input a number")
                    print("\nPress enter to continue")
                    guard let _ = readLine() else {
                        print("Error\nPress enter to continue")
                        return
                    }
                }
            }while exit == false
        }catch Errors.dataIsNotDecodable {
            print("Error trying to get cats list")
        }
    }

    func printGraphicCatsList(){
        var graphicCatsList = "*************************\n"
        var catIndexForTheUser = 1
        guard let cats = catsList else {
            print("Cats data is not available")
            return
        }
        for cat in cats {
            graphicCatsList.append("* \(catIndexForTheUser) \(cat.name)\n" +
                                    "*************************\n")
            catIndexForTheUser += 1
        }
        graphicCatsList.append("* 0 Exit    \n" +
                                "*************************\n")
        print(graphicCatsList)       
    }

    func printCatDescription(selectedBreed: Int){
        if selectedBreedIsAvailable(selectedBreed: selectedBreed) {
            ViewUtilities.clearScreem();
            guard let cats = catsList else {
                print("Cats data is not available")
                return
            }
            let catIndexInTheCatsList = selectedBreed - 1
            let catSelected = cats[catIndexInTheCatsList]
            let catDescription = catSelected.description
            print(catDescription)
        }else{
            print("\nOption Is not available")
        }
        print("\nPress enter to continue")
        guard let _ = readLine() else {
            print("Error\nPress enter to continue")
            return
        }
    }

    func selectedBreedIsAvailable(selectedBreed: Int) -> Bool{
        let positionOfCatInTheList = selectedBreed - 1 
        let firstCatPosition = 0
        guard let cats = catsList else {
            print("Cats data is not available")
            return false
        }
        let lastCatPosition = cats.count - 1 
        let selectedBreedIsBetweenRangeAvailable = positionOfCatInTheList >= firstCatPosition && positionOfCatInTheList <= lastCatPosition
        return selectedBreedIsBetweenRangeAvailable
    }
}