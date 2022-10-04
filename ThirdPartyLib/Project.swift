import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
    name: "ThirdPartyLib",
    packages: [
        .RxSwift,
        .RxFlow,
        .Realm,
        .Moya,
        .Alamofire,
        .SnapKit,
        .Then,
        .Kingfisher,
        .ReactorKit,
        .UPCarouselFlowLayout
    ],
    deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone, .ipad]),
    dependencies: [
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.RxFlow,
        .SPM.Realm,
        .SPM.RealmSwift,
        .SPM.Moya,
        .SPM.RxMoya,
        .SPM.Alamofire,
        .SPM.SnapKit,
        .SPM.Then,
        .SPM.Kingfisher,
        .SPM.ReactorKit,
        .SPM.UPCarouselFlowLayout
    ]
)
