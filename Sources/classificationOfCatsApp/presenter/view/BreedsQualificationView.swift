import Foundation

class BreedsQualificationView {
    static let instance: BreedsQualificationView = BreedsQualificationView()
    let keysOfUserDefaults = KeysOfUserDefaults.instance
    let catDataService = CatDataService.instance
    let viewUtilities = ViewUtilities.instance
    var countQualifications = 0
    var vowsList: [Vote]?

    func loadQualificationSystem(){
        viewUtilities.clearScreem()
        UserDefaults.standard.synchronize()
        self.vowsList = try? catDataService.getVowsListOfUserDefaults()
        do{
            let vowsListIsEmpty = vowsList?.isEmpty == nil
            if vowsListIsEmpty{
                print("No Ratings yet")
            }else{
                countQualifications = 0
                var graphicList: String = "*********************************************\n"
                for vot in vowsList!{
                    let breedHasQualification = vot.vows != 0
                    if breedHasQualification{
                        graphicList += "* Breed: \(vot.breed)    Qualification:  \(vot.vows)  \n" +
                                "*********************************************\n"
                        countQualifications += 1
                    }
                }
                let theVowsListHasQualification = countQualifications != 0
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