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
        y[a].append(c / b / b / b * 1000 * 1000)

fig = plt.figure()

plt.title('Matrix Test')
plt.xlabel('Matrix size')
plt.ylabel('Time / n^3 (ns)')
for a in x.keys():
    plt.semilogx(x[a], y[a], marker='*', label=a+' thread'+('s' if eval(a) > 1 else ''))
plt.legend()

fig.savefig('fig.pdf')
