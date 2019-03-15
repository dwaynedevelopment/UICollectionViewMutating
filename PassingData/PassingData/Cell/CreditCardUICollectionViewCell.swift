//
//  CreditCardUICollectionViewCell.swift
//  PassingData
//
//  Created by codenroot on 3/14/19.
//  Copyright © 2019 codenroot. All rights reserved.
//

import UIKit

class CreditCardUICollectionViewCell: UICollectionViewCell {
    
    private var cardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public var numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(cardStackView)
        cardStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0).isActive = true
        cardStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1.0).isActive = true
        cardStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cardStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        cardStackView.addArrangedSubview(numberLabel)
        cardStackView.addArrangedSubview(typeLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("No decoder: aDecoder")
    }
}
