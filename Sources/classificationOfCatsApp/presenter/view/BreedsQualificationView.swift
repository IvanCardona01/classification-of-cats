import Foundation

class BreedsQualificationView {
    static let instance: BreedsQualificationView = BreedsQualificationView()
    let keysOfUserDefaults = KeysOfUserDefaults()
    let catDataService = CatDataService.instance
    let viewUtilities = ViewUtilities()

    func loadQualificationSystem(){
        viewUtilities.clearScreem()
        UserDefaults.standard.synchronize()
        do{
            let vowsList = try? catDataService.getVowsListOfUserDefaults()
            let vowsListIsEmpty = vowsList?.isEmpty == nil
            if vowsListIsEmpty{
                print("No Ratings yet")
            }else{
                var graphicList: String = "*********************************************\n"
                var countQualification = 0
                for vot in vowsList!{
                    let breedHasQualification = vot.vows != 0
                    if breedHasQualification{
                        graphicList += "* Breed: \(vot.breed)    Qualification:  \(vot.vows)  \n" +
                                "*********************************************\n"
                        countQualification += 1
                    }
                }
                let theVowsListHasQualification = countQualification != 0
                if theVowsListHasQualification{
                    print(graphicList)
                }else{
                    print("No Ratings yet")
                    
                }
            }
            print("\nPress any key to continue")
            readLine()!

        }catch Errors.dataIsNotDecodable {
            print("Error trying to get cats list")
        }
    }



}