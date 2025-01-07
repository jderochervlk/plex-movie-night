CREATE MIGRATION m1faudfpiyl5nadrc3fqmsnbpxjpjbwo2yfunc345rwshqbiutgnuq
    ONTO initial
{
  CREATE TYPE default::Movie {
      CREATE REQUIRED PROPERTY title: std::str;
  };
};
