//
//  DetailViewController.swift
//  PassingData
//
//  Created by codenroot on 3/14/19.
//  Copyright © 2019 codenroot. All rights reserved.
//

import UIKit

class CreditCardDetailViewController: UIViewController {
    
    private lazy var cardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .lightGray
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
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.editCardButtonTapped(sender:)), for: .touchUpInside)
        button.setTitle("Edit Card", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.deleteCardButtonTapped(sender:)), for: .touchUpInside)
        button.setTitle("Delete Card", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public var cardDetail: CreditCard?
    public var delegate: CreditCardDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(cardStackView)
        cardStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        cardStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cardStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        cardStackView.addArrangedSubview(numberLabel)
        cardStackView.addArrangedSubview(typeLabel)
        
        view.addSubview(deleteButton)
        deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        view.addSubview(editButton)
        editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        editButton.bottomAnchor.constraint(equalTo: deleteButton.topAnchor).isActive = true
        
        guard let card = cardDetail else { return }
        numberLabel.text = card.number
        typeLabel.text = card.type
        // Do any additional setup after loading the view.
    }
    
    @objc func editCardButtonTapped(sender: UIButton) {
        guard let card = cardDetail else { return }
        var mutated = card
        mutated.number = "0"
        mutated.type = "Unkowned"
        delegate?.editCreditCard(card: card, mutated: mutated)
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func deleteCardButtonTapped(sender: UIButton) {
        guard let card = cardDetail else { return }
        delegate?.deleteCreditCard(card: card)
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }

}

