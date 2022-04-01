//
//  Model.swift
//  bookNews
//
//  Created by user209759 on 3/24/22.

// here make the model for Json

import Foundation


struct ApiResponse : Codable {
    
    var articles: [Article]
    
    
}

struct Article: Codable {
    let source: Source
    let title : String
    let description: String?
    let url : String?
    let urlToImage: String?
    let publishedAt: String
    
}



struct Source : Codable{
    
    let name: String
    
}

 

