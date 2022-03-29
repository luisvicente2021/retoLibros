//
// Api.swift
//  bookNews
//
//  Created by user209759 on 3/24/22.
//

import Foundation




final class ApiCaller{
    
    static let shared = ApiCaller()
    
    
    
    
    struct Constants {
        static let topHeadlinesURL = URL (string: "https://newsapi.org/v2/everything?q=tesla&from=2022-02-28&sortBy=publishedAt&apiKey=8164f3d5d95047939b61a9cdae36e3c7")
        
    }
    
    
    private init () {}
        
    public func getTopStories(completion:  @escaping(Result<[Article], Error>) ->Void ) {
        
        guard let completeURL = Constants.topHeadlinesURL else {
            // En caso de que no pudimos obtener el url invocamos el error.
            //onError(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: completeURL) { data,_,error in
           
            
            if let error = error {
               completion(.failure(error))
                print ("estas mallll perro")
                print(completeURL)
                
            }
            else if let data = data {
                
                do{
                    let result = try JSONDecoder().decode(ApiResponse.self, from: data)
                    
                    print("Noticias")
                    print ([result].count)
                    completion(.success(result.articles))
                }
                catch {
                    
                    print ("Estas mal perro")
                    completion(.failure(error))
                    
                }
                
            }
            
            
            
        }
        task.resume()
        
        
        
        
        
    }
    
        
    }
    
    
    

