//
//  ViewController.swift
//  PassingData
//
//  Created by codenroot on 3/14/19.
//  Copyright © 2019 codenroot. All rights reserved.
//

import UIKit

class CreditCardListViewController: UIViewController {
    
    private lazy var cardCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CreditCardUICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    private var arrayOfCards: [CreditCard] =  [
            CreditCard(number: "4242424242424242", type: "visa"),
            CreditCard(number: "5555555555554444", type: "mastercard"),
            CreditCard(number: "378282246310005", type: "amex"),
            CreditCard(number: "6011111111111117", type: "discover"),
            CreditCard(number: "30569309025904", type: "diners"),
            CreditCard(number: "3566002020360505", type: "jcb"),
            CreditCard(number: "6200000000000005", type: "union")
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Credit Cards"
        navigationController!.navigationBar.tintColor = .purple
        view.backgroundColor = .white
        view.addSubview(cardCollection)
        cardCollection.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
        cardCollection.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1.0).isActive = true
        cardCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardCollection.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        cardCollection.collectionViewLayout.invalidateLayout()
    }
}

extension CreditCardListViewController: CreditCardDelegate {
    
    func editCreditCard(card: CreditCard, mutated: CreditCard) {
        if arrayOfCards.contains(where: { (oldCard) -> Bool in return card == oldCard }) {
            arrayOfCards = arrayOfCards.map {
                var mutableBook = $0
                if $0.number == card.number {
                    mutableBook = mutated
                    DispatchQueue.main.async { [weak self] in
                        self?.cardCollection.reloadData()
                    }
                }
                return mutableBook
            }
        }
    }
    
    func deleteCreditCard(card: CreditCard) {
        arrayOfCards = arrayOfCards.filter { $0.number != card.number }
        DispatchQueue.main.async { [weak self] in
            self?.cardCollection.reloadData()
        }
    }
    
}

extension CreditCardListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.9, height: collectionView.frame.height * 0.07)
    }
    
}

extension CreditCardListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cardCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CreditCardUICollectionViewCell
            else { return UICollectionViewCell() }
        cell.numberLabel.text = arrayOfCards[indexPath.row].number
        cell.typeLabel.text = arrayOfCards[indexPath.row].type
        return cell
    }
    
}

extension CreditCardListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = CreditCardDetailViewController()
        detailController.delegate = self
        detailController.cardDetail = arrayOfCards[indexPath.row]
        navigationController!.pushViewController(detailController, animated: true)
    }

}



