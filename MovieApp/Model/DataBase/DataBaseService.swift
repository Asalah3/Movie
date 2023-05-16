//
//  DataBaseService.swift
//  MovieApp
//
//  Created by Asalah Sayed on 16/05/2023.
//

import Foundation
import UIKit
import CoreData
class FavouriteItems{
    var context : NSManagedObjectContext?
    var entity : NSEntityDescription?
    static var favouriteItems = FavouriteItems()
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "FavouriteMovie", in: context!)
    }
    
    
    func InsertItem(favouriteMovie : Item){
        let newTeam = NSManagedObject(entity: entity!, insertInto: context)
        newTeam.setValue(favouriteMovie.id, forKey: "id")
        newTeam.setValue(favouriteMovie.title, forKey: "title")
        newTeam.setValue(favouriteMovie.gross, forKey: "gross")
        newTeam.setValue(favouriteMovie.image, forKey: "image")
        newTeam.setValue(favouriteMovie.rank, forKey: "rank")
        newTeam.setValue(favouriteMovie.weekend, forKey: "weekend")
        newTeam.setValue(favouriteMovie.weeks, forKey: "weeks")
        
        do {
            try context?.save()
         } catch {
          print("Error saving")
        }
    }
    
    func deleteItem(favouriteItem : NSManagedObject){
        do {
            context?.delete(favouriteItem)
            try context?.save()
        } catch {
            print("Failed")
            
        }
    }
    func deleteItemById(favouriteId : String){
        var favouriteItem : NSManagedObject?
        var favouritesList : [NSManagedObject]?
        favouritesList = FavouriteItems.favouriteItems.fetchFavouriteItems()
        favouritesList?.forEach{ data in
            let favId = data.value(forKey: "id") as! String
            if favId == favouriteId{
                favouriteItem = data
                do {
                    context?.delete(favouriteItem!)
                    try context?.save()
                } catch {
                    print("Failed")
                    
                }
            }
        }
        
    }
    
    func fetchFavouriteItems() -> [NSManagedObject]{
        var favouritesList : [NSManagedObject]?
        favouritesList = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteMovie")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context?.fetch(request)
            for data in result as! [NSManagedObject]{
                favouritesList?.append(data)
            }
        } catch {
            print("Failed")
        }
        return favouritesList!
    }
    
    func checkIfInserted(favouriteId : String) -> Bool {
        var result = false
        var favouritesList : [NSManagedObject]?
        favouritesList = FavouriteItems.favouriteItems.fetchFavouriteItems()
        favouritesList?.forEach{ data in
            let favId = data.value(forKey: "id") as! String
            if favId == favouriteId{
                result =  true
            }
        }
        return result
    }
    
}
