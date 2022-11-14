import UIKit
import ReactorKit

class BaseVC: UIViewController {
    typealias DMSportColor = DMSportIOSAsset.Color
    
    let bound = UIScreen.main.bounds
    var disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = DMSportColor.baseColor.color
        addView()
        setLayout()
        configureVC()
        bind()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    func addView() {}
    func setLayout() {}
    func configureVC() {}
    func bind() {}
}
