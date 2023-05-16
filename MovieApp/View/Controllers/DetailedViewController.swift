//
//  DetailedViewController.swift
//  MovieApp
//
//  Created by Asalah Sayed on 02/05/2023.
//

import UIKit
import Cosmos
import SDWebImage

class DetailedViewController: UIViewController {
    var movie : Item?
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieGross: UILabel!
    @IBOutlet weak var movieWeeks: UILabel!
    @IBOutlet weak var movieWeekend: UILabel!
    @IBOutlet weak var movieRank: CosmosView!
    var detailedViewModel:DetailedViewModel!
    override func viewWillAppear(_ animated: Bool) {
        detailedViewModel = DetailedViewModel()
        if detailedViewModel.isExist(favouriteId: movie?.id ?? ""){
            self.saveBtn.tintColor = UIColor.red
            saveBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        detailedViewModel = DetailedViewModel()
        
        movieImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        movieImage.sd_setImage(with: URL(string: movie!.image), placeholderImage: UIImage(named: "placeholder"))
        movieName.text = movie?.title
        movieGross.text = movie?.gross
        movieWeeks.text = movie?.weeks
        movieWeekend.text = movie?.weekend
        let rank = Double(movie!.rank)
        movieRank.rating = rank!
        movieRank.text = movie?.rank
    }
    

    
    @IBAction func addFavourite(_ sender: Any) {
        if detailedViewModel.isExist(favouriteId: movie?.id ?? ""){
            let alert = UIAlertController(title: "Alert!", message: "Do you want to delete \((self.movie?.title)!) ",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete",style: .destructive,handler: {(_: UIAlertAction!) in
                self.detailedViewModel.deleteItemById(favouriteId: self.movie?.id ?? "")
                self.saveBtn.tintColor = UIColor.blue
                self.saveBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            }))
            alert.addAction(UIAlertAction(title: "No",style: .cancel,handler: {(_: UIAlertAction!) in
                alert.dismiss(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        else {
            let alert = UIAlertController(title: "Saving!", message: "Do you want to save this \(self.movie?.title ?? "")",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes",style: .default,handler: {(_: UIAlertAction!) in
                self.detailedViewModel.insertItem(favouriteItem: self.movie!)
                self.saveBtn.tintColor = UIColor.red
                self.saveBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                
            }))
            alert.addAction(UIAlertAction(title: "No",style: .cancel,handler: {(_: UIAlertAction!) in
                alert.dismiss(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}
