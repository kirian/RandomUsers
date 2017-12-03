# RandomUsers
 This is a test project in Swift to list of random users from http://randomuser.me/ API
 
#### Overall Approach:
* Avoid duplicated users. (checking email)
* Show the list sorted by user name.
* Fetch more random users when scroll at the end of the list.
* Swipe over the each cell to delete a random user.
* Tap on the cell to navigate to user detail view.
* The user information is persistent. (using Core Data).
* The most important parts of the project has ben tested.

This project is implemented with the Clean Architecture approach and use of RxSwift.

[<img src="https://github.com/kirian/RandomUsers/blob/master/UserListView.png" width="200" />
<img src="https://github.com/kirian/RandomUsers/blob/master/FilteringUsers.png" width="200" />
<img src="https://github.com/kirian/RandomUsers/blob/master/UserDetailView.png" width="200" />]


### Links
* [RxSwift](https://github.com/ReactiveX/RxSwift)
* [Alamofire](https://github.com/Alamofire/Alamofire)
* [Robert C Martin - Clean Architecture and Design](https://www.youtube.com/watch?v=Nsjsiz2A9mg)
* [Dependency Injection Assembler Approach](https://medium.com/makingtuenti/dependency-injection-in-swift-part-1-236fddad144a)
