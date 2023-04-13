---
title: DBMS Assignment on Redis
author: Chitram Dasgupta
---

# Question 1

What are the main features of redis?

## Answer

The main features of Redis are:

1. In-memory data storage:
   Redis stores data in RAM, allowing for extremely fast read and write operations. This makes it well-suited for use cases that require low-latency access to data, such as caching and real-time analytics.

2. Data structures:
   Redis supports a rich set of data structures, including strings, lists, sets, sorted sets, and hashes.

3. High performance
   Redis is known for its blazing fast performance, with low-latency response times and high throughput.

# Question 2

Write down the limitations of redis?

## Answer

1. Data Size Limitations

   Redis is an in-memory data store, which means that the amount of data it can store is limited by the available memory in the system.

2. Persistence Options

   Redis offers persistence options to persist data to disk, but it is not as robust as traditional disk-based databases.

3. Lack of Complex Data Structures

   Redis provides simple key-value and data structure operations, such as strings, lists, sets, hashes, and sorted sets. However, it lacks support for more complex data structures like graphs and indexes.

4. Single-threaded

   Redis uses a single thread to handle all requests, which means that it may not be able to take full advantage of multi-core processors.

# Question 3

Perform a basic CRUD operation using redis.

## Answer

1. Create key

   ```
   SET name Chitram
   ```

2. Read key

   ```
   GET name
   ```

3. Update key

   ```
   SET name 'Chitram Dasgupta'
   ```

4. Delete key

   ```
   DEL name
   ```

# Question 4

Explain TTL command with an example.

## Answer

TTL (Time-To-Live) is a command that allows you to set an expiration time for a key, after which the key will automatically be deleted from the database.

```
SET my_key 'Chitram Dasgupta'

EXPIRE my_key 60
```

`my_key` will now hava TTL of 60 seconds after which it will be deleted from the database.

To see, how much time `my_key` has till it expires, we can do:

```
TTL my_key
```

# Question 5

Create a transaction in redis to perform the following operations.

- Create two keys in a single line and one key differently. (one value
should be number)

- Read any two value in a single line

- Increment the number value

- Expire any two keys after some time

## Answer

```
MULTI
MSET key1 "value_1" key2 "value_2"
SET key3 99
MGET key1 key2
INCR key3
EXPIRE key1 60
EXPIRE key2 120
EXEC
```
