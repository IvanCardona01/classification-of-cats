import Foundation

class CatPrincipalView{
    let catDataService = CatDataService.instance
    let viewUtilities = ViewUtilities.instance
    let catsVotingView = CatsVotingView.instance
    let keysOfUserDefaults = KeysOfUserDefaults()

    func start(){
        catDataService.getBreeds(){ (cats) in
            do{
                try? self.catDataService.setCatsListInUserDefault(data: cats)

                let vows: [Vote] = []
                try? self.catDataService.setVowsListInUserDefault(data: vows)
            }catch Errors.dataIsNotEncodable{
                print("An unexpected error occurred while trying to save the data list")
            }
        }
        let infinitCicle = true
        repeat{
            var optionIsAvailable = false
            var selectedOption: String
            repeat{
                print(getPrincipalMenu())
                selectedOption = readLine()!
                if selectedOptionIsAvailable(selectedOption: selectedOption){
                    optionIsAvailable = true;
                }else{
                    print("Option is not available\n\nPress any key to continue")
                    readLine()!
                }
            }while optionIsAvailable == false

            switch selectedOption{
                case "1":
                    catsVotingView.start()
                    break
                case "2":
                    
                    break
                case "3":
                    
                    break
                default:
                    print("System Error")
                    break
            }
        }while infinitCicle == true
    }

    func getPrincipalMenu() -> String{
        viewUtilities.clearScreem()
        let menu:String = "****************\n" +
                          "* 1. Vote      *\n" +
                          "* 2. Vote list *\n" +
                          "* 3. Breeds    *\n" +
                          "****************"
        return menu
    }

    func selectedOptionIsAvailable(selectedOption: String) -> Bool {
        var isAvalible = false
        let availableOptions = "123"
        let longAnswer = selectedOption.count
        let correctLong = longAnswer == 1
        let optionAvailable = availableOptions.contains(selectedOption)
        if correctLong &&  optionAvailable{
            isAvalible = true
        }
        return isAvalible 
    }

}