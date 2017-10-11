
|Home          |Previous            | Next                  |
|--------------|--------------------|-----------------------|
|[Home](../../)|[Grains](../grains) |[Pillar](../pillar)    |

# Yaml

YAML stands for Yet Another Marup Language - which is a markup language used to define data. Salt renders the YAML data into Python objects during execution. As far as Salt is concerned, you only need to know three simple things about YAML!

## Rule 1
In YAML the data we are storing is basically hierarchical. So to separate them we use spaces and every level is separated by two spaces as you can see in example below. Please don't use tabs as they are not treated properly by YAML parsers

```
country:
  usa:
    states:
      - MA
      - OR
      - CA
```      

## Rule 2
When we want to store key value pairs, we use dictionaries. The syntax is simple - the key and value are separated by a colon (:). But you can nest the dictionaries to build complex and real world data structures. In such case the value of a key can be another key value pair and so on.


```
# Yaml Syntax
name: vishal

name:
  vishal

# Simple dict Python equivalent:

{'name': 'vishal'}  

# YAML Syntax
name:
  first_name: vishal  

# Nested dict Python equivalent:

{ 'name': {
		'first_name': 'vishal'
	}
}

```
## Rule 3

The third thing to know is that the lists are created by using "-" at same level and assining the list to a key. Lists again can be nested themselves so a list's item could be lists and so on.

```
grocery_list:
  - milk
  - bread
  - apples
  - oranges

# Python Equivalent

{ 'grocery_list':['milk', 'bread', 'apples', 'oranges'] }

```

## Conclusion

YAML is really simple if you follow these three basics. A real world YAML will of course be combination of lists and dictionaries. Just make sure to keep 2 spaces between things and you will be fine.

|Home          |Previous            | Next                  |
|--------------|--------------------|-----------------------|
|[Home](../../)|[Grains](../grains) |[Pillar](../pillar)    |