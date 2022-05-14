import Foundation

class CatsVotingView{
    static let instance: CatsVotingView = CatsVotingView()
    let viewUtilities = ViewUtilities.instance
    let catDataService = CatDataService.instance
    var catIndexInTheListOfCats = 0
    var catsList: [Cat]?
    var vowsList: [Vote]?

    func loadTheVotingSystem(){
        viewUtilities.clearScreem()
        loadCatsList()
        loadVowsList()
        var exitOption = false
        repeat{
            print(loadCatProfile(catIndex: catIndexInTheListOfCats))
            let selectedOption = readLine()!
            let previousPageLimit = 0
            let nextPageLimit = catsList!.count - 1
            let actualPage = catIndexInTheListOfCats
            switch selectedOption{
                case "1": //Previous Cat
                    if actualPage == previousPageLimit{
                        print("Option is not available")
                    }else{
                        catIndexInTheListOfCats -= 1
                    }
                    break
                case "2": //Next Cat
                    if actualPage == nextPageLimit{
                        print("Option is not available")
                    }else{
                        catIndexInTheListOfCats += 1
                    }
                    break
                case "3": //Like
                    let newVote = 1
                    addVote(voteValue: newVote, catIndex: catIndexInTheListOfCats)
                    break
                case "4": //Dislike
                    let newVote = -1
                    addVote(voteValue: newVote, catIndex: catIndexInTheListOfCats)
                    break
                case "5": //Exit
                    exitOption = true
                    break
                default:
                    print("please select an available option")
                    readLine()!
                    break
            }
        }while exitOption == false
    }

    func loadCatsList(){
        do{
             catsList = try? catDataService.getCatsListOfUserDefaults();
             UserDefaults.standard.synchronize()
        }catch Errors.dataIsNotDecodable{
            print("Error trying to get cats list")
        }
    }

    func loadVowsList(){
        do{
             vowsList = try? catDataService.getVowsListOfUserDefaults();
             UserDefaults.standard.synchronize()
        }catch Errors.dataIsNotDecodable{
            print("Error trying to get cats list")
        }
    }

    func addVote(voteValue: Int, catIndex: Int){
        let breed = catsList![catIndex].name
        let voteSelected = getVoteExists(breed: breed)
        let voteExists = voteSelected != nil
        if (voteExists){
            voteSelected?.addVote(voteValue: voteValue)
        }else{
            let vote: Vote = Vote(breed: breed, voteValue: voteValue)
            vowsList?.append(vote)
        }

        do{
            try? catDataService.setVowsListInUserDefault(data: vowsList!)
        }catch Errors.dataIsNotEncodable{
            print("An unexpected error occurred while trying to save the data list")
        }
        UserDefaults.standard.synchronize()
    }

    func getVoteExists(breed:String) -> Vote?{
        if ((vowsList?.isEmpty) == nil) {
            return nil
        }else{
            for vote in vowsList!{
                if(vote.breed.elementsEqual(breed)){
                    return vote
                }
            }
            return nil
        }
    } 

    func loadCatProfile(catIndex: Int) -> String{
        viewUtilities.clearScreem()
        let catProfile = catsList![catIndex]
        var profile:String = "****************************\n" +
                             "* Name: \(catProfile.name)\n" +
                             "* Id: \(catProfile.id)\n" +
                             "* Origin: \(catProfile.origin)\n"
        if(catProfile.image != nil){
            profile.append("* Image: \(catProfile.image!.url!)\n" +
                             "****************************")
        }else{
            profile.append("****************************")
        }
        let previousPageLimit = 0
        let nextPageLimit = catsList!.count - 1
        let actualPage = catIndex 

        switch actualPage{
            case previousPageLimit:
                profile.append("\n                         \n" +
                               "                Next    2 ▶\n" +
                               "👍 3 Like       Dislike 4 👎\n" +
                               "        ❌ 5. Exit")
                break
            case nextPageLimit:
                profile.append("\n                         \n" +
                               "◀  1 Previous              \n" +
                               "👍 3 Like        Unlike 4 👎\n" +
                               "        ❌ 5. Exit")
                break
            default:
                profile.append("\n                         \n" +
                               "◀  1 Previous    Next 2   ▶\n" +
                               "👍 3 Like        Unlike 4 👎\n" +
                               "        ❌ 5. Exit")
                break        
        }
        return profile
    }
}