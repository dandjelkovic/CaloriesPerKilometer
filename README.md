# Small iOS App to calculate your average calories burnt per kilometer and climbed meter

## Ingredients

* Strava API — https://developers.strava.com/docs/
* SwiftUI
* Use `ASWebAuthenticationSession` for authentication

## How to use

1. Create yout persnal App and obtain your credentials from https://www.strava.com/settings/api 
2. Create a file called ´credentials.json´ with following contents:
```
{
"client_id" : "YOUR CLIENT_ID",
"client_secret" : "YOUR CLIENT SECRET"
}
``` 
3. Add the file ´credentials.json´ to your target.

**Now you can build the app and connect to your Strava Profile**
