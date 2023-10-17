prime_digits =  [2,3,5,7,0]
alloc_digits = []
new_digits = []
indices = {1: 0, 2:1}

def get_index(z):
    digits = filter(lambda x: (x < 10), indices.keys())
    dl = list(digits)
    
    for n in range(200):
        free = True
        for i in dl:
            if (n + indices.get(i)) in indices.values():
                free = False
                break
        if free == True:
            print("Free slot for", z, "at", n)
            break

    return n

for p in prime_digits:
    alloc_digits.append(p)
    new_digits.append(p)
    
    while len(new_digits) > 0:
        nd = new_digits.pop(0)
        if(indices.get(nd) == None):
            indices[nd] = get_index(nd)
            if(nd == 0): break
            
        for d in alloc_digits:
            np = d*nd
            indices[np] = indices.get(d) + indices.get(nd)

            if(np < 10 and np > 0):
                if (np not in alloc_digits):
                    new_digits.append(np)
                    alloc_digits.append(np)
                    
print(indices)
