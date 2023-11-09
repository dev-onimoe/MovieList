# MovieList
MovieList is a utility iOS mobile application that enable users get latest information on latest movies.

![](https://github.com/dev-onimoe/MovieList/blob/main/ezgif.com-gif-maker%20(1).gif)
![](https://github.com/dev-onimoe/MovieList/blob/main/ezgif.com-gif-maker%20(2).gif)
![](https://github.com/dev-onimoe/MovieList/blob/main/ezgif.com-gif-maker.gif)

MovieList is a two screen app that basically displays movies that are available in theatres and also sorts movies according to their popularity score. It fetches data from themoviedb.org api and is built purely in swift and UIKit (storyboards) with auto layout and iOS UI guidelines, it uses MVVM for architecture built mainly on the "didSet" observer property, other options would be RXSwift but the observer property is sufficient since it is only just a 2 screen app. The network layer uses AlamoFire and SwiftyJSON for parsing, SDWebImage for image download and caching and IBInspectable to build UI changes before runtime. MovieList is built to account for deep hidden errors and handles them seamlessly by taking advantage of the optionals feature of the swift language that allows for safe typecasting and safe nil checking. 

MovieList deals with a lot of both static and dynamic data so it has a network management and image caching feature which means data do not have to be freshly gotten each time as long as the app detects that the data at that point has not changed on the api end or if the time interval between requests is short so network calls is made minimal. 
