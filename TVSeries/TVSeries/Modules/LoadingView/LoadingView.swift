//
//  LoadingView.swift
//  TVSeries
//
//  Created by Danilo Henrique on 18/04/22.
//

import UIKit

class LoadingView: UIView {
    
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.layer.cornerRadius = 15
        activity.startAnimating()
        activity.backgroundColor = .white
        return activity
    }()
        
    //MARK: Object Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: Public Functions
    
    func showOnView(_ view: UIView) {
        backgroundColor = .black.withAlphaComponent(0)
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
        ])
        
        alpha = 1
        UIView.animate(withDuration: 0.5) {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    //MARK: Private Functions
    
    func setup() {
        showActivityIndicator()
    }
    
    private func showActivityIndicator() {
        addSubview(activity)
        activity.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            activity.centerXAnchor.constraint(equalTo: centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: centerYAnchor),
            activity.heightAnchor.constraint(equalToConstant: 100),
            activity.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
}
