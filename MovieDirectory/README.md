# TheMovieDirectory
iOS app to search titles in The Open Movie Database. 

## Screenshots.


## The Open Movie Database API and API Key.

The Open Movie Database (OMDb) API is an open source API which returns results like IMDb. (see http://www.omdbapi.com). If you want to run the application in a live environment, you will first need to obtain an API key from the OMDb. Keys are available at no cost [here](http://www.omdbapi.com/apikey.aspx).

Once you have an API key, edit it into the `Constants.swift` file as shown below:


## Description.

This app has an MVVM architecture with two screens. The search screen allows the user to enter movie keywords and begin a search, it also shows the results. Tapping on a result will transition to a detail screen to show information for that movie.

### Models:
* MovieSearch: represents a search result returned by the service (only used by the API gateway which unwraps the individual `Movie` objects).
* Movie: represents summary information about a movie.
* MovieDetails: detailed movie information.

### Network Service:
* MovieService: the API gateway providing access to search results, detailed movie information and poster images.
* MovieServiceDelegate: used to pass search results back to the app as they arrive.
* MovieServiceEndpoint: an enum used to construct URL's for the service.
* MovieServiceOperation: an `Operation` subclass to perform individual requests.

Callers only need to interact with the `MovieService` class and implement a `MovieServiceDelegate`.

The OMDb API uses paging with ten movies returned for each request. The app fetches the first ten pages automatically, then as soon as the last fetched result becomes visible, another page of results is fetched.

### User Interface:
* HomeSearchVC: uses a collection view to present results, also has a view to show errors like no result found or too many results prompting the user to refine their search.
* MovieCollectionViewCell: the collection view cell used to show movie summaries in the search view controller.
* MovieDetailVC: shows movie details in tabular format while keeping header with poster and title fixed at the top.
* MovieDetailTableCell: a table view cell used to show information in a heading and title format (movie information is shown in using a table).

## Future Development.
Cache can be implemented to store already fetched results about movies and their poster images.
Network call logic could be optimised further if the app needs to be scaled.
