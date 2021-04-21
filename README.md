# Shortcut Comics

## The Challenge

The challenge is to create an app to browse through comics. The challenge is created by Shortcut. Link to task: https://github.com/shortcut/coding-assignment-mobile

##Project Structure

When starting a new Flutter project it generates all necessary files to start developing. The project code is in the lib folder. In the lib folder, I have created four folders. They are models, screens, widgets and providers. For testing, there are three folders. The first one is integration_test for integration testing, test for unit testing and test_driver for running the integration testing.  


## To run 
This is a Flutter project so you need Flutter and Dart plugin.
The project can be run in both Android Studio and Visual Studio Code.
Run 'flutter pub get' to get necessary flutter files
Run the program and enjoy it :smiley:

## Description of my solution

The first thing the user meets is the home screen. The user has the option to choose between four buttons. Show today’s comics, Search for comics by id, Search for comics by text and Show favorites. If the device doesn't have an internet connection only the favorites button is shown. 

If the user presses Show today’s comics the ComicsScreen will be shown with today’s comics(last comic). On the top of ComicsScrees, there is the comic title between the back button and the home button. Below that is the comic image, description, an Icon to set as favorites and when the comic was published. At the bottom, there are two buttons with the comics number between. One button is to go next the other to go to the previous comic.  

The Search for comics by id button will go to a search screen. Here the user can insert a number and press the search button. It will show the comic the user searched for on the ComicsScreen.

If the user presses the Search for comics by test. Another search screen is shown with some other info. The user can type in a word and search. The result is shown on a result screen where the user can scroll through the result. If the user presses one of the results it will go to the ComicsScreen and show the pressed comic.

The favorite button will take the user to a favorite screen. If the user has some favorites they will be listed in a list. if the user doesn't have any favorites, some text and a button to browse comics are shown. The favorites are saved on the phone so it works without an internet connection.   

## The process

I started to see what the xkcd JSON API worked and what it did return. I started with a simple test project to test some of the concepts of the task before I created the main project. In the main project, I started to create the home page, a comics class, a screen to show the comics, and a provider to handle all data. Then I added some hard-coded comics so I could test the design without making any API requests.  

 ### See the comic details, including its description.

When I managed to show the hard-coded comics on the screen the next task was to receive data from the API. In the Comics class, I created a method to convert the data from the API to a comics object. When that was done I only had to replace the hard-coded data with the real one and show it on the ComicsScreen. 

### Browse through the comics

I created two buttons at the bottom of the page. One for the next comics and one for the previous comics. Next I call on the API with the comic numbers that are selected and add one. The same is for previous but remove one instead. I was struggling a bit to handle what should happen if you go past the last one. I found out if you call on the API with a number that doesn’t exist you get a 404 response. So if the comic num that is on the screen is not 1(the first one). I created a “comic” that gives the user a fun response that it was the last one. And I also created a fun response when the user went before the first one.

### Search for comics by the comic number as well as text

Searching for comics by number wasn't that hard. But getting some validation on the text field was a little bit harder. I solved it by first searching for the last comics and get its number. Then I check if the number the user typed in is between 1 and the last number. I did it this way because I don't know when xkcd comics add a new comic to their database so I check every time the user press Search by id button. 

It was a lot harder to search by title. First I didn't find any way for getting the data I needed So I did inspect which request the website used. In the network tab, I found a URL to send data to that returned what I needed. The data that came back contained some weird characters that I didn't understand how to use. So my best solution was to split the whole response into characters and I did use regex to remove the values I didn’t want. I don’t think it is the best way, but it was the way I managed to solve it. And when I have the response in the format I want and add the result to a list and show it to the user. 

### Favorite the comics, which would be available offline too

In a previous tutorial, I created an app that added products to a favorites list. So I used some of that code. But the code didn’t save the data locally only on the app. So I decided to learn some simple SQLite to save the data to the phone locally. Since the image only is a web image I had to convert the image to some data that could be saved on the phone and save a reference to that location on the device in the SQLite database. 

To check if the phone was online or not doesn't work that well. If the user loses connection in some weird places it fails. But most times it works.

### Support multiple form factors.

I have tried my best to create the app with dynamic sizing. I have tested the app on small devices and some tablets. It looks pretty good on all of the devices I have tested on.

###

The last three points I haven't created. I didn’t find a good way to receive the explanation to a comic. The best way I found was to download the whole page in raw HTML code and find the info I needed. So I decided not to do that.  

To send comics to others and get notifications when a new comic is published is something I have never done before. So I would need some more time to make it work. Instead, I chose to focus on the other points







