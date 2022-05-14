struct Cat: Codable {
    var id: String
    var name: String
    var description: String
    var origin: String
    var image:Image?
}    

struct Image: Codable{
    let url: String
}