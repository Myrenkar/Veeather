import Foundation

func performOnMainThread(block: @escaping () -> Void) {
    DispatchQueue.main.async {
        block()
    }
}
