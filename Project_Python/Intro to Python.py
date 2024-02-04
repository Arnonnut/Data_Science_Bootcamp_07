# -*- coding: utf-8 -*-

# -- Sheet --

# # Review Python Language


print("hello world")

my_name = "Toy"
my_age = 33

print(my_name)
print(my_age)
print(1 + 1)

# string & fstring in Python
my_name = "Toy"
my_university = 'Kasetsart'

my_long_string = """This is a very long
    This is a second line
    This is a third line
"""

print(my_name, my_university, my_long_string)

# fstring template
my_name = "Toy"
my_age = 33

text = f"my name is {my_name}, and I am {my_age} year old."
print(text)

# function designed for string (string methods)
text = "a duck walks into a bar"

text.upper()

"HELLO WORLD".lower()

text.count("duck")

text2 = text.replace('duck', 'lion')
print(text)
print(text2)

# list
shopping_list = ['egg', 'mike', 'bread']
print(shopping_list)

print(shopping_list[0:2])

# List method = append
shopping_list.append('orange juice')
print(shopping_list)

shopping_list.append('water bottle')
print(shopping_list)

# list method .pop()
shopping_list.pop()

shopping_list

len(shopping_list)

# dictionary key-value pair

student = {
    "id" : 1,
    "name": "Marry",
    "age": 22,
    "movies": ["Spider Man", "Thor", "Iron Man 3"]
}

student['movies'][2]

student['city'] = 'London'
student

#update value
student['city'] = 'Manchester'
student

# remove key-value
del student['city']
student

# user-defined function
def hello(username):
    print("Hello!" + username)

hello("toy")

def my_sum(val1, val2):
    return val1 + val2
result = my_sum(5, 15)

print(result)

class  Dog:
    name = "Toy"
    age = 5
    color = "Brown"
    breed = "French Bulldog"

#function (Dog method)
    def sitting(self):
        print("I am sitting now!")
    
    def hungry(self, food_name):
        print(f"I am hungry, I need {food_name}!")

my_dog = Dog()
type(my_dog)

my_dog.sitting()

my_dog.hungry("Pizza")

