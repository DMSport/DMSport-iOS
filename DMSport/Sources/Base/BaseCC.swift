import UIKit

class BaseCC: UICollectionViewCell {
    typealias DMSportColor = DMSportIOSAsset.Color
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.setLayout()
        self.configureVC()
    }
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addView() {}
    func setLayout() {}
    func configureVC() {}

}
