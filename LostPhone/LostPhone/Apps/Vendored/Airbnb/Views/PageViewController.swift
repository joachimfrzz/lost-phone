

import SwiftUI
import UIKit

struct VendoredAirbnbPageViewController: UIViewControllerRepresentable {
    var controllers: [UIViewController]
    @Binding var currentPage: Int
    
    func makeCoordinator() -> VendoredAirbnbCoordinator {
        VendoredAirbnbCoordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [controllers[currentPage]], direction: .forward, animated: true)
    }
    
    class VendoredAirbnbCoordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: VendoredAirbnbPageViewController
        
        init(_ pageViewController: VendoredAirbnbPageViewController) {
            self.parent = pageViewController
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                self.parent.currentPage = 0
                return parent.controllers.last
            }
            self.parent.currentPage = index
            return parent.controllers[index - 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController,viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == parent.controllers.count {
                self.parent.currentPage = index
                return parent.controllers.first
            }
            if index == parent.controllers.count {
                self.parent.currentPage = parent.controllers.startIndex
            }
            self.parent.currentPage = index
            return parent.controllers[index + 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            
            if completed,
                let visibleViewController = pageViewController.viewControllers?.first,
                let index = parent.controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
    }
}

