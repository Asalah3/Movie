//
//  ViewController.swift
//  MovieApp
//
//  Created by Asalah Sayed on 02/05/2023.
//

import UIKit
import SDWebImage


class ViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    var viewModel : ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        viewModel = ViewModel()
        viewModel.getMovies()
        viewModel.bindResultToViewController = {() in
            self.renderView()
        }
    }
    func renderView() {
        DispatchQueue.main.async {
            self.movieList = self.viewModel.vMResult
            self.collectionView.reloadData()
        }
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    var movieList : Movie?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList?.items.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell
        cell?.layer.borderWidth = 1
        cell?.layer.cornerRadius = 25
        cell?.layer.borderColor = UIColor.blue.cgColor
        cell?.movieImage.layer.cornerRadius = 25
        cell?.movieImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell?.movieImage.sd_setImage(with: URL(string: (movieList?.items[indexPath.row].image)!), placeholderImage: UIImage(named: "placeholder"))
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-20)/2
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController
        detailedViewController?.movie = movieList?.items[indexPath.row]
        navigationController?.pushViewController(detailedViewController!, animated: true)
        
    }
    
    


}

