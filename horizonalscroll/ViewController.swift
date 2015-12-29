//
//  ViewController.swift
//  horizonalscroll
//
//  Created by Alex Fu on 12/28/15.
//  Copyright © 2015 Everseat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    let data = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.blueColor()
        collectionView.collectionViewLayout = UICollectionViewHorizontalLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        if let label = cell.subviews[0].subviews[0] as? UILabel {
            label.text = data[indexPath.row];
        }
        return cell
    }
}
