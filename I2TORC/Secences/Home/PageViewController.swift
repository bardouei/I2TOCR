//
//  PageViewController.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/8/23.
//

import SwiftUI
import UIKit

struct PageViewController: UIViewControllerRepresentable {
    @Binding var selectedIndex: Int
    private var pageController: UIPageViewController

    init(selectedIndex: Binding<Int>) {
        self._selectedIndex = selectedIndex
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }

    func makeUIViewController(context: Context) -> UIPageViewController {
        pageController.dataSource = context.coordinator
        pageController.delegate = context.coordinator

        return pageController
    }

    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        if let viewController = page(for: selectedIndex) {
            uiViewController.setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        let parent: PageViewController

        init(_ parent: PageViewController) {
            self.parent = parent
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = parent.index(for: viewController) else { return nil }
            return parent.page(for: index - 1)
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = parent.index(for: viewController) else { return nil }
            return parent.page(for: index + 1)
        }

        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed, let currentViewController = pageViewController.viewControllers?.first, let index = parent.index(for: currentViewController) {
                parent.selectedIndex = index
            }
        }
    }

    private func page(for index: Int) -> UIViewController? {
        // Return the appropriate view controller based on the selected index
        switch index {
        case 0:
            return UIHostingController(rootView: Text("Page 1"))
        case 1:
            return UIHostingController(rootView: Text("Page 2"))
        case 2:
            return UIHostingController(rootView: Text("Page 3"))
        default:
            return nil
        }
    }

    private func index(for viewController: UIViewController) -> Int? {
        // Return the index of the view controller
        // You may need to customize this based on your actual view controllers
        if let textViewController = viewController as? UIHostingController<Text> {
            switch textViewController.rootView {
            case Text("Page 1"):
                return 0
            case Text("Page 2"):
                return 1
            case Text("Page 3"):
                return 2
            default:
                return nil
            }
        }
        return nil
    }
}

