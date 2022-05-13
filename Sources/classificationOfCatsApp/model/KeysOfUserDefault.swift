import Foundation

struct KeysOfUserDefaults {
    private let catsList: String = "catsList"
    private let vowsList: String = "vowsList"

    func getKeyOfCatsList() -> String{
        return catsList
    }

    func getKeyOfVowsList() -> String{
        return vowsList
    }
}