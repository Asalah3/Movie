//
//  ViewModel.swift
//  MovieApp
//
//  Created by Asalah Sayed on 05/05/2023.
//

import Foundation
class ViewModel{
    var bindResultToViewController : (() ->()) = {}
    
    var vMResult : Movie!{
        didSet{
            bindResultToViewController()
        }
    }
    func getMovies(){
        NetworkServices.fetchResult{ (res) in
            guard let result = res else{return}
            self.vMResult = result
        }
    }
}
