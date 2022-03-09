//
//  InstructionsViewController.swift
//  Sleep Learning
//
//  Created by Annie Xu on 3/9/2022.
//  Copyright © 2022 Memory Lab. All rights reserved.
//
//  Description:
//      View controller for the three diary questions about English phrases.
//

import UIKit

class DiaryViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //  Set the status bar to have light content so it's visible against the black
    //  background
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //  Initializes the pages and the different view controllers.
    //  IMPORTANT: If new pages are added to the instructions or a page is deleted,
    //  this list must be updated.
    lazy var instructionPages: [UIViewController] = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        //  Pages:
        let firstEngVC = sb.instantiateViewController(withIdentifier: "firstEngVC")
        let secondEngVC = sb.instantiateViewController(withIdentifier: "secondEngVC")
        let thirdEngVC = sb.instantiateViewController(withIdentifier: "thirdEngVC")
        if diary.diaryData["numPhrases"] as? Int == 1{
                return [firstEngVC]
        }
        else if diary.diaryData["numPhrases"] as? Int == 2 {
                return [firstEngVC, secondEngVC]
        }
        return [firstEngVC, secondEngVC, thirdEngVC]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        if let firstViewController = instructionPages.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    //  Transitioning between pages
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentPageIndex = instructionPages.firstIndex(of: viewController) else {
            return nil
        }
        let previousPageIndex = currentPageIndex - 1
        guard previousPageIndex >= 0 && previousPageIndex < instructionPages.count else {
            return nil
        }
        return instructionPages[previousPageIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentPageIndex = instructionPages.firstIndex(of: viewController) else {
            return nil
        }
        let nextPageIndex = currentPageIndex + 1
        guard nextPageIndex >= 0 && nextPageIndex < instructionPages.count else {
            return nil
        }
        return instructionPages[nextPageIndex]
    }
    
    //  Page control (dots at bottom of the screen)
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return instructionPages.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let index = instructionPages.firstIndex(of: pageViewController) else {
            return 0
        }
        return index
    }
}
