import ProjectDescriptionHelpers
import ProjectDescription

let project = Project.makeModule(
    name: "DMSport-iOS",
    platform: .iOS,
    deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone, .ipad]),
    dependencies: []
)
