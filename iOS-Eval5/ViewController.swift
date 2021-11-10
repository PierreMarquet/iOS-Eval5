//
//  ViewController.swift
//  iOS-Eval5
//
//  Created by Student05 on 10/11/2021.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {
  
    @IBOutlet var headerBackground: UIView!
    @IBOutlet var searchLabel: UILabel!
    @IBOutlet var movieSearchbar: UISearchBar!
    @IBOutlet var movieCollectionView: UICollectionView!
    
    var movieTab = [Results]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: movieCollectionView.frame.size.width, height: movieCollectionView.frame.size.height/4)
        movieCollectionView.collectionViewLayout = layout
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        movieCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    
    func setupView(){
        headerBackground.layer.cornerRadius = 25
    }
    
    func setupData() {
        
        AF.request("https://api.themoviedb.org/3/search/movie?api_key=b2168bae3a2c67509eb6b97572f521c2").response { DataResponse in
            
            switch DataResponse.result{
            case .success(let data):
                if let getData = data{
                    let decoder = JSONDecoder()
                    let results = try! decoder.decode(MovieData.self, from: getData)
                    self.movieTab = results.movieData
                    self.movieCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
        }
        
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieTab.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tab = movieTab[indexPath.row]
        
        let movieCell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        movieCell.setupCell(tab: tab)
        return movieCell
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 200, height: 200)
       }
     */
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailMovie = storyboard?.instantiateViewController(withIdentifier: "DetailMovie") as! DetailMovie
        
        navigationController?.pushViewController(detailMovie, animated: true)
    }
    
    /*
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            if(!(searchBar.text?.isEmpty)!){
                
                self.collectionView?.reloadData()
            }
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if(searchText.isEmpty){
                
                self.collectionView?.reloadData()
            }
        }
     */
}

