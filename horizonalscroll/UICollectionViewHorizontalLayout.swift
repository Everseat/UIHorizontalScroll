//
// Created by Alex Fu on 12/28/15.
// Copyright (c) 2015 Everseat. All rights reserved.
//

import UIKit

class UICollectionViewHorizontalLayout : UICollectionViewLayout {
    var itemsPerPage = 0;
    var itemSize = CGFloat(100);
    var itemSpacing = CGFloat(10);
    var attributes = [UICollectionViewLayoutAttributes]();
    var page = 0;
    var maxPages = 0;

    override func prepareLayout() {
        guard let cv = collectionView else {
            return;
        }


        let itemCount = cv.numberOfItemsInSection(0)
        itemsPerPage = Int(cv.bounds.size.width / itemSize)
        maxPages = itemCount / itemsPerPage

        for var i = 0; i < itemCount; i++ {
            let indexPath = NSIndexPath(forItem: i, inSection: 0)
            let attr = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            let x = (CGFloat(i) * itemSize) + (itemSpacing * CGFloat(i))
            attr.frame = CGRectMake(x, 0, itemSize, itemSize)
            attributes.append(attr)
        }
    }

    override func collectionViewContentSize() -> CGSize {
        guard let cv = collectionView else {
            return CGSizeMake(0, 0)
        }

        // Only allow horizontal scroll
        let itemCount = CGFloat(cv.numberOfItemsInSection(0))
        let height = cv.bounds.size.height
        let width = CGFloat(itemSize)
        return CGSizeMake((width * itemCount) + ((itemSpacing - 1) * itemCount), height)
    }

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }

    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        if (velocity.x > 0) {
            nextPage()
        } else {
            let snapBack = velocity.x == 0
            if (!snapBack) {
                previousPage()
            }
        }

        // Round x offset to nearest 100th
        let newX = CGFloat(page * itemsPerPage) * itemSize
        let newOffset = CGPoint(x: newX + (CGFloat(page * itemsPerPage) * itemSpacing), y: proposedContentOffset.y);
        return newOffset
    }

    private func nextPage() {
        if (page < maxPages) {
            page += 1
        }
    }

    private func previousPage() {
        if (page > 0) {
            page -= 1
        }
    }
}
