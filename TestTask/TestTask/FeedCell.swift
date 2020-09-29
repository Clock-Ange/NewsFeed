//
//  FeedCell.swift
//  TestTask
//
//  Created by Геннадий Махмудов on 21.09.2020.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    var item: Item?{
        didSet{
            guard let item = item else{return}
            if let author = item.author{
                let newName = author.name.components(separatedBy: "\n").joined()
                nameLabel.text = newName
            }
            
            
            
            for content in item.contents {
                switch content.type {
                case "IMAGE":
                    if let small = content.data.small{
                        statusImageView.load(urlString: small.url)
                    }
                case "TEXT":
                    statusTextView.text = content.data.value
                default:
                    break
                }
            }
            
            if let author = item.author{
                let newName = author.name.components(separatedBy: "\n").joined()
                let attributedText = NSMutableAttributedString(string: newName, attributes:[ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
                
                let date = Date(timeIntervalSince1970: TimeInterval(item.createdAt/1000))
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let minutes = calendar.component(.minute, from: date)
                let day = calendar.component(.day, from: date)
                let month = calendar.component(.month, from: date)
                let year = calendar.component(.year, from: date)
                
                
                attributedText.append(NSAttributedString(string: "\n\(hour):\(minutes)  •  \(day).\(month).\(year)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)]))
                nameLabel.attributedText = attributedText
            }
            
            
            if let photo = item.author?.photo{
                if let original = photo.data.original{
                    profileImageView.load(urlString: original.url)
                }
            } else {
                profileImageView.image = UIImage(named: "noAvatar")
            }
            
            likesCommentsLabel.text = "\(item.stats.likes.count) 🤍      \(item.stats.comments.count) 💬"
            
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Sample Text"
        let attributedText = NSMutableAttributedString(string: "Sample Text", attributes:[ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "\nSeptember 24", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)]))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Trying to implement the TEXT field"
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let statusImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.text = "10 likes     2 comments"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.roundedImage()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        
        
        
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-8-[v2(150)]-8-[v3(30)]-8-|", views: profileImageView, statusTextView, statusImageView, likesCommentsLabel)
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "H:|-20-[v0]|", views: likesCommentsLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



