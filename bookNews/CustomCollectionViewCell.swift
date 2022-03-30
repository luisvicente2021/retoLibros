//
//  NewsCollectionViewCell.swift
//  bookNews
//
//  Created by user209759 on 3/27/22.
//



import Foundation
import UIKit

class CustomCollectionViewCell : UICollectionViewCell{
    
    let identifier = "CustomCollectionVieCell"
    
     let newsImageVeiw: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    
    
    
     var  myLabel : UILabel = {
        
        let label = UILabel ()
        label.text = ""
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 10)
        return label
        
        
    }()
    

    override init(frame: CGRect){
        super.init(frame: frame)
        //contentView.backgroundColor = .systemBlue
        contentView.addSubview(newsImageVeiw)
        contentView.addSubview(myLabel)
        contentView.clipsToBounds = true
        
        

    }
    
    
    required init?(coder: NSCoder){
        fatalError()
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsImageVeiw.frame = CGRect(x : contentView.frame.size.width - 150, y:9, width: 140 , height: contentView.frame.size.height - 40)
        
       // myLabel.frame = CGRect(x : contentView.frame.size.width - 150, y:100, width: 140 , height: contentView.frame.size.height - 40)
        
        myLabel.addAnchorsAndSize(width: nil, height: nil, left: 0, top:10, right: nil, bottom: nil, withAnchor: .top, relativeToView: newsImageVeiw)
        
        
        
        
        
    }
    
    
    func configure(with viewModel: NewsTableViewCellViewModel){
        myLabel.text = viewModel.title
        //subTitleLabel.text = viewModel.subtitle
        
        // image
        
        if let data = viewModel.imageData{
            
            newsImageVeiw.image = UIImage(data: data)
            
        }
        
        else if let url = viewModel.imageURL{
            
            //fetch
            URLSession.shared.dataTask(with: url) { [weak self] data,_,error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageVeiw.image = UIImage(data: data)
                }
                
            }.resume()
            
        }
        
    }
    
    
   
    
    
    
    
}
