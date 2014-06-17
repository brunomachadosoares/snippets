""" The idea is to show the use of key functions
instead of comparator functions, easier and faster"""

names = ['bruno','marcio','ronaldo','sergio','ted','antonio','henrique']

def compare_length(c1, c2):
    if len(c1) < len(c2): return -1
    if len(c1) > len(c2): return 1
    return 0

def using_comparator():
    return sorted(names, cmp=compare_length)

def using_key():
    return sorted(names, key=len)

if __name__ == '__main__':
    import timeit
    print("Result with comparator   = ", timeit.timeit("using_comparator()", setup="from __main__ import using_comparator"))
    print("Result with key function = ", timeit.timeit("using_key()", setup="from __main__ import using_key"))
