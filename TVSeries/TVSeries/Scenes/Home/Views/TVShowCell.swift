//
//  TVShowCell.swift
//  TVSeries
//
//  Created by Danilo Henrique on 16/04/22.
//

import UIKit

class TVShowCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var genresLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Functions
    
    private func setUpUI() {
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//
//        addConstraints([
//            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
//            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
//            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
//            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
//        ])
        contentView.backgroundColor = .red

        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addConstraints([
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        ])

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        addConstraints([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
}
