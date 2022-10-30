//
//  File.swift
//  Jokes
//
//  Created by Aklesh on 30/10/22.
//

import Foundation
import UIKit

class JokeTableViewCell: UITableViewCell {

    let jokeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
        jokeLabel.numberOfLines = 0
        jokeLabel.font = UIFont.systemFont(ofSize: 20)
        
        // Add the UI components
        contentView.addSubview(jokeLabel)
        
        NSLayoutConstraint.activate([
            jokeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            jokeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            jokeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            jokeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
