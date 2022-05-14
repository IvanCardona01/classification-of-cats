struct KeysOfUserDefaults {
    static let instance: KeysOfUserDefaults = KeysOfUserDefaults()
    private let catsList: String = "getCatsList"
    private let vowsList: String = "getVowsList"

    func getKeyOfCatsList() -> String{
        return catsList
    }

    func getKeyOfVowsList() -> String{
        return vowsList
    }
}