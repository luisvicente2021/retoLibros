//
//  DetailsViewController.swift
//  bookNews
//
//  Created by user209759 on 3/25/22.
//


import UIKit

class DetailsViewController: UIViewController {
    
    
    var articless = [Article]()
    
    var recibirTitle: String?
    var viewModels = [NewsTableViewCellViewModel]()
    static let identifier = "DetailsViewController"
   // init (articles : [Article]){
     //   self.articles = articles
       // super.init(nibName: nil, bundle: nil)
        
    //}
    
    //required init?(coder: NSCoder) {
     //   fatalError("init(coder:) has not been implemented")
   // }
    
    
    
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        label.text = recibirTitle
        
        
        
        
    
    }

   
}


