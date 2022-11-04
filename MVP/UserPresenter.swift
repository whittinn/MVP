//
//  UserPresenter.swift
//  MVP
//
//  Created by Nathaniel Whittington on 11/3/22.
//

import Foundation
import UIKit

protocol UserPresenterDelegate: AnyObject{
    
    func presentPosts(posts:[Posts])
    func presentAlert(title:String,message:String)
}

typealias PresenterDelegate = UserPresenterDelegate & UIViewController

class UserPresenter{
    

    weak var delegate: PresenterDelegate?
    
    public func setViewDelegate(delegate:PresenterDelegate){
        self.delegate = delegate
    }
    
    public func getData(){
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let urlSession = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let posts = try JSONDecoder().decode([Posts].self, from: data)
                self.delegate?.presentPosts(posts: posts)
                
            }catch{
                print(error)
                
            }
        
        }
        urlSession.resume()
    }
    
    public func didTap(post:Posts){
        delegate?.presentAlert(title: "This is the title : \(post.title)", message: "This is the body: \(post.body)")
        
    }
    
    
}
