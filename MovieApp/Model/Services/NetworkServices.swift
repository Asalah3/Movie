//
//  NetworkServices.swift
//  MovieApp
//
//  Created by Asalah Sayed on 02/05/2023.
//

import Foundation
protocol NetworkServicesProtocol {
    static func fetchResult(compilitionHandler : @escaping (Movie?)-> Void)
}
class NetworkServices : NetworkServicesProtocol{
    static func fetchResult(compilitionHandler : @escaping (Movie?)-> Void){
        let url = URL(string: "https://imdb-api.com/en/API/BoxOffice/k_2r19fbjc")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(Movie.self, from: data!)
                compilitionHandler(result)
            }catch let error{
                print(error.localizedDescription)
                compilitionHandler(nil)
            }
            
        }
        task.resume()
        
    }
}
