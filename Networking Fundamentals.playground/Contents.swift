/*:
 ## Networking Fundamentals
 
 Networking is how client devices communicate with a remote server. Client devices are user devices such as our iPhones, iPads, or iMacs. The remote server acts as a storage medium and processing center. The client makes a request to the remote server, which in turn processes that request and sends back a response. The remote server also goes by the name "backend" or "the cloud." In this course, we will use the terms backend and server interchangeably.
 
 ![servers](server.jpg)
 
 *Picture 1. In the picture is a server farm. Servers are really just computers. Credit [Ismail Enes Ayhan](https://unsplash.com/photos/brown-wooden-hallway-with-gray-metal-doors-lVZjvw-u9V8?utm_content=creditShareLink&utm_medium=referral&utm_source=unsplash)*
 
 The backend, being both a storage and processing centre, is built using a group of technologies. These are referred to as "stacks." A very popular stack for building backends is the use of MongoDB, Express, and NodeJS. MongoDB is the database or data storage technology; Express is the server technology responsible for handling requests and sending responses; and NodeJS is a programming language that ties it all together. A backend will use a stack, as we have just discussed, and be hosted on some kind of platform like Heroku or AWS.
 
 ![clientserver](clientserver.png)
 
 *Picture 2. The client makes a request to the server and the server replies with a response.*
 
 ### Custom Backend vs BaaS
 
 We have the choice of using pre-existing backends that are already configured for us and ready to use. These are referred to as BaaS, or backend as a service. An example of a BaaS is Firebase. The advantages of using a BaaS are:
 
 1. Less costly to setup.
 2. Easy to maintain.
 3. Shallow learning curve.
 4. Automatic scaling.
 
 The downsides are:
 
 1. Inability to add customized services. For example, transactional mail.
 2. Reliance on third party infrastructure.
 
 Generally, a BaaS is perfect for small to medium applications that are relatively not sophisticated.
 
 ### Should I Use a Backend?
 
 Not all apps need a backend. For single-user apps, it's perfectly fine to only use local storage methods like SwiftData and Realm to persist data. These kinds of apps will usually have no login or signup authentication steps. Local storage methods usually offer a way to automatically sync data to the cloud, making their data available on multiple devices, much like the Notes app. SwiftData and CoreData use iCloud as a way to sync data. Realm is using Cloud Atlas.
 
 Local storage methods can be combined with a backend. In these scenarios, the local storage method acts as a way to cache data or to provide some kind of offline support. This requires a delicate balance of checking to see if there is an internet connection before making requests and caching data in local storage if there isn't. When an internet connection is detected, the data should be sent to the server for long term persistence.
 
 ### JSON
 
 In the request and response exchange between clients and backends, there needs to be a language they both communicate in. This is important because the client and the backend are usually not built using the same programming language. An iOS app built using Swift cannot use Swift to send a request to a backend built using NodeJS. JSON (Javascript Object Notation) is a popular format for sending requests and receiving responses. Other formats include XML and HTTP, but these are less common. JSON should not be confused with JavaScript, which is a web scripting language.
 
 The following is an example of JSON. JSON supports simple types like String, Integers, Doubles and Booleans.
 
    {
        "user":
            {
                "name": "John Doe",
                "email": "johndoe@gmail.com",
                "followers": 1000,
                "following": 0,
                "isRegistered": true
            }
    }
 
 ### APIs and Endpoints
 
A backend will expose a way for clients to make requests. These are referred to as endpoints. Each endpoint accepts a request and returns a very specific response. For example, we might have an endpoint to allow a user to login. A client that uses this endpoint might pass along a username and password as part of the request body when making the request. The backend receives this and processes it and gives back a response being a successful login or a failed attempt. Altogether we refer to the collective endpoints that a backend exposes as an API or Application Programming Interface.
 
Endpoints are simply URLs in their makeup. Here is an example of what the login endpoint we have just discussed might look like:
 
    https://example.com/login
 
- **https** is the protocol of the URL. https is a secure protocol that uses TLS (SSL) to encrypt data that sent across a network. In contrast http (without the s) is not very secure because it sends data in plaintext.
- **example.com** is the baseurl which are also known as domains. The baseurl resolves to a specific server address. A baseurl can come with subdomains or children domains. Typically, an api is found within a subdomain called api. For example, the baseurl above would be https://api.example.com if the API were in a subdomain.
- **login** is a path or endpoint. Different endpoints are dedicated to providing different feedback. For example, a /user/1 might be a endpoint that gives back information on a user with id 1.
 
Endpoints can go further in accepting query parameters. Query parameters allow information to be passed about a request. Query parameters are passed as key-value pairs.
 
    https://api.examplebookings.com/flights?costbelow=200&date=march
 
 In the example above, we use a bookings API with a path /planetickets which lists all available flights. The API allows query parameters to make the search more specific. The query parameters start after the "?". The first query parameter costbelow=200 filters all flights to those that cost below $200. The ampersand "&" is used to concatenate query parameters. The second query parameter filters the flights further to those available only in March.
 
 ![API](request.png)
 
 *Picture 3. A login endpoint returns a response in JSON format with the user's credentials.*
 
### Request
 
Every request sends headers and a body. Both of these are sent as a dictionary or as a key-value pair list. The headers is metadata describing the request itself. The following are common keys sent as part of the headers:
 
- Content-Type - Describes the format used by the request. This is usually defined as application/json meaning the request uses JSON format.
- Authorization - This is used for privileged endpoints that require a user to be logged in. The Authorization header carries a bearer token also known as a JSON web token.
- Accept - defines the format that the client is able to accept from the server.
 
The body of the request is optional and is used to deliver data to the backend. The body is an alternative to sending data over query parameters. Whether the body or query parameters are used to send data is determined by the type of request.
 
### GET and POST Request
 
There are generally two types of request -  a POST request and a GET request. A GET request does not change server state and is typcially used to query data on a backend. The bookings example above is an example of this. We query all the flights and filter the results with query parameters. A POST request on the other hand results in a change in server state. A login is an example because the login results in the creation of a authentication token for the client. A POST request sends data as part of the body of the request. This is in contrast to a GET request which sends data using query parameters. A POST request is therefore more secure and should be used for senstive operations like login where a user's password is involved.
 
### Response
 
 After the server has processed a request it sends back a response to the client. The response will be comprised of headers and a response body. The response will also provide information on whether the request was successful or not. The result of the response is described through the response status code.
 
- Status code 200 to 299 means that the request was successful.
- Status code 400 to 499 means that there was an error with the request.
- Status code 500 to 599 means that the server encountered an error.
 
*/
