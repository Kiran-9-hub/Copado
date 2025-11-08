public with sharing class MovieSearchController {
    
    @AuraEnabled(cacheable=true)
    public static MovieDetails searchMovie(String movieName) {
        // Your OMDb API key
        String apiKey = '7a951fe1';
        String url = 'https://www.omdbapi.com/?t=' + EncodingUtil.urlEncode(movieName, 'UTF-8') + '&apikey=' + apiKey;

        // Create a new HttpRequest
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        
        // Send the HTTP request and get the response
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        if (res.getStatusCode() == 200) {

            // Parse the JSON response
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            
            // Check if the response was successful
            if (responseMap.containsKey('Response') && (String)responseMap.get('Response') == 'True') {
                MovieDetails movieDetails = new MovieDetails();
                movieDetails.title = (String)responseMap.get('Title');
                movieDetails.year = (String)responseMap.get('Year');
                movieDetails.director = (String)responseMap.get('Director');
                movieDetails.plot = (String)responseMap.get('Plot');
                movieDetails.Actors = (String)responseMap.get('Actors');
                movieDetails.Poster = (String)responseMap.get('Poster');
                movieDetails.Rated = (String)responseMap.get('Rated');
                movieDetails.Language = (String)responseMap.get('Language');
                movieDetails.Country = (String)responseMap.get('Country');
                movieDetails.genre = (String)responseMap.get('Genre');

                return movieDetails;
            } else {
                throw new CustomException('Movie not found.');
            }
            
        } 
        else {
            throw new CustomException('Error fetching movie data: ' + res.getStatus());
        }
    }

    // Custom exception to handle errors
    public class CustomException extends Exception {}

    // Class to hold movie details
    public class MovieDetails {
        @AuraEnabled public String title;
        @AuraEnabled public String year;
        @AuraEnabled public String director;
        @AuraEnabled public String plot;
        @AuraEnabled public String actors;
        @AuraEnabled public String poster;
        @AuraEnabled public String Rated;
        @AuraEnabled public String genre;
        @AuraEnabled public String language;
        @AuraEnabled public String country;
    }
}