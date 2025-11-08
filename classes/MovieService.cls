public class MovieService {
    public class MovieCast {
        public String name;
        public Integer gender;
    }

    public class MovieResponse {
        public String title;
        public String poster_path;
    }

    public class CreditsResponse {
        public List<MovieCast> castList; // changed from 'cast' to 'castList'
    }

    public static void getMovieDetails(String movieName) {
        String apiKey = 'YOUR_TMDB_API_KEY';
        String encodedName = EncodingUtil.urlEncode(movieName, 'UTF-8');

        Http http = new Http();

        // Step 1: Search movie by name
        HttpRequest req1 = new HttpRequest();
        req1.setEndpoint('https://api.themoviedb.org/3/search/movie?api_key=' + apiKey + '&query=' + encodedName);
        req1.setMethod('GET');
        HttpResponse res1 = http.send(req1);

        if (res1.getStatusCode() == 200) {
            Map<String, Object> searchResult = (Map<String, Object>) JSON.deserializeUntyped(res1.getBody());
            List<Object> results = (List<Object>) searchResult.get('results');

            if (!results.isEmpty()) {
                Map<String, Object> movie = (Map<String, Object>) results[0];
                String title = (String) movie.get('title');
                String poster = (String) movie.get('poster_path');
                Integer movieId = (Integer) movie.get('id');

                // Step 2: Get credits (cast)
                HttpRequest req2 = new HttpRequest();
                req2.setEndpoint('https://api.themoviedb.org/3/movie/' + movieId + '/credits?api_key=' + apiKey);
                req2.setMethod('GET');
                HttpResponse res2 = http.send(req2);

                if (res2.getStatusCode() == 200) {
                    String creditsJson = res2.getBody();

                    // Fix key name from 'cast' to 'castList' in JSON
                    creditsJson = creditsJson.replace('"cast":', '"castList":');

                    CreditsResponse credits = (CreditsResponse) JSON.deserialize(creditsJson, CreditsResponse.class);
                    String hero = 'Unknown';
                    String heroine = 'Unknown';

                    for (MovieCast c : credits.castList) {
                        if (c.gender == 2 && hero == 'Unknown') {
                            hero = c.name;
                        } else if (c.gender == 1 && heroine == 'Unknown') {
                            heroine = c.name;
                        }
                    }

                    System.debug('🎬 Title: ' + title);
                    System.debug('🖼️ Poster: https://image.tmdb.org/t/p/w500' + poster);
                    System.debug('🧔 Hero: ' + hero);
                    System.debug('👩 Heroine: ' + heroine);
                }
            }
        }
    }
}