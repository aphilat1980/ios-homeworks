//
//  PostDataManager.swift
//  Navigation
//
//  Created by Александр Филатов on 27.06.2023.
//

import Foundation
import CoreData
import UIKit

class PostDataManager {

private var context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext

    
    init () {
        fetchSavedPosts()
    }
    
    var savedPosts: [SavedPost] = []
    
    func fetchSavedPosts () {
        
        let fetchRequest = SavedPost.fetchRequest()
        savedPosts = (try? context.fetch(fetchRequest)) ?? []
    }
    
    func createSavedPost (author: String, myDescription: String, image: String, likes: Int, views: Int ) {
        
        let newSavedPost = SavedPost(context: context)
        newSavedPost.author = author
        newSavedPost.myDescription = myDescription
        newSavedPost.image = image
        newSavedPost.likes = Int64(likes)
        newSavedPost.views = Int64(views)
        try? context.save()
        fetchSavedPosts()
    }
    
    func deletePost (index: Int) {
        
        context.delete(savedPosts[index])
        try? context.save()
        fetchSavedPosts()
        
    }
    
    
}
