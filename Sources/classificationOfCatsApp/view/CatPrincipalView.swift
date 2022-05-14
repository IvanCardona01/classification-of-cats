import Foundation

class CatPrincipalView{
    let presenter = Presenter.instance
    let catsVotingView = CatsVotingView.instance
    let breedsQualificationView = BreedsQualificationView.instance
    let catBreedDetailsView = CatBreedDetailsView.instance

    func start(){

        presenter.loadCatLists()
        presenter.loadVowsLists()

        var exitOption = false
        repeat{
            var optionIsAvailable = false
            var selectedOption: String
            repeat{
                printPrincipalMenu()
                guard let input = readLine() else {
                     print("Error\n\nPress enter to continue")
                     return
                }
                selectedOption = input
               
                if selectedOptionIsAvailable(selectedOption: selectedOption){
                    optionIsAvailable = true;
                }else{
                    print("Option is not available\n\nPress enter to continue")
                    guard let _ = readLine() else{
                        print("Error\n\nPress enter to continue")
                        return
                    }
                }
                
            }while optionIsAvailable == false

            switch selectedOption{
                case "1":
                    catsVotingView.loadTheVotingSystem()
                    break
                case "2":
                    breedsQualificationView.loadQualificationSystem()
                    break
                case "3":
                    catBreedDetailsView.loadCatBreedsList()
                    break
                case "4":
                    exitOption = true
                    ViewUtilities.clearScreem()
                    break
                default:
                    print("System Error")
                    break
            }
        }while exitOption == false
    }

    func printPrincipalMenu(){
        ViewUtilities.clearScreem()
        let menu:String = "****************\n" +
                          "* 1. Vote      *\n" +
                          "* 2. Vote list *\n" +
                          "* 3. Breeds    *\n" +
                          "* 4. Exit      *\n" +
                          "****************"
        print(menu)
    }

    func selectedOptionIsAvailable(selectedOption: String) -> Bool {
        var isAvalible = false
        let availableOptions = "1234"
        let longAnswer = selectedOption.count
        let correctLong = longAnswer == 1
        let optionAvailable = availableOptions.contains(selectedOption)
        if correctLong &&  optionAvailable{
            isAvalible = true
        }
        return isAvalible 
    }
}