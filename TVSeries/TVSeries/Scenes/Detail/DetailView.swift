//
//  DetailView.swift
//  TVSeries
//
//  Created by Danilo Henrique on 17/04/22.
//

import Foundation
import UIKit

class DetailView: UIView {
    
    //MARK: - Constants
    
    private let minimumSpacing: CGFloat = 20
    
    //MARK: - UI Elements
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var airedDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    lazy var summaryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Summary"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    lazy var seasonsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.bounces = false
        return tableView
    }()
    
    let scrollView = UIScrollView()
    
    let contentView: UIView = {
        let view = UIView()
        return view
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
        backgroundColor = .black
        
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
        ])
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: minimumSpacing),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: minimumSpacing),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 150),
        ])
        
        contentView.addSubview(genresLabel)
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            genresLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: minimumSpacing),
            genresLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            genresLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -minimumSpacing)
        ])
        
        contentView.addSubview(airedDateLabel)
        airedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            airedDateLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: minimumSpacing),
            airedDateLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: minimumSpacing),
            airedDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -minimumSpacing),
        ])
        
        contentView.addSubview(summaryTitleLabel)
        summaryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            summaryTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: minimumSpacing),
            summaryTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: minimumSpacing),
            summaryTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -minimumSpacing),
        ])
        
        contentView.addSubview(summaryLabel)
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            summaryLabel.topAnchor.constraint(equalTo: summaryTitleLabel.bottomAnchor, constant: minimumSpacing),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: minimumSpacing),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -minimumSpacing),
        ])
        
        contentView.addSubview(seasonsTableView)
        seasonsTableView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            seasonsTableView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: minimumSpacing),
            seasonsTableView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            seasonsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            seasonsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            seasonsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
