import UIKit
import RxCocoa

extension VoteVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.categoryCollectionView.cellForItem(at: indexPath)
        if cell!.isSelected == true {
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = DMSportColor.mainColor.color.cgColor
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = self.categoryCollectionView.cellForItem(at: indexPath)
        if cell!.isSelected == false {
            cell?.layer.borderWidth = 0.0
            cell?.layer.borderColor = UIColor.clear.cgColor
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labelData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.categoryLabel.text = "\(labelData[indexPath.row])"
        cell.categoryImage.image = UIImage(named: "\(imageData[indexPath.row])")
        
        return cell
    }
}
