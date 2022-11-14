import UIKit

class BaseTC: UITableViewCell {
    typealias DMSportColor = DMSportIOSAsset.Color
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
