import ProjectDescription

extension Project {
    public static func makeModule (
        name: String,
        platform: Platform,
        product: Product = .app,
        deploymentTarget: DeploymentTarget = .iOS(targetVersion: "14.0", devices: [.iphone, .ipad]),
        dependencies: [TargetDependency]
    ) -> Project {
        return Project (
            name: name,
            organizationName: dmsOrganizationName,
            targets: [
                Target (
                    name: name,
                    platform: platform,
                    product: product,
                    bundleId: "\(dmsOrganizationName).\(name)",
                    deploymentTarget: deploymentTarget,
                    infoPlist: .file(path: Path("Support/Info.plist")),
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    dependencies: [
                        .project(target: "ThirdPartyLib", path: "../ThirdPartyLib")
                    ] + dependencies
                )
            ]
        )
    }
}
