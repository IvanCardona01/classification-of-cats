class Vote: Codable{
    let breed: String
    var vows: Int 

    init(breed: String, voteValue: Int){
        self.breed = breed
        self.vows = voteValue
    }

    func addVote(voteValue: Int){
        vows += voteValue
    }
}