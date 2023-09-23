import matplotlib.pyplot as plt

# Read test result from test.txt
# Plot a figure
file_path = 'test.txt'

x, y = {}, {}

with open(file_path, 'r') as f:
    for line in f.readlines():
        a, b, c = line.strip().split()
        if not a in x:
            x[a], y[a] = [], []
        d, b, c = eval(a), eval(b), eval(c)
        x[a].append(b)
        y[a].append(c / d)

fig = plt.figure()

plt.title('Copy - Buffer Size Test')
plt.xlabel('Buffer size (Bytes)')
plt.ylabel('Average time per MiB (ms / MiB)')
for a in x.keys():
    plt.semilogx(x[a], y[a], marker='*', label=a+' MiB')
plt.legend()

fig.savefig('fig.pdf')
