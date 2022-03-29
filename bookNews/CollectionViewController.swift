//
//  CollectionViewController.swift
//  bookNews
//
//  Created by user209759 on 3/27/22.
//

import UIKit

class CollectionViewController: UIViewController{
    
    private  var collectionView: UICollectionView?
    private lazy var segmentedControl: UISegmentedControl = { let sc = UISegmentedControl(items: ["Noticias","Imagenes","Salir"])
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        return sc
    }()
    
    
    @objc fileprivate func handleSegmentChange () {
        print (segmentedControl.selectedSegmentIndex)
        
        
        if segmentedControl.selectedSegmentIndex == 0{
            let dash = DashBoardViewController()
            dash.modalPresentationStyle = .fullScreen
            present(dash, animated: true, completion: nil)
            
        }
        else if segmentedControl.selectedSegmentIndex == 1{
           // hideTableView()
           
            
        }
        else if segmentedControl.selectedSegmentIndex == 2{}
    }
    
    var  prueba = CustomCollectionViewCell()
    var articles = [Article]()
    var viewModels = [NewsTableViewCellViewModel]()
    var dashFetch = DashBoardViewController()
 
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(segmentedControl)
        
        
        segmentedControl.addAnchors(left: 20, top: nil, right: 20, bottom: 70, withAnchor: nil, relativeToView: nil)
        
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.itemSize = CGSize(width: view.frame.size.width / 2, height: view.frame.size.width / 2)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        
       
        collectionView.register (CustomCollectionViewCell.self, forCellWithReuseIdentifier: prueba.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
        
        
        
       
        
        collectionView.addAnchorsAndSize(width: nil, height: height / 5, left: 0, top: 50, right: 20, bottom: 120, withAnchor: nil, relativeToView: segmentedControl)
       
        fetchTopStories ()
    
        
    }
    
    
    
    
    func fetchTopStories (){
       
       ApiCaller.shared.getTopStories() { [weak self] result in
           
           switch result {
           case .success(let articles):
               self?.articles = articles
               self?.viewModels = articles.compactMap({
                   NewsTableViewCellViewModel (title: $0.title, subtitle: $0.description ?? "No Description", imageURL: URL (string: $0.urlToImage ?? ""))
               })
               DispatchQueue.main.async {
                   
                   self?.collectionView?.reloadData()
                   
                   
               }
               
               
               
           case .failure(let error):
               print ("error")
               
           }
           
           
       
       }
    

    
    

}



    
    
}


extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: prueba.identifier, for: indexPath) as! CustomCollectionViewCell
    
       
        cell.configure(with: viewModels[indexPath.row])
        print ("Peroo\(indexPath.row)")
        
        
        
       
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: width/3 - 20, height: height / 4 - 50)
    }
    
    
    
    
    
}


