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
    
    let youImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "YouAvatar"))
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
        addSubview(youImageView)
        
        youImageView.isHidden = true
        
        bubleView.translatesAutoresizingMaskIntoConstraints = false
        bodyLable.translatesAutoresizingMaskIntoConstraints = false
        
        //Constraint you avata image view
        NSLayoutConstraint.activate([
            youImageView.heightAnchor.constraint(equalToConstant: 40.0),
            youImageView.widthAnchor.constraint(equalToConstant: 40.0),
            youImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            youImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0)
        ])
        //constraint layout buble view
        bubleView.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            bubleView.heightAnchor.constraint(equalToConstant: 40.0),
            bubleView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            bubleView.leftAnchor.constraint(equalTo: youImageView.rightAnchor, constant: 10.0),
            bubleView.rightAnchor.constraint(equalTo: avaImageView.leftAnchor, constant: -10.0)
        ])
        //Constraint layout bodylabe
        NSLayoutConstraint.activate([
            bodyLable.leadingAnchor.constraint(equalTo: bubleView.leadingAnchor, constant: 8.0),
            bodyLable.centerYAnchor.constraint(equalTo: bubleView.centerYAnchor)
        ])
        //Constraint me avata image view
        NSLayoutConstraint.activate([
            avaImageView.heightAnchor.constraint(equalToConstant: 40.0),
            avaImageView.widthAnchor.constraint(equalToConstant: 40.0),
            avaImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            avaImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0)
        ])
        
        
    }
    
}
