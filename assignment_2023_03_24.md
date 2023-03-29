---
title: RDBMS assignment on normalization
author: Chitram Dasgupta
---

# Question 1

Determine the highest normal form of this relation scheme.

The relation scheme student Performance (StudentName, CourseNo, EnrollmentNo, Grade)
has the following functional dependencies:

StudentName, courseNo → grade
EnrollmentNo, courseNo → grade
StudentName →EnrollmentNo
EnrollmentNo →StudentName

## Answer

`{CourseNo, StudentName}^+ -> { CourseNo, StudentName, EntrollmentNo, Grade }`

`{CourseNo, EntrollmentNo}^+ -> { CourseNo, StudentName, EntrollmentNo, Grade }`

`Candidate key = { {CourseNo, StudentName}, {CourseNo, EntrollmentNo} }`

`primary attribute = { CourseNo, StudentName, EntrollmentNo }`

`non-primary attribute = { Grade }`

For *BCNF*, the relation is not in BCNF because in production `StudentName -> EnrollmentNo`,
`StudentName` is not a candidate key.

The relation is in **3NF** because in all productions, either the determiner is a
candidate key or the determinant is a primary attribute.

# Question 2

Suppose you are given a relation R= (A, B, C, D, E ) with the following functional
dependencies:{CE →D, D→B, C →A}

a. Find all candidate keys.

b. Identify the best normal form that R satisfies (1NF, 2NF, 3NF, or BCNF).

c. If the relation is not in BCNF, decompose it until it becomes BCNF. At each step, identify a
new relation, decompose and re-compute the keys and the normal forms they satisfy.

## Answer

### a. 

`CE^+ = CEDBA`

`Candidate key = { CE }`

`primary attribute = { C, E }`

`non-primary attribute = { A, B, D }`

### b.

For *BCNF*, the relation is not in BCNF because in production `D -> B`, `D` is not a
candidate key.

For *3NF*, the relation is not in 3NF because in production `D -> B`, `D` is not a
candidate key and B is not a prime attribute.

For *2NF*, the relation is not in 2NF because production `C -> A` has a partial
dependency i.e `C` is a proper subset of a candidate key and `A` is a non-prime
attribute.

The relation is in **1NF**.

### c.

We have the relation `R(A, B, C, D, E)` in 1NF.

We can decompose it to `R1(B, C, D, E)` and `R2(C, A)`.

We can clearly see that `R2(C, A)` is in **BCNF** with `FD: { C -> A }`
and `C` as the primary key.

`R1(B, C, D, E)` is in 2NF and has `FD: { CE -> D, D -> B }`

We can further divide `R1` into `R11(C, D, E)` and `R12(B, D)`.

`R11(C, D, E)` is in **BCNF** because in production `CE -> D`, `CE` is a candidate key

`R12(B, D)` is in **BCNF** because in production `D -> B`, `D` is a candidate key for this
relation.

# Question 3

You are given the following set F of functional dependencies for relation R(A, B, C, D, E, F):

F={ABC →D, ABD→E,CD→F,CDF →B,BF →D}

a. Find all keys of R based on these functional dependencies.

b. Is this relation in Boyce-Codd Normal Form? Is it 3NF? Explain your answers.

## Answer

### a.

`ABC^+ = ABCDEF`

`ACD^+ = ACDFBDE`

`Candidate key = { ABC, ACD }`

`primary attribute = { A, B, C, D }`

`non-primary attribute = { E, F }`

### b.

For *BCNF*, the relation is not in BCNF because in production `ABD -> E`, `ABD` is not a
candidate key.

For *3NF*, the relation is not in 3NF because in production `ABD -> E`, `ABD` is not a
candidate key and `E` is not a prime attribute.

# Question 4

Write the advantages and disadvantages of normalization.

## Answer

The *advantages* are as follows:

i. Data redundancy is removed as a result of normalization.

ii. Normalization helps in maintaining consistency and avoiding anomalies
in a database.

iii. Also helps in joins as we get minimal tables and we can only join the
required tables.

The *disadvantages* are as follows:

i. For a large database, normalization can be a very complex task.

ii. For a normalized database, maintenance can be an issue as we get a large
number of normalized tables.

# Question 5

Determine the decomposition.

Consider the schema R = (S T U V) and the dependencies S → T, T → U, U → V, and V → S.
Let R = (R1 and R2) be a decomposition such that R1 ∩ R2 ≠ ∅.

## Answer

We can perform lossless decomposition of the relation `R` into `R1(S, T, U)` 
and `R2(U, V)`. Clearly, `R1 ∩ R2 ≠ ∅` because `U` is the common attribute.

Further, the decomposed relations are in **3NF**.
