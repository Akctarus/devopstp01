CREATE TABLE users (

  id SERIAL UNIQUE NOT NULL,

  first_name TEXT,

  last_name TEXT,

  email TEXT UNIQUE NOT NULL,

  username TEXT PRIMARY KEY,

  created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW()

);
