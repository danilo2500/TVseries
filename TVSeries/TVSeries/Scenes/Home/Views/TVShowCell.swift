//
//  TVShowCell.swift
//  TVSeries
//
//  Created by Danilo Henrique on 16/04/22.
//

import UIKit

class TVShowCell: UITableViewCell {
    
    //MARK: - Constants
    
    private let minimumSpacing: CGFloat = 22
    
    //MARK: - UI Elements
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .light)
        label.textColor = .white
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Functions
    
    private func setUpUI() {
        backgroundColor = .clear
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(posterImageView)
        addConstraints([
            posterImageView.heightAnchor.constraint(equalToConstant: 160),
            posterImageView.widthAnchor.constraint(equalToConstant: 110),
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: minimumSpacing),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: minimumSpacing),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -minimumSpacing),
        ])

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        addConstraints([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: minimumSpacing),
            nameLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: minimumSpacing),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -minimumSpacing),
        ])
    }
}
