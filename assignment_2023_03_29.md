---
title: DBMS Assignment on NoSQL
author: Chitram Dasgupta
---

# Question 1

What is the main difference between SQL and NoSQL databases?

## Answer

| SQL                                    |                           NoSQL                           |
| :------------------------------------- | :-------------------------------------------------------: |
| SQL uses a predefined schema           |                NoSQL uses a dynamic schema                |
| SQL databases are vertically scalabale |         NoSQL databases are horizontally scalable         |
| SQL databases are table-based          | NoSQL databases can be document, key-value or graph based |

# Question 2

What are some of the benefits of using NoSQL databases over
traditional SQL databases?

## Answer

The benefits of using NoSQL databases over RDBMS are:

1. NoSQL databases make it very easy to work with various data formats like
   JSON, XML, various binary objects, and so on.

2. NoSQL databases also make it easy to operate on unstructured data like
   large unstructured text. There are tools available to gather insight
   from the text data, and also implement a searching facility across the
   text

3. NoSQL databases are handy in adapting the database to changes in business
   requirement as they do not have a predefined schema and incorporate
   changes in a dynamic fashion

4. Enables horizontal scaling. Thus, it becomes cost-effective to increase
   the capacity of our database my provisioning multiple cheap servers
   on-the-fly.

# Question 3

What are some common use cases for NoSQL databases?

## Answer

Some of the common use cases for NoSQL databases are:

1. Digital and media management applications that store and retrieve a large
   number of high-resolution images and videos.

2. Internet of Things (IoT) and sensor data.

3. Messaging applications that require performance and availability and also
   searching capabilities.

4. Content mnagement system for enterprise as well as personal use-cases.

# Question 4

What are the four main types of NoSQL databases, and what are
their key characteristics?

## Answer

1. Document databases

   A document database stores data in JSON, BSON, or XML documents. These formats can be
   used easily in applications. They have become popular because they aid in developer
   productivity because developers can easily change the document to suit the business
   needs.

2. Key-value stores

   In this type of a NoSQL database, all data elements are stored as key-value pairs
   with an attribute and the corresponding value. Popular key-value NoSQL databases
   like Redis offer many helpful data types like strings, lists, sets, sorted lists,
   sorted sets and hashes, and so on.

3. Column-oriented databases

   Column-oriented databases are organized as a set of columns. Each column is usually
   of the same type and benefit from data compression. This helps in decision-making
   as we can run data-analytics on the columns directly without having to retrieve
   unnecessary data.

4. Graph databases

   In graph databses, each element is stored as a node and the relationship between
   nodes are modelled as the links of a graph data structure. They are optimized
   to capture the complex relationships between data elements and can express them
   easily as compated to RDBMS.

# Question 5

What is the CAP theorem, and how does it relate to distributed
systems?

## Answer

CAP theorem states that a distributed system can deliver only two of three desired characteristics: **consistency**, **availability**, and **partition tolerance**.

A distributed system is a network that stores data on more than one node (physical or virtual machines) at the same time. All cloud applications are distributed systems.

For instance, in a distributed system that prioritizes Consistency and Availability, it may forego Partition Tolerance, resulting in potential operational interruptions during network partitions. Conversely, if a system prioritizes Availability and Partition Tolerance, it may compromise Consistency, leading to temporary data inconsistencies among clients. Likewise, if a system emphasizes Consistency and Partition Tolerance, it may sacrifice Availability, resulting in potential operational limitations during failures.

# Question 6

What are the three properties of the CAP theorem?

## Answer

1. Consistency

   Consistency refers to the requirement that all clients observe identical data simultaneously, regardless of the node they connect to. In order to achieve this, any data written to one node must be replicated to all other nodes in the system before considering the write as successful.

2. Availability

   Availability ensures that every client requesting data receives a response, even if one or more nodes in the system are unavailable. In other words, all operational nodes in the distributed system consistently provide a valid response for any request, without exceptions.

3. Partition tolerance

   A partition in a distributed system refers to a communication breakdown between nodes, resulting in lost or temporarily delayed connections. Partition tolerance denotes the system's ability to continue functioning effectively, even in the presence of such communication failures between nodes, ensuring reliable operation despite potential disruptions.

# Question 7

What are the BASE properties, and how do they relate to the CAP
theorem?

## Answer

The BASE properties are a set of principles that are associated with NoSQL databses just like ACID
properties are associated with with SQL Databases.

1. Basically Available

   This means that the system remains operational and responsive to client requests, even in the presence of failures. It does not necessarily guarantee strict consistency or immediate availability of data, but rather focuses on providing acceptable availability levels.

2. Soft-state

   This means that the state of the system can evolve over time, and there may be temporary inconsistencies or conflicts in data, especially in distributed or replicated systems.

3. Eventually Consistent

   This means that the system eventually reaches a consistent state, but there may be temporary inconsistencies or conflicts in data that are eventually resolved without blocking client operations.

In relation to the CAP theorem, the BASE properties are aligned with the idea of prioritizing Availability and Partition Tolerance over strict Consistency in distributed systems. This means that in a distributed system that adheres to the BASE properties, it may sacrifice strong Consistency in favor of providing acceptable Availability and Partition Tolerance, which aligns with the trade-offs presented by the CAP theorem.
