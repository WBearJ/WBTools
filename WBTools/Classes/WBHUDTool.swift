import MBProgressHUD

public struct WBHUDTool {
    public typealias Completion = (() -> Void)?
    
    public static func showText(_ text: String, completion: Completion = nil) {
        guard let containerView = WBControllerTool.currentViewController()?.view else {
            return
        }
        let hud = MBProgressHUD.showAdded(to: containerView, animated: true)
        hud.label.text = text
        hud.mode = .text
        hud.show(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            hud.hide(animated: true)
            completion?()
        }
    }
    
    public static func showCircle(_ time: Int? = nil) {
        DispatchQueue.main.async {
            guard let window = window else {
                return
            }
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.tintColor = .white
            hud.isUserInteractionEnabled = false
            hud.contentColor = .white
            hud.bezelView.style = .solidColor
            hud.bezelView.backgroundColor = .black
            hud.removeFromSuperViewOnHide = true
            hud.mode = .customView
            
            // rot
            let rotationAnimate = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimate.toValue = (Double.pi * 2)
            rotationAnimate.duration = 1
            rotationAnimate.repeatCount = MAXFLOAT
            
            let circleImageView = UIImageView(image: UIImage(named: "hud_circle_icon", in: WBToolsConfig.bundle, compatibleWith: nil))
            circleImageView.layer.add(rotationAnimate, forKey: nil)
            hud.customView = circleImageView
            hud.show(animated: true)
        }
    }
    
    public static func hide() {
        DispatchQueue.main.async {
            guard let window = window else {
                return
            }
            MBProgressHUD.hide(for: window, animated: true)
        }
    }
    
    private static let window = UIApplication.shared.windows.first
}



