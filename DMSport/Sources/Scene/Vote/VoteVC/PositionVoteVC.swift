import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import Moya
import RxMoya

class PositionVoteVC: BaseVC {
    var categoryName = String()
    
    private let guideLabel = UILabel().then {
        $0.text = "포지션 선택"
        $0.textColor = DMSportColor.hintColor.color
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    }
    let voteTableView = UITableView().then {
        $0.register(PositionVoteCell.self, forCellReuseIdentifier: "Position")
        $0.rowHeight =  68
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
    }
    override func addView() {
        [
            guideLabel,
            voteTableView
        ] .forEach {
            view.addSubview($0)
        }
    }
    override func configureVC() {
        view.backgroundColor = DMSportColor.baseColor.color
        voteTableView.delegate = self
        voteTableView.dataSource = self
        print(categoryName)
    }
    override func setLayout() {
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.left.equalToSuperview().inset(28)
            $0.height.equalTo(24)
        }
        voteTableView.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(18)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}

extension PositionVoteVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch categoryName.self {
        case "SOCCER":
            return 11
        case "BASKETBALL":
            return 5
        case "VOLLEYBALL":
            return 4
        default:
            print("default")
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch categoryName.self {
        case "SOCCER":
            let positionList: [String] = [ "C.F", "S.F", "L.W", "C.M", "R.W", "A.M", "D.M", "L.S.T", "R.S.T", "S.W", "G.K" ]
            if let cell = voteTableView.dequeueReusableCell(withIdentifier: "Position", for: indexPath) as? PositionVoteCell {
                cell.positionLabel.text = "\(positionList[indexPath.row])"
                cell.selectionStyle = .none
                return cell
            } else {
                return UITableViewCell()
            }
        case "BASKETBALL":
            let positionList: [String] = [ "P.G", "S.G", "S.F", "P.F", "C" ]
            if let cell = voteTableView.dequeueReusableCell(withIdentifier: "Position", for: indexPath) as? PositionVoteCell {
                cell.positionLabel.text = "\(positionList[indexPath.row])"
                cell.selectionStyle = .none
                return cell
            } else {
                return UITableViewCell()
            }
        case "VOLLEYBALL":
            let positionList: [String] = [ "Right", "Left", "Center", "Libero" ]
            if let cell = voteTableView.dequeueReusableCell(withIdentifier: "Position", for: indexPath) as? PositionVoteCell {
                cell.positionLabel.text = "\(positionList[indexPath.row])"
                cell.selectionStyle = .none
                return cell
            } else {
                return UITableViewCell()
            }
        default:
            print("default")
            return UITableViewCell()
        }
    }
}
