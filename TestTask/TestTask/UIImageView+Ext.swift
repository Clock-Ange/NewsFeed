//
//  UIImageView+Ext.swift
//  TestTask
//
//  Created by Геннадий Махмудов on 21.09.2020.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView{
    
    var imageUrlString: String?
    
    func load(urlString: String){
        
        imageUrlString = urlString
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url){
                    if let image = UIImage(data: data){
                        DispatchQueue.main.async {
                            let imageToCache = image
                            if self?.imageUrlString == urlString {
                                self?.image = imageToCache
                            }
                            imageCache.setObject(imageToCache, forKey: urlString as NSString)
                        }
                    }
                }
            }
        }
    }
    
}
extension CustomImageView {
    
    func roundedImage(){
        self.layer.cornerRadius = self.frame.size.width / 2.0
        self.clipsToBounds = true
    }
    
}

