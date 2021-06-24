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
| Use case | UC-01) Actor creates new account |
| -------- | -------------------------------- |
| Actor | App user |
| Precondition | The actor is not logged in. |
| App Flow | <ol><li>Actor enters their username, firstname, lastname, email and password.</li><li>Actor clicks register.</li></ol> |
| Voltiac flow | <ol><li>Actor clicks on register with Voltiac.</li><li>Actor gets redirected to Voltiac authenticator.</li><li>Actor logs in with Voltiac account.</li><li>Actor gets send back to app.</li></ol> |
| Result | Actor is logged in. |
| Exceptions | **App flow**<br>  E-mail or username is already taken [2].<br>    Go back to [1].<br>  Not all fields are entered [2].<br>     Go back to [1]. |
<br>
| Use case | UC-02) Actor logs in. |
| -------- | --------------------- |
| Actor | App User |
| Precondition | Actor is not logged in. |
| App Flow | <ol><li>Actor enters username.</li><li>Actor enters password.</li><li>Actor pressed login.</li></ol> |
| Voltiac Flow | <ol><li>Actor clicks on login with Voltiac.</li><li>Actor gets redirected to Voltiac authenticator.</li><li>Actor logs in with Voltiac account.</li><li>Actor gets send back to app.</li></ol> |
| Result | Actor gets logged in. |
| Exceptions | Username and / or password not entered [3].<br>    Go back to [1].<br>Username and password combo incorrect [3].<br>    Go back to [1]. |