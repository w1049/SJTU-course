import os
import sys

msize = [32, 64, 128, 256, 512, 1024, 2048, 4096]
nthread = [1, 2, 4, 6, 8, 16]

# msize = [32, 64, 128, 256, 512, 1024, 2048]
# nthread = [4]

results = []

for n in nthread:
    os.system('gcc -DTIME -DNTHREAD=' + str(n) + ' multi.c -lpthread -o multitest -O3')
    for m in msize:
        os.system('rm -f random.out')
        with os.popen('./multitest ' + str(m)) as f:
            result = f.readlines()
            print(n, m, result[0], file=sys.stderr)
            print(n, m, result[0])
