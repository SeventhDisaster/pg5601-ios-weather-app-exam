# iOS Exam - Autumn Season 2020

### Kristiania University College - Candidate Number 10061

## XCode Version: Version 12.1 (12A7403)
## Swift Version: Swift 5

### Ensure XCode has a set simulator location so that the simulator doesn't crash when location permission is granted.

Jeg kan skrive på Norsk, men føler det er lettere å uttyde hva jeg mener hvis jeg skriver på Engelsk.
Jeg er kandidat 10061 på iOS Programmering Eksamen Høsten 2020. 

On the usage of icons in this project:
All icons for weather patterns and etc. were made my myself and uploaded directly into the assets folder. 
Any similarities to other icons are purely coincidental, their design was based on the set of icons visible here: https://api.met.no/weatherapi/weathericon/2.0/documentation 

### Application Flow:

Upon first boot, you will be tossed into the "Home" screen
Initially it will display a ? and placeholder information. And you will be prompted with a permission access on the first go. 
*It is strongly recommended you allow this permission right away, as not doing so could potentially cause crashes due to not being handled*

From the application is structured as 3 different NavigationControllers embedded in a single TabBarController. The main method of navigation is the tab bar at the bottom.
In order to test the HK Location feature of the Forecasts tab, I recommend you avoid opening the Map tab prior to opening Forecasts as Map will overwrite a variable controlling that.

#### The Home Screen:

The home screen is a display of the current weather at your current location given the earliest possible time available from the API.
Pressing the icon will perform the animations mentioned in the exam, and you can repeatedly use the "Easter eggs"
Swiping left and right will instantly switch the view over to the next card (rendered through the renderDay() method) and activate any specific animations should the weather match a criteria.

Data Storage:
This API call also stores data on the device, since I filter down the response from the API greatly, I only end up with very small objects when I display them on the home screen.
Because of this I have opted to use UserDefaults to store the data, since it's a much simpler implementation intended for small objects and small amounts of data.
Whenever the API updates, all old content is removed, and an array of only up to 7 SimpleWeatherData objects are added. These objects are very small in comparison to the full response.
If I had stored more data in the assignment, I would have considered using CoreData to store the information instead.


#### The Forecast screen:

The forecast screen will by default show the weather data for Campus Kvadraturen at HK, it is displayed in a tableview limited to a max of 4 rows, displaying only the weather info provided. it was built to match the example in the exam assignment as closely as possible, without any extravenous displayed data.
I could have considered adding the weather icons here, but decided not to to avoid screen clutter and potential limitations for smaller devices, such as lack of space to fit the icons and similar issues.

At the bottom of the forecasts tab, it shows information about where it is getting it's data from.
This line of text pays attention to a global variable in GlobalSettings.swift, which if defined, will cause that value to change to your nearest location. 
This value is modified when the Map window is loaded and asks for the user's location.

#### The Map:

The map is the last tab of the application. 
The main attraction of this window is the map, which utilizes a simple MapView and also uses CoreLocation to get the users location.
When loaded up, assuming the user has granted permission for location, the map will zoom in and focus on the user's location right away, and it is interactable just as
any application that uses Apple Maps is. 
The weather view at the bottom, fetches the weather data for the user's CURRENT LOCATION on load, and displays it right away as an icon.

In the top right, there is a switch and a label indicating which mode is selected by the switch. 
Note: The use of the switch does break the rules of Apple's Human Interface Guidelines a little: https://developer.apple.com/design/human-interface-guidelines/ios/controls/switches/ but this was done intentionally, as the switch is a simple toggle function to use.

Hitting the toggle, will swap the map from tracking mode to pin mode.
When switching, a pin will be placed on the user's location right away, so that there is always a position to select from.
When in pin mode, the user can scroll the map around and place a pin wherever they want to have the pin placed.

Placing a pin will make a new call to the MapWeather delegate class and refresh the view on the bottom that displays location and weather.
The location will set itself to the pin's exact location, and the weather will update to the weather that is relevent at that location as well
This is done though the protocol delegate pattern.

NOTE: In order for the delegation handling to be simple, I defined a single global variable in GlobalSettings.swift that contains the MapWeather object from the MapWeatherDelegate class. This made it much easier to make the call from the map to the separate view controller without having to instanciate it programatically, but also avoid having to refresh the entire view. I am not sure if this is good practice or not.

Should the API call fail, the error will be displayed in the same labels as the latitude and longitude numbers, and the weather will become a questionmark.

## Assumptions: 
- Home Screen (Last Updated) 
It was ambigous wether or not the "last updated" in the exam was reffering to the current date/time of the device, or the "last updated" provided in the properties.meta.updatedat response we got from the API. In my case I assumed it was reffering to the device's time of the last update, and that's what it goes with
 
 - Home Screen (Data storage)
 Since it was never specified which type of storage we used, I assumed it was up to our own descretion to choose a method of persistence. 
 I went with UserDefaults because of this. 
 
 - Forecasts Screen (Your Location)
 Your location gets changed the moment the app loads the Map, I assumed this is what the task wanted based on how it was phrased.
 
- Map (Pin/Track mode toggle)
I assumed these features were supposed to be mutually exclusive and both should not be available at the same time.

- Map (Separate View with Delegate providing data)
This requirement was confusing. My assumption was that you wanted to see a completely separate view controller for the extra view below the map, so that's what I did.
It was never specified what was supposed to be the delegate for the view so I created a separate one accessed through the global variable mentioned.
