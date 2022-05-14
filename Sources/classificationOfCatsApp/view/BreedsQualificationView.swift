import Foundation

class BreedsQualificationView {
    static let instance: BreedsQualificationView = BreedsQualificationView()
    let presenter = Presenter.instance
    var countQualifications = 0
    var vowsList: [Vote]?

    func loadQualificationSystem(){
        ViewUtilities.clearScreem()

        guard let vowsList = presenter.getVowsList() else {
            print("Error loading the vows list")
            return 
        }

        do{
            let vowsListIsEmpty = vowsList.isEmpty 
            if vowsListIsEmpty{
                print("No Ratings yet")
            }else{
                countQualifications = 0
                var graphicList: String = "*********************************************\n"
                for vot in vowsList{
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
            print("\nPress enter to continue")
            guard let _ = readLine() else {
                print("Error\nPress enter to continue")
                return
            }
        }catch Errors.dataIsNotDecodable {
            print("Error trying to get cats list")
        }
    }
}