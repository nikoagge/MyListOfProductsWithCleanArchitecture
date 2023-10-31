# ProductsList iOS App

## Description

ProductsList iOS application, built in Swift, presents a robust product catalog with the following features:

- **Products List**: Displays a list of product items fetched from a web service. On the initial app launch, the products list is fetched and stored locally using Core Data.

- **Local Storage**: For subsequent app launches, the product list is retrieved from local storage, enhancing user experience and reducing network dependencies.

- **Manual Refresh**: Empowers users with the ability to manually refresh the product list by triggering a service call, ensuring they always have access to the latest data.

- **Product Details**: Provides a comprehensive view of each product item, including the product thumbnail, name, price, and a detailed description.

- **Navigation**: Allows seamless navigation between the product list view and the product details view, enhancing user engagement.

## Why RxSwift, Alamofire, Reactive Programming, Modules, Core Data, and Clean Architecture?

This challenge project leverages several key technologies and principles for various reasons:

- **RxSwift**: RxSwift is chosen for its robust reactive programming capabilities. It streamlines asynchronous operations, simplifies UI updates, and provides elegant error handling, resulting in cleaner and more maintainable code.

- **Alamofire**: Alamofire is used for making network requests due to its simplicity, reliability, and extensive community support. It abstracts away low-level networking details, making it easier to focus on app logic.

- **Reactive Programming**: A reactive programming paradigm is employed to efficiently handle data flow and UI updates. This approach ensures a responsive and highly interactive user experience.

- **Modules**: The project is structured in order to showcase modular development. This modular approach enhances code organization and reusability.

- **Core Data**: Core Data is integrated to manage local data storage efficiently. It enables the app to cache product items locally, reducing reliance on network requests and ensuring seamless offline access.

- **Clean Architecture Principles**: The project adheres to clean architecture principles, separating concerns into layers (presentation, domain, and data). This separation enhances testability, maintainability, and scalability.

## Project Structure

The project is organized into the following modules and layers:

- **Networking Module (Alamofire)**: This module plays a pivotal role in facilitating communication between the app and external web services. It is primarily responsible for two critical tasks:

    1) Fetching Product Data: The networking module employs Alamofire, a powerful and popular networking library, to initiate and manage network requests. It orchestrates the retrieval of product data from the web service, ensuring that the app can access the latest information about available products. This data is subsequently used to populate the product catalog.

    2) Image Caching (AlamofireImage Mechanism): In addition to fetching textual product data, this module seamlessly integrates with AlamofireImage. This powerful image-caching mechanism enhances the app's performance by efficiently managing product image downloads and caching. As product thumbnails and images are retrieved from the web service, they are cached locally to reduce redundant network requests and provide a smoother user experience. This optimization ensures that images load swiftly and consistently, even in situations with limited network connectivity.
By combining Alamofire for network requests and AlamofireImage for image caching, this module ensures that the app operates efficiently, delivering product data and images with speed and reliability.

- **Persistence (Core Data)**: Manages local data storage and retrieval, ensuring efficient caching of product items.

- **ViewModels**: Implements the ViewModel layer of MVVM architecture. These ViewModels are designed to be testable and handle the presentation logic.

- **Views**: Contains the user interface components, including product list and details views. These views are isolated from business logic for improved maintainability and testability.

- **AppCoordinator**: Manages navigation flow, orchestrating transitions between different views and screens within the app.

## How to Run the App

To experience the app and explore its features:

1. Clone this repository to your local machine.
2. Navigate to the location of Podfile and run on your terminal the "pod install" command
3. Open the Xcode (`MyListOfProductsCleanArchitecture.xcworkspace`) in Xcode.
4. Build and run the app on the iOS simulator or a physical device.
5. Interact with the product catalog, refresh the list, view product details, and navigate between views.

## Feedback and Questions

If you have any questions, feedback, or inquiries related to the code, architecture, or implementation choices, please don't hesitate to reach out.

Author: Nikos Aggelidis
