//
//  DetailViewController.swift
//  TestTask
//
//  Created by Геннадий Махмудов on 26.09.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    
    var item: Item? {
        didSet{
            guard let item = item else {
                fatalError("The item has not been found.")
            }
            if let author = item.author {
                title = "\(author.name)'s post"
            }
            for content in item.contents {
                switch content.type {
                case "IMAGE":
                    if let small = content.data.small{
                        imageView.load(urlString: small.url)
                    }
                case "TEXT":
                    itemTextView.text = content.data.value
                default:
                    break
                }
            }
        }
    }
    
    let imageView: CustomImageView = {
        let imgView = CustomImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.backgroundColor = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 0.5)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let itemTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = "Something funny"
        textView.textAlignment = .left
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let itemTextWrapper: UIView = {
        let wrapper = UIView()
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        return wrapper
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = UIColor.white
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        itemTextWrapper.addSubview(itemTextView)
        
        NSLayoutConstraint.activate([
            itemTextView.topAnchor.constraint(equalTo: itemTextWrapper.topAnchor),
            itemTextView.bottomAnchor.constraint(equalTo: itemTextWrapper.bottomAnchor),
            itemTextView.leadingAnchor.constraint(equalTo: itemTextWrapper.leadingAnchor, constant: 10),
            itemTextView.trailingAnchor.constraint(equalTo: itemTextWrapper.trailingAnchor, constant: -10)
        ])
        
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(itemTextWrapper)
        
        stackView.setCustomSpacing(10, after: imageView)
        
    }
    
    
}
