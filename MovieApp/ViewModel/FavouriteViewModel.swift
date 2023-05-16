//
//  FavouriteViewModel.swift
//  MovieApp
//
//  Created by Asalah Sayed on 16/05/2023.
//

import Foundation
import CoreData
class FavouriteViewModel{
    var Result : [NSManagedObject] = []
    
    func getFavouritesResult(){
        self.Result = FavouriteItems.favouriteItems.fetchFavouriteItems()
        print("Result =  \(Result.count)")
    }
    
    func deleteFavouriteItem(favouriteItem : NSManagedObject){
        FavouriteItems.favouriteItems.deleteItem(favouriteItem: favouriteItem)
    }
}
