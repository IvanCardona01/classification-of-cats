import Foundation

class CatsVotingView{
    static let instance: CatsVotingView = CatsVotingView()
    let presenter = Presenter.instance
    var catIndexInTheListOfCats = 0
    var catsList: [Cat]?
    var vowsList: [Vote]?

    func loadTheVotingSystem(){
        ViewUtilities.clearScreem()

        guard let cats = presenter.getCatsList() else {
            print("Error loading the data of cats")
            return
        }
        catsList = cats
        guard let vows = presenter.getVowsList() else {
            print("Error loading the data of cats")
            return
        }
        vowsList = vows

        var exitOption = false
        repeat{

            let previousPageLimit = 0
            guard let cats = catsList else {
                print("Cats data is not available")
                return
            }
            let nextPageLimit = cats.count - 1
            let isLastVote = catIndexInTheListOfCats == nextPageLimit 

            if isLastVote{
                catIndexInTheListOfCats = 0
            }

            let actualPage = catIndexInTheListOfCats

            print(loadCatProfile(catIndex: catIndexInTheListOfCats))
            guard let selectedOption = readLine() else {
                print("Text input error")
                return 
            }

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
                    catIndexInTheListOfCats += 1
                    break
                case "4": //Dislike
                    let newVote = -1
                    addVote(voteValue: newVote, catIndex: catIndexInTheListOfCats)
                    catIndexInTheListOfCats += 1
                    break
                case "5": //Exit
                    exitOption = true
                    break
                default:
                    print("please select an available option")
                    guard let _ = readLine() else {
                        return
                    }
                    break
            }
        }while exitOption == false
    }

    func addVote(voteValue: Int, catIndex: Int){

        guard let breed = catsList?[catIndex].name else {
            print("Cat is not available")
            return
        }

        let voteSelected = getVoteExists(breed: breed)
        let voteExists = voteSelected != nil
        if (voteExists){
            voteSelected?.addVote(voteValue: voteValue)
        }else{
            let vote: Vote = Vote(breed: breed, voteValue: voteValue)
            vowsList?.append(vote)
        }
        guard let vows = vowsList else{
            print("Error loading vows")
            return
        }
        presenter.updateVowsLit(newVows: vows)
    }

    func getVoteExists(breed:String) -> Vote?{
        guard let vows = vowsList else {
            print("Cats data is not available")
            return nil
        }
        for vote in vows{
            if(vote.breed.elementsEqual(breed)){
                return vote
            }
        }
        return nil
    } 

    func loadCatProfile(catIndex: Int) -> String{
        ViewUtilities.clearScreem()
        guard let catProfile = catsList?[catIndex] else {
            print("Error loading cat perfil")
            return ""
        }
        var profile:String = "****************************\n" +
                             "* Name: \(catProfile.name)\n" +
                             "* Id: \(catProfile.id)\n" +
                             "* Origin: \(catProfile.origin)\n"
        if let image = catProfile.image {
            profile.append("* Image: \(image.url)\n" +
                             "****************************")
        }else{
            profile.append("****************************")
        }
        let previousPageLimit = 0
        guard let nextPageLimitTest = catsList else{
            print("cats list not found")
            return ""
        }
        let nextPageLimit = nextPageLimitTest.count - 1
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