//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Hung Tran on 07/08/2023.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var bodyLable: UILabel!
    @IBOutlet weak var bubleView: UIView!
    
    
    var textBody: UILabel = {
        let lableView = UILabel()
        return lableView
    }()
    
    let avaImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "MeAvatar"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupUI(){
        addSubview(avaImageView)
        
        bubleView.translatesAutoresizingMaskIntoConstraints = false
        bodyLable.translatesAutoresizingMaskIntoConstraints = false
        //        avaImageView.translatesAutoresizingMaskIntoConstraints = false
        
        bubleView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        avaImageView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        avaImageView.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        bubleView.backgroundColor = .cyan
        bubleView.topAnchor.constraint(equalTo: topAnchor, constant: 0.0).isActive = true
        bubleView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10.0).isActive = true
        bubleView.rightAnchor.constraint(equalTo: avaImageView.leftAnchor, constant: -10.0).isActive = true
        bubleView.layer.cornerRadius = 10
        
        //        meAvataImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0.0).isActive = true
        //        meAvataImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        
        NSLayoutConstraint.activate([
            avaImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0.0),
            avaImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0)
        ])
    }
    
}
