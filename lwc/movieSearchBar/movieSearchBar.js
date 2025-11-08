import { LightningElement } from 'lwc';
import searchMovie from '@salesforce/apex/MovieSearchController.searchMovie';

export default class MovieSearch extends LightningElement {
    movieName = '';
    movieDetails = null;
    errorMessage = '';
    latestSearch = ''; // To track the latest input

    handleMovieNameChange(event) {
        const input = event.target.value.trim();
        this.movieName = input;
        this.latestSearch = input; // Save the current input

        if (input === '') {
            this.movieDetails = null;
            this.errorMessage = '';
            return;
        }

        searchMovie({ movieName: input })
            .then(result => {
                // Only update if the input hasn't changed
                if (this.latestSearch === input) {
                    this.movieDetails = result;
                    this.errorMessage = '';
                }
            })
            .catch(error => {
                // Only update if the input hasn't changed
                if (this.latestSearch === input) {
                    this.movieDetails = null;
                    this.errorMessage = 'Error fetching movie data: ' +
                        (error?.body?.message || error.message || 'Unknown error');
                }
            });
    }
}