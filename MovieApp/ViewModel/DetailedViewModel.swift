//
//  DetailedViewModel.swift
//  MovieApp
//
//  Created by Asalah Sayed on 16/05/2023.
//

import Foundation
class DetailedViewModel{
    func deleteItemById(favouriteId : String){
        FavouriteItems.favouriteItems.deleteItemById(favouriteId: favouriteId)
    }
    func insertItem(favouriteItem : Item){
        FavouriteItems.favouriteItems.InsertItem(favouriteMovie: favouriteItem)
    }
    func isExist(favouriteId : String) -> Bool{
        return FavouriteItems.favouriteItems.checkIfInserted(favouriteId: favouriteId)
    }
    
}
