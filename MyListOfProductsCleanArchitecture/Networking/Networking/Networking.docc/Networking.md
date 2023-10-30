# ``Networking``

## Overview
The Networking module provides a set of utility classes and functions for making network requests, handling responses, and managing network-related tasks in Swift applications. It encapsulates the complexities of URLSession and provides a simplified interface for performing common networking operations.

## Key Features

- **NetworkManager**: A singleton class that handles network requests. It provides methods for fetching data from a URL, supporting both synchronous and asynchronous operations.

- **ImageCacheManager**: A utility class for caching and loading images asynchronously. It helps improve the performance of your app by caching images locally and reducing redundant network requests.

- **Response Handling**: The module supports handling various types of responses, including successful data responses, HTTP errors, and decoding errors. It provides easy-to-use error handling mechanisms to handle different response scenarios.

- **Asynchronous Operations**: Utilizes Swift's `async/await` concurrency model to perform asynchronous network operations without blocking the main thread.

## Integration
To integrate the Networking module into your project, follow these steps:

- Add the Networking module folder to your Xcode project.
- Ensure that the module is included in your target's dependencies.

## Requirements

- Swift 5.5+
- iOS 13.0+ / macOS 10.15+
- Xcode 12.0+

## License
The Networking module is released under the MIT License.

##Author

Nikos Aggelidis - iOS Engineer
