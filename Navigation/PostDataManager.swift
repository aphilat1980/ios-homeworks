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
    

//private var context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
    
static var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Navigation")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
    if let error = error as NSError? {
    fatalError("Unresolved error \(error), \(error.userInfo)")
    }
    })
    return container
    }()
    //создание контекста
lazy var backgroundContext: NSManagedObjectContext = {
    let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    context.persistentStoreCoordinator =
    PostDataManager.persistentContainer.persistentStoreCoordinator
    return context
    }()
    
    var postsUpdate: (()-> ())? //передача во вью состояния при сохранении поста
    var postDublicate: (()->())? //передача во вью состояния при дублировании поста

    init () {
        fetchSavedPosts()
    }
    
    var savedPosts: [SavedPost] = []
    
    func fetchSavedPosts () {
        
        let fetchRequest = SavedPost.fetchRequest()
        savedPosts = (try? backgroundContext.fetch(fetchRequest)) ?? []
    }
    
    func createSavedPost (author: String, myDescription: String, image: String, likes: Int, views: Int) {
        var contains = false
        for post in savedPosts {
            if post.image == image { 
                    contains = true
            }
        }
        
        if contains == true {
            postDublicate?()
                    
        } else {
            let newSavedPost = SavedPost(context: backgroundContext)
            newSavedPost.author = author
            newSavedPost.myDescription = myDescription
            newSavedPost.image = image
            newSavedPost.likes = Int64(likes)
            newSavedPost.views = Int64(views)
            try? backgroundContext.save()
            fetchSavedPosts()
            postsUpdate?()
                    
        }
    }
        

    
    func deletePost (index: Int) {
        
        backgroundContext.delete(savedPosts[index])
        try? backgroundContext.save()
        fetchSavedPosts()
        
    }
    
    func searchPost (author: String, completion: @escaping ( )-> Void) {
        let predicate = NSPredicate (format: "author CONTAINS[c] %@", author)
        //let predicate = NSPredicate(format: "author == %@", author)
        let fetchRequest = NSFetchRequest<SavedPost>(entityName: "SavedPost")
        fetchRequest.predicate = predicate
        do {
            savedPosts = try backgroundContext.fetch(fetchRequest)
            completion()
        } catch {
            print (error.localizedDescription)
        }
            
    }
    
    
}
