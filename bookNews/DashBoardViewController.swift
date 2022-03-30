//
//  ViewController.swift
//  bookNews
//
//  Created by user209759 on 3/24/22.
//

import Foundation
import UIKit
import SafariServices
import FirebaseAuth
import Firebase

class DashBoardViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    
    static let identifierr = "DashBoardViewController"
    
    private lazy var segmentedControl: UISegmentedControl = { let sc = UISegmentedControl(items: ["Noticias","Imagenes","Salir"])
        sc.selectedSegmentIndex = 0
        sc.backgroundColor = Constants.Storyboard.kodemiaCyanFaded
        sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        return sc
    }()
    
   // var segmentedControl : UISegmentedControl?
    //sc = UISegmentedControl()
    //sc?.selectedSegmentIndex = 0
    //sc?.backgroundColor : .blue
    
    @objc fileprivate func handleSegmentChange () {
        print (segmentedControl.selectedSegmentIndex)
        
        
        if segmentedControl.selectedSegmentIndex == 0{
            
            
        }
        else if segmentedControl.selectedSegmentIndex == 1{
            hideTableView()
            let collection = CollectionViewController()
            collection.modalPresentationStyle = .fullScreen
            present(collection, animated: false, completion: nil)
            
        }
        else if segmentedControl.selectedSegmentIndex == 2{
            hideTableView()
            do{
                try FirebaseAuth.Auth.auth().signOut()
                let login = ViewController()
                login.modalPresentationStyle = .fullScreen
                present(login, animated: false, completion: nil)
                
            }catch {
                
                
            }
                
            
            
        }
    }
    
 
    private let tableView:UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        
        return table
    }()
    
     var articles = [Article]()
     var viewModels = [NewsTableViewCellViewModel]()
    var userLogin : UILabel?
     

    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "News"
        
        
        
        
       
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        userLogin = UILabel(frame: CGRect(x: width / 2, y: 20, width: width , height: 20 ))
        userLogin?.textColor = .red
        view?.addSubview(userLogin!)
        
        tableView.addAnchorsAndSize(width: nil, height: nil, left: 20, top: 60, right: 20, bottom: 90, withAnchor: nil, relativeToView: segmentedControl)
        view.backgroundColor = .white
        
        view.addSubview(segmentedControl)
        segmentedControl.addAnchors(left: 20, top: nil, right: 20, bottom: 70, withAnchor: nil, relativeToView: tableView)
        
        fetchTopStories ()
            
    }
    
    
            
            
        
        
        
       

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //tableView.frame = view.bounds
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
                    
                    self?.tableView.reloadData()
                    
                    
                }
                
                
                
            case .failure(let error):
                print ("error")
                
            }
            
            
        }
    }
        
        
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(
        withIdentifier: NewsTableViewCell.identifier,
        for: indexPath
       ) as? NewsTableViewCell else {
            fatalError()
            
        }
        
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //indexSelected = articles [indexPath.row]
        var articles = articles [indexPath.row]
        
        print ("Seleccionaste \(articles.title)")
        
        guard let url = URL (string: articles.url ?? "") else {
            
            return
            
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
        
        
        
       
    }
    
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 150
        
    }
    
    
    
    
    func hideTableView() {
        tableView.isHidden = true
    }
    
    
 
        
    }
    
    



