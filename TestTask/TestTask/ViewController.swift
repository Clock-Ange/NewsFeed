//
//  ViewController.swift
//  TestTask
//
//  Created by Геннадий Махмудов on 21.09.2020.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    enum orderBy: String{
        case mostPopular = "mostPopular"
        case mostCommented = "mostCommented"
        case createdAt = "createdAt"
    }
    
    var loadedData: LoadedData?
    var loadedItems = [Item]()
    var isLoading = false
    var state = orderBy.mostPopular
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(chooseOption))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [barButtonItem, spacer]
        navigationItem.rightBarButtonItem?.tintColor = .lightText
        
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        title = "Feed"
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView?.alwaysBounceVertical = true
        
        let decoder = JSONDecoder()
        decoder.getResponse(LoadedData.self, from: "http://stage.apianon.ru:3000/fs-posts/v1/posts?first=20&orderBy=\(orderBy.mostPopular)") { (dowloadedData) in
            self.loadedData = dowloadedData
            self.loadedItems = dowloadedData.data.items
            self.collectionView.reloadData()
        }
        
    }
    
    @objc func chooseOption(){
        let decoder = JSONDecoder()
        let ac = UIAlertController(title: "Choose an option", message: "How do you want your feed to be displayed?", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Most Popular", style: .default, handler: { [weak self](_) in
            decoder.getResponse(LoadedData.self, from: "http://stage.apianon.ru:3000/fs-posts/v1/posts?first=20&orderBy=\(orderBy.mostPopular)") { (dowloadedData) in
                self?.loadedData = dowloadedData
                self?.loadedItems = dowloadedData.data.items
                self?.state = orderBy.mostPopular
                self?.collectionView.reloadData()
            }
        }))
        ac.addAction(UIAlertAction(title: "Most Commented", style: .default, handler: { [weak self](_) in
            decoder.getResponse(LoadedData.self, from: "http://stage.apianon.ru:3000/fs-posts/v1/posts?first=20&orderBy=\(orderBy.mostCommented)") { (dowloadedData) in
                self?.loadedData = dowloadedData
                self?.loadedItems = dowloadedData.data.items
                self?.state = orderBy.mostCommented
                self?.collectionView.reloadData()
            }
        }))
        ac.addAction(UIAlertAction(title: "Created At", style: .default, handler: { [weak self](_) in
            decoder.getResponse(LoadedData.self, from: "http://stage.apianon.ru:3000/fs-posts/v1/posts?first=20&orderBy=\(orderBy.createdAt)") { (dowloadedData) in
                self?.loadedData = dowloadedData
                self?.loadedItems = dowloadedData.data.items
                self?.state = orderBy.createdAt
                self?.collectionView.reloadData()
            }
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let post = loadedItems[indexPath.item]
        if let statusText = post.contents[1].data.value {
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], context: nil)
            let knownHeight: CGFloat = 8 + 44 + 4 + 8 + 150 + 8 + 30 + 8
            return CGSize(width: view.frame.width, height: rect.height + knownHeight)
        }
        
        return CGSize(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loadedItems.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? FeedCell else{
            fatalError("Could not create cell.")
        }
        let post = loadedItems[indexPath.item]
        cell.item = post
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.item = loadedItems[indexPath.item]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == loadedItems.count - 1 && !isLoading {
            loadMoreData()
        }
    }
    func loadMoreData() {
        let decdoder = JSONDecoder()
        if let loadedData = loadedData {
            if let cursor = loadedData.data.cursor{
                if !self.isLoading {
                    self.isLoading = true
                    DispatchQueue.global().async {
                        
                        sleep(1)
                        
                        DispatchQueue.main.async {
                            decdoder.getResponse(LoadedData.self, from: "http://stage.apianon.ru:3000/fs-posts/v1/posts?first=20&after=\(cursor)&orderBy=\(self.state)") { (downloadedData) in
                                self.loadedData = downloadedData
                                self.loadedItems += downloadedData.data.items
                                self.collectionView.reloadData()
                            }
                            
                            self.isLoading = false
                        }
                    }
                }
            }
        }
    }
    
    
}


extension JSONDecoder{
    
    func getResponse<T: Codable>(_ type: T.Type, from url: String, completeion: @escaping (T) -> ())
    {
        DispatchQueue.global().async {
            guard let url = URL(string: url) else {
                fatalError("Failed to load URL.")
            }
            
            guard let data = try? Data(contentsOf: url) else{
                //fatalError("Failed to load data.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let downloadedData = try decoder.decode(type, from: data)
                DispatchQueue.main.async {
                    completeion(downloadedData)
                }
            }catch{
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    //    func getResponse(){
    //        DispatchQueue.global().async {
    //            guard let url = URL(string: "http://stage.apianon.ru:3000/fs-posts/v1/posts") else{
    //                return
    //            }
    //
    //            let session = URLSession.shared
    //            session.dataTask(with: url) { (data, response, error) in
    //
    //                if let response = response {
    //                    print(response)
    //                }
    //                guard let data = data else {return}
    //                print(data)
    //
    //                do{
    //                    let loadedData = try JSONDecoder().decode(LoadedData.self, from: data)
    //                    DispatchQueue.main.async {
    //                        self.loadedItems = loadedData.data.items
    //
    //                    }
    //
    //                }catch{
    //                    print(error)
    //                }
    //            }.resume()
    //        }
    //
    //
    //    }
    
}







