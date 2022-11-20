import UIKit
import Then
import SnapKit

class CategoryCell: BaseCC {
    let categoryLabel = UILabel().then {
        $0.textColor = DMSportColor.blackColor.color
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .right
    }
    let categoryImage = UIImageView().then {
        $0.image = UIImage(named: "Soccerball")
    }
    override func addView() {
        [
            categoryLabel,
            categoryImage
        ]   .forEach {
            addSubview($0)
        }
    }
    override func configureVC() {
        self.backgroundColor = DMSportColor.whiteColor.color
        self.layer.cornerRadius = 20
    }
    override func setLayout() {
        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.left.equalToSuperview().inset(16)
            $0.height.equalTo(22)
        }
        categoryImage.snp.makeConstraints {
            $0.width.height.equalTo(36)
            $0.right.equalToSuperview().inset(34)
            $0.bottom.equalToSuperview().inset(44)
        }
    }
}
