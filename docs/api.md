# Kotonoha API Reference

VERSION = 0.1 (beta)

## API Abstract
### Root
####    GET '/'

### Manage statuses (Require Auth)
####   POST '/statuses/update'
#### DELETE '/statuses/destroy/:id'

    Note
    See auth.md to understand about Authentication

### Read stataues
####    GET '/statuses/timeline'
####    GET '/statuses/show/:id'

### Search statuses
####    GET '/search'

### Favorite action
####    PUT '/favorites/create/:id'

## API Details
### Root
####     GET '/'
##### Request
* no request params

##### Response
    {
      is_success: true,
      message: "hello, world"
    }

### Manage statuses (Require Auth)
####   POST '/statuses/update'
##### Request
    {
      text: string status,
      access: string accesskey,
      timestamp: string ISO8601 formatted Timestamp,
      signature: string SignatureString
    }

##### Response
    {
      is_success: boolean is_success,
      status: {
        id: integer leaf_id,
        text: string status,
        user_id: ineger user_id,
        user_name: string posted user,
        favorites: integer favorites,
        timestamp: integer created_time
      }
    }

#### DELETE '/statuses/destroy/:id'
##### Request
* id: leaf_id
    {
      access: string accesskey,
      timestamp: string ISO8601 formatted Timestamp,
      signature: string SignatureString
    }

##### Response
    {
      is_success: boolean is_success,
      deleted_id: integer leaf_id
    }

### Read statuses
####    GET '/statuses/timeline'
##### Request
    {
      max_id: integer max_id, (optional)
      since_id: integer since_id, (optional)
      count: integer count, (optional, default is 20, count can be less than 100)
    }

##### Response
    {
      is_success: boolean is_success,
      statuses: {
        leaf_id: {
          id: integer leaf_id,
          text: string status,
          user_id: integer user_id,
          user_name string posted user,
          favorites: integer favorites,
          timestamp: integer created_time
        },
    
        leaf_id: {
          ...
        }
      }
    }

####    GET '/statuses/show/:id'
##### Request
    {
      id: integer leaf_id
    }

##### Response
    {
      is_success: boolean is_success,
      status: {
        id: integer leaf_id,
        text: string status,
        user_id: integer user_id,
        user_name string posted user,
        favorites: integer favorites,
        timestamp: integer created_time
      }
    }

### Search statuses
####    GET '/search'
##### Request
    {
      keywords: string space separated keywords, (AND) 
      max_id: integer max_id, (optional)
      since_id: integer since_id, (optional)
      count: integer since_id, (optional, default is 20, counts can be less than 100)
    }

##### Response
    {
      is_success: boolean is_success,
      statuses: {
        leaf_id: {
          id: integer leaf_id,
          text: string status,
          user_id: ineger user_id,
          user_name: string posted user,
          favorites: integer favorites,
          timestamp: integer created_time
        },

        leaf_id: {
          ...
        }
      }
    }

####    PUT '/favorites/create/:id'
##### Request
    {
      id: integer leaf_id
    }

##### Response
    {
      is_success: boolean is_success,
      status: {
        id: integer leaf_id,
        text: string status,
        user_id: integer user_id,
        user_name string posted user,
        favorites: integer favorites,
        timestamp: integer created_time
      }
    }

