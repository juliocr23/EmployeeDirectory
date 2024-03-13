//
//  README.md
//  EmployeeDirectory
//
//  Created by Julio Rosario on 3/13/24.
//

## Build tools & versions used
- OHHTTPStubs: Utilized for mocking and testing network requests within the application.
- SDWebImage: Implemented for efficient image caching and loading within the employee directory.

## Steps to run the app
1. Open the project in Xcode
2. Choose an iPhone simulator from the list of available devices.
3. Click the 'Run' button

## What areas of the app did you focus on?
My primary focus was on the architecture concerning the dynamic population of cells within the UICollectionView. This includes ensuring a clean separation of concerns among different components of the app, particularly between the view controllers, data providers, and cell controllers.

## What was the reason for your focus? What problems were you trying to solve?
The main aim was to create a scalable and maintainable structure that simplifies updating and managing different parts of the app without affecting others. This approach was intended to address common issues related to tight coupling and code reusability.

## How long did you spend on this project?
It took me aroud 3 hours. 

## Did you make any trade-offs for this project? What would you have done differently with more time?
- Due to time constraints, there were some trade-offs I made. I focused more on setting up a robust architecture for populating the collection view rather than making components like CollectionViewCellControllerSectionProvider and EmployeeSummaryCollectionViewCellControllerProvider generic. Given more time, I would have worked on generalizing the provider components and the CollectionViewController(that is the stenciling and sizing) to handle various data types and further modularized, the main view controller to enhance testability and maintainability. Having more time would have allowed me to create mocks and more unit tests.

## What do you think is the weakest part of your project?
The weakest aspects of my project, revolves around two main areas:

Generality and Reusability: My current implementation is specifically tailored to handling employee-related data within collection view cells. This specialized approach, while effective for the current use case, limits the reusability of the architecture for different types of content and cells. Ideally, I would prefer a more generic system where cell controllers and data handling are abstracted in such a way that they can be easily adapted for various data types and view elements.

API Architecture and Data Management: The current API architecture is relatively straightforward and lacks advanced features like paging, which are essential for handling large datasets efficiently. In real-world applications, an optimal system for paging is crucial to reduce load times and manage resources effectively. Enhancing the API architecture to support these functionalities would significantly improve the app's scalability and user experience.

## Did you copy any code or dependencies? Please make sure to attribute them here!
All the code was written independently without direct copying from external sources. The mentioned dependencies, OHHTTPStubs and SDWebImage, are widely used in the iOS development community and integrated according to their respective documentation.
## Is there any other information you’d like us to know?
The selected dependencies and architectural patterns are reflective of those commonly used in my daily work, aiming to represent real-world scenarios and solutions.
