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

    
    lazy var activiyIndicator: UIActivityIndicatorView = {
        let activiyIndicator = UIActivityIndicatorView()
        activiyIndicator.startAnimating()
        activiyIndicator.style = .whiteLarge
        activiyIndicator.hidesWhenStopped = true
        return activiyIndicator
    }()
    
//    lazy var stackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [nameLabel, starImageView])
//        stackView.alignment = .top
//        return stackView
//    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .light)
        label.textColor = .white
        return label
    }()
        
    var starWidthConstraint: NSLayoutConstraint?
    lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "filled-star")
        return imageView
    }()
    
    //MARK: - Initialization
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        posterImageView.image = nil
        activiyIndicator.startAnimating()
        starWidthConstraint?.constant = 0
    }
    
    //MARK: - Private Functions
    
    private func setUpUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(posterImageView)
        let heightConstraint = posterImageView.heightAnchor.constraint(equalToConstant: 150)
        heightConstraint.priority = .defaultHigh
        addConstraints([
            heightConstraint,
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: minimumSpacing),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: minimumSpacing),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -minimumSpacing),
        ])
        
        activiyIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activiyIndicator)
        addConstraints([
            activiyIndicator.centerXAnchor.constraint(equalTo: posterImageView.centerXAnchor),
            activiyIndicator.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor)
        ])

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        addConstraints([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: minimumSpacing),
            nameLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: minimumSpacing),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: minimumSpacing)
        ])
        
        addSubview(starImageView)
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            starImageView.heightAnchor.constraint(equalToConstant: 40),
            starImageView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: minimumSpacing),
            starImageView.topAnchor.constraint(equalTo: topAnchor, constant: minimumSpacing),
            starImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -minimumSpacing),
        ])
        starWidthConstraint = starImageView.widthAnchor.constraint(equalToConstant: 0)
        starWidthConstraint?.isActive = true
    }
    
    func showFavorite(animated: Bool) {
//        setNeedsUpdateConstraints()
        self.starWidthConstraint?.constant = 40
        if animated {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut) {
                self.layoutIfNeeded()
            }
        }
    }
    
    func removeFavorite(animated: Bool) {
//        setNeedsUpdateConstraints()
        self.starWidthConstraint?.constant = 0
        if animated {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut) {
                self.layoutIfNeeded()
            }
        }
    }
}
