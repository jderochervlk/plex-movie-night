CREATE MIGRATION m1vp4byiyp5c2bsttlnukkdbr4terjlkod4lcezxrnqkhaq5l34cla
    ONTO m1faudfpiyl5nadrc3fqmsnbpxjpjbwo2yfunc345rwshqbiutgnuq
{
  ALTER TYPE default::Movie {
      ALTER PROPERTY title {
          RENAME TO ratingKey;
      };
  };
  CREATE TYPE default::User {
      CREATE PROPERTY movies: array<std::str>;
      CREATE REQUIRED PROPERTY name: std::str;
  };
};
