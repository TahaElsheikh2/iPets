//
//  StoreRepo.swift
//  iPets
//
//  Created by Taha on 23/08/2023.
//


typealias CompletionHandler =  (Bool, AnyObject?) -> Void

class StoreRepo {


    /// Create & save story to database
    /// - Parameter story: story domain entity
//    func createStory(story: Story) {
//        do {
//            try DBManager.shared.storyDao.save(object: story)
//        } catch {
//        }
//    }


    /// fetch story by story number
    /// - Parameter storyNumber: storynumber
//    func fetchStoryByStoryNumber(storyNumber: String) -> Story? {
//        return DBManager.shared.storyDao.findById(storyNumber: storyNumber)
//    }


    /// fetch stories from API
    /// - Parameter username: user
    /// - Parameter limit: limit
    /// - Parameter pageNumber: pageNumber for pagination
    /// - Parameter completion: completion
    var storyStore :NetworkManager<[Story]> = NetworkManager()

    func fetchStoriesByUsername(username: String, limit: Int?, pageNumber: Int, successCompletion: @escaping ([Story]?) -> Void, failureCompletion: @escaping (String) -> Void) {
        let request = StoryRequestBuilder.first
        
        storyStore.callApi(request: request) { (apiResponse) in
            if apiResponse.success {
                successCompletion(apiResponse.data)
                print("fetchStoriesByUsername Success = \(apiResponse.data)")
            } else {
                failureCompletion(apiResponse.message ?? "error")
                print("fetchStoriesByUsername Failer = \(apiResponse.message)")
            }
        }
    }

}
