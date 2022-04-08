
class WBToolsConfig: NSObject {
    static var bundle: Bundle? = {
        let cBundle = Bundle(for: WBToolsConfig.classForCoder())
        guard let path = cBundle.path(forResource: "WBTools", ofType: "bundle") else {
            return nil
        }
        return Bundle(path: path)
    }()
}
