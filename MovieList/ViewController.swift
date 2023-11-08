//
//  ViewController.swift
//  MovieList
//
//  Created by Masud Onikeku on 07/11/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let viemodel = ViewModel()
    var popular: [Movie] = []
    var nowPlaying: [Movie] = []
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        setupUI()
        bind()
    
    }
    
    func setupUI() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let floLayout = UICollectionViewFlowLayout()
        floLayout.itemSize = CGSize(width: self.view.frame.width, height: 200)
        floLayout.scrollDirection
        
        
    }
    
    func setup() {
        
        viemodel.getKey()
        
    }
    
    
    func bind() {
        
        viemodel.genreResponse.bind(completion: {[weak self] response in
        
            if let response = response {
                
                if response.check {
                    
                    let genre = response.object as! [[String:Any]]
                    genres = genre
                    
                }
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    for views in self!.collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader) {
                        if let header = views as? HeaderView {
                            
                            header.collectionView.reloadData()
                        }
                    }
                }
            }
        })
        
        viemodel.keyResponse.bind(completion: {[weak self] response in
        
            if let response = response {
                
                print(response.object as! String)
                self?.viemodel.getNowPlaying()
                self?.viemodel.getPopular()
                
            }
        })
        
        viemodel.poModelResponse.bind(completion: {[weak self] response in
        
            if let response = response {
                
                if response.check {
                    
                    let movies = response.object as! [Movie]
                    self?.popular.append(contentsOf: movies)
                    //self?.popular.reverse()
                    
                }
                
                DispatchQueue.main.async {
                    
                    self?.collectionView.reloadData()
                }
                
                if genres == nil {
                    self?.viemodel.getGenres()
                }else {
                    
                    if let gen = genres {
                        
                        if gen.isEmpty {
                            
                            self?.viemodel.getGenres()
                        }
                    }
                }
                
            }
        })
        
        viemodel.nwModelResponse.bind(completion: {[weak self] response in
        
            if let response = response {
                
                if response.check {
                    
                    let movies = response.object as! [Movie]
                    self?.nowPlaying.append(contentsOf: movies)
                    
                }
                
                DispatchQueue.main.async {
                    for views in self!.collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader) {
                        if let header = views as? HeaderView {
                            
                            header.collectionView.reloadData()
                        }
                    }
                }
                
            }
        })
        
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return popular.count
        }else {
            return nowPlaying.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
            let data = popular[indexPath.row]
            cell.id = data.genre_ids ?? []
            cell.configure()
            cell.title.text = data.title
            cell.rating.text = String(data.vote_average ?? 0.0) + "/10"
            cell.durationText.text = "1h 47m"
            cell.image.setImageSd(url: APIList.imageUrl + (data.poster_path ?? ""))
            return cell
            
        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerViewCell", for: indexPath) as! HeaderViewCell
            let data = nowPlaying[indexPath.row]
            cell.id = data.genre_ids ?? []
            cell.configure()
            cell.title.text = data.title
            cell.rating.text = String(data.vote_average ?? 0.0) + "/10"
            cell.image.setImageSd(url: APIList.imageUrl + (data.poster_path ?? ""))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        let mov : Movie?
        if collectionView == self.collectionView {
            mov = popular[indexPath.row]
        }else {
            mov = nowPlaying[indexPath.row]
        }
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "details") as! DetailsViewController
        vc.movie = mov
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! HeaderView
        header.collectionView.delegate = self
        header.collectionView.dataSource = self
        if let layout = header.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        return header
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            return CGSize(width: self.view.frame.width - 100.0, height: 250)
        }else {
            return CGSize(width: self.view.frame.width - 40.0, height: 250)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if collectionView == self.collectionView {
            return CGSize(width: self.collectionView.frame.size.width, height: 354.0)
        }
        return CGSize.zero
    }
}

