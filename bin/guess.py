#!/usr/bin/env python3

print("myslim si cislo od 1 do 20")
secret = 8 
print(f"tajne cislo je {secret}")

tip = input("tvoj tip: ")
tip=int(tip)
print(f"tvoj tip je: {tip}")

if tip < secret:
    print(f"moje cislo je vascie ako tvoje")
elif tip > secret:
    print(f"moje cislo je mensie ako tvoje")
else:
    print(f"genius")
