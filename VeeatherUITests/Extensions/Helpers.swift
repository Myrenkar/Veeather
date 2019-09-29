import UIKit

func snapshotTestsControllers(child: UIViewController = UIViewController()) -> (parent: UIViewController, child: UIViewController) {

        let parent = UIViewController()
        parent.addChild(child)
        parent.view.addSubview(child.view)

        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        parent.view.frame = .init(x: 0, y: 0, width: 375, height: 667)

        child.view.frame = parent.view.frame
        parent.preferredContentSize = parent.view.frame.size
        parent.view.backgroundColor = .white
        child.view.backgroundColor = .white
        return (parent, child)
}


func loadView(_ controller: UIViewController, in window: UIWindow) {
    window.subviews.forEach{ $0.removeFromSuperview() }
    window.addSubview(controller.view)
    RunLoop.current.run(until: Date(timeInterval: 1, since: Date()))
}
