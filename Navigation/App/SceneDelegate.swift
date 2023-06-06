import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow (windowScene: scene)
        
        let factory = AppFactory(feedModel: FeedModel())
        let appCoordinator = AppCoordinator(factory: factory)

        //let appconfiguration = AppConfiguration.allCases.randomElement()!
        //NetworkManager().request(for: appconfiguration)
        
        self.window = window
        self.appCoordinator = appCoordinator

        window.rootViewController = appCoordinator.start()
        window.makeKeyAndVisible()
        
        //РЕДАКЦИЯ ДО ВЫПОЛНЕНИЯ ТЕКУЩЕГО ЗАДАНИЯ
        /*let exLoginController = LogInViewController()
        
        let feedModel = FeedModel()
        let feedViewModel = FeedViewModel(feedModel: feedModel)
        let feedVC = FeedViewController(feedViewModel: feedViewModel)
        
        let feedViewController = UINavigationController(rootViewController: feedVC)
        let logInViewController = UINavigationController(rootViewController: exLoginController)
       
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .systemGray6
        tabBarController.viewControllers = [feedViewController, logInViewController]
        
        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "book.fill"), tag: 0)
        logInViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.fill"), tag: 1)
    
        //задача 1
        //exLoginController.loginDelegate = LoginInspector()
        //задача 2 - через фабрику
        exLoginController.loginDelegate = MyLoginFactory().makeLoginInspector()

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        self.window = window*/
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

/*class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else {
            return
        }

        let factory = AppFactory(networkService: NetworkService())
        let appCoordinator = AppCoordinator(factory: factory)

        self.window = UIWindow(windowScene: scene)
        self.appCoordinator = appCoordinator

        window?.rootViewController = appCoordinator.start()
        window?.makeKeyAndVisible()
    }
}*/
