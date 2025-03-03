module default {
    type Movie {
        required ratingKey: str;
    }
    type User {
        required name: str;
        movies: array<str>
    }
}
