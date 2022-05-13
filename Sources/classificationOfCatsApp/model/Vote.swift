class Vote: Codable{
    let cat_id: String
    var vows: Int 

    init(cat_id: String, voteValue: Int){
        self.cat_id = cat_id
        self.vows = voteValue
    }

    func addVote(voteValue: Int){
        vows += voteValue
    }
}