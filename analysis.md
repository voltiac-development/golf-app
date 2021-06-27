# Flutter Golf

Fluttergolf is a mobile app that is made with Flutter. The main goal of this mobile app is to learn flutter and it's inner working. The project itself is focusedon making it easier to save your recent scores.

## What is the goal of FlutterGolf?

While playing a game of golf, writing down your strokes and figuring out what your score is is always a trouble to do.
This app tries to solve that problem, during the game you can fill in your score and it will automatically calculate your score. When creating a game, you can select a friend (your marker) and you can compare scores live during your game.

## Supported courses

Courses are added by users themselves. When a course is not available when they want to play on that course, they can add valuable information. It is also possible for course owners to claim their course and then exclusively be able to edit course information.

## Requirements

* [ ] An user should be able to create a new account.
* [ ] An user should be able to log in.
* [ ] An user should be able to add his/her favorite course.
* [ ] An user should be able to edit his/her information.
* [ ] An user should be able to view there recent scores.
* [ ] An user should be able to view a specific score.
* [ ] An user should be able to view recent courses.
* [ ] An user should be able to add new friends.
* [ ] An user should be able to view current friends.
* [ ] An user should be able to remove friends.
* [ ] An user should be able to start a new round.
* [ ] An user should be able to add a friend to a new round.
* [ ] An user should be able to see it's playing handicap for the new round.
* [ ] An user should be able to select it's playing tee.
* [ ] An user should be able to select a course.
* [ ] An user should be able to see it's playing handicap per hole.
* [ ] An user should be able to see course information during the round.
* [ ] An user should be able to enter his/her and his/her's friend their strokes per hole.
* [ ] The app should show if there is a difference between strokes.

## Inner workings

### Rounds with friends

If you start a round together with a friend, you mark your scores for eachother. You also mark the scores of yourself. There should be a notification when someone invites you into a round. After you have joined a round you can enter scores. The moment you enter scores those scores are also displayed on the app of your friend.
With the usage of websockets, a duo or more should be placed within a socket room. Each round has it's own roomID.
<br>
## Use cases
<br>

| Use Case     | UC-01) Actor creates new account                                                                                                                                             |
|--------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Actor        | App user                                                                                                                                                                     |
| Precondition | Actor is not logged in                                                                                                                                                                       |
| App Flow     | 1. Actor enters their username, firstname, lastname, email and password.<br>2. Actor clicks register.                                                                        |
| Voltiac Flow | 1. Actor clicks on register with Voltiac.<br>2. Actor gets redirected to Voltiac authenticator.<br>3. Actor logs in with Voltiac account.<br>4. Actor gets send back to app. |
| Result       | Actor is logged in.                                                                                                                                                          |
| Exceptions   | **App Flow**<br> E-mail or username is already taken [2].<br>  Go back to [1].<br> Not all fields are entered [2].<br>  Go back to [1].                                      |
<br>

| Use Case     | UC-02) Actor logs in                                                                                                                                                         |
|--------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Actor        | App user                                                                                                                                                                     |
| Precondition | Actor is not logged in.                                                                                                                                                      |
| App Flow     | 1. Actor enters their username.<br>2. Actor enters password.<br>3. Actor pressed login.                                                                                      |
| Voltiac Flow | 1. Actor clicks on register with Voltiac.<br>2. Actor gets redirected to Voltiac authenticator.<br>3. Actor logs in with Voltiac account.<br>4. Actor gets send back to app. |
| Result       | Actor is logged in.                                                                                                                                                          |
| Exceptions   | **App Flow**<br> Username and / or password not entered [3].<br>  Go back to [1].<br> Username and password combination incorrect [3].<br>  Go back to [1].                  |

| Use Case | UC-03) Actor adds new course |
|-|-|
| Actor | App user |
| Precondition | Actor is logged in. |
| Base flow | 1. Actor enters name, adress and website.<br>2. Actor enters tee boxes.<br>3. Actor enters PAR, SI and distances.<br>4. Actor enters playing handicaps vs handicap. |
| Secondary flow | 1. Actor enters name, adress and website.<br>2. Actor enters tee boxes.<br>3. Actor enters PAR, SI and distances. |
| Result | New course is added to the app. |
| Exceptions | **Both flows**<br>Adress or website is already known [1].<br> Show course information to user.<br>No teeboxes are selected [2].<br> Go back to [2].<br>PAR, SI or distances are below 0 [3].<br> Go back to [3].<br><br>**Base flow**<br>Some handicaps are not taken into account [4].<br> Go back to [4]. |