//
//  FavouriteViewController.swift
//  MovieApp
//
//  Created by Asalah Sayed on 16/05/2023.
//

import UIKit
import CoreData
import SDWebImage

class FavouriteViewController: UITableViewController {
    var favouriteViewModel : FavouriteViewModel!
    var favouritesList : [NSManagedObject]?
    override func viewWillAppear(_ animated: Bool) {
        favouriteViewModel = FavouriteViewModel()
        favouriteViewModel.getFavouritesResult()
        favouritesList = favouriteViewModel.Result
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritesList?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteViewCell", for: indexPath) as! FavouriteViewCell
        let favouriteItem = favouritesList?[indexPath.row]
        let favouriteName = favouriteItem?.value(forKey: "title") as! String
        let favouriteImage = favouriteItem?.value(forKey: "image") as! String
        cell.movieImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.movieImage.sd_setImage(with: URL(string:favouriteImage), placeholderImage: UIImage(named: "placeholder"))
        cell.movieTitle.text = favouriteName
        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let favouriteItem = favouritesList?[indexPath.row]
        let favouriteName = favouriteItem?.value(forKey: "title") as! String
        
        if editingStyle == .delete {
            let alert : UIAlertController = UIAlertController(title: "Warnning", message: "Do You Want To Delete \(favouriteName)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler: { action in
                self.favouriteViewModel.deleteFavouriteItem(favouriteItem: favouriteItem!)
                self.favouriteViewModel.getFavouritesResult()
                self.favouritesList?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default , handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favouriteItem = favouritesList?[indexPath.row]
        let movie = Item(id: favouriteItem?.value(forKey: "id") as! String,
                         rank: favouriteItem?.value(forKey: "rank") as! String,
                         title: favouriteItem?.value(forKey: "title") as! String,
                         image: favouriteItem?.value(forKey: "image") as! String,
                         weekend: favouriteItem?.value(forKey: "weekend") as! String,
                         gross: favouriteItem?.value(forKey: "gross") as! String,
                         weeks: favouriteItem?.value(forKey: "weeks") as! String)
        let detailedViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as! DetailedViewController
        detailedViewController.movie = movie
        navigationController?.pushViewController(detailedViewController, animated: true)
            
    }
}
