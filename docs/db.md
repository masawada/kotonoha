# DB Spec

## users
  * integer id
  * string user_name (max 64chars, unique, notnull)
  * text url
  * text bio
  * timestamps

## keys
  * integer id
  * references user_id (unique)
  * string access (unique, notnull)
  * string secret (notnull)
  * timestamps

## status table
  * integer id
  * text text (notnull)
  * references user_id
  * integer favorites (default is 0)
  * timestamps

