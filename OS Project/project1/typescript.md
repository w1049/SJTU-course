# Build
Use
```shell
make
```
in the root directory (which includes Copy, matrix, shell, Makefile and so on),
executables `Copy`, `shell`, `single` and `multi` will be made out in the corresponding directories. You can `cd Copy` for example and test each program.

And you can use
```shell
make clean
```
to delete all made-out files.

# Copy
## Usage
```shell
./Copy <InputFile> <OutputFile> [BufferSize]
```
This command can copy the InputFile to OutputFile. For example,
we can use create a file `test.out` with the same content as `test.in`:
```shell
./Copy test.in test.out 128
```
The program will print message:
```
Read file end.
Write file end.
Success! Time used: 0.176000 ms
```
And we can verify the result with:
```shell
diff test.in test.out
```
which will print nothing if the two files are the same.

## Test
```shell
cd Copy
```
I have prepared somthing for testing.
### Auto test
Use this to test and plot the figure:
```shell
make test && python3 plot.py
```
or mini edition:
```shell
make test MINI=1 && python3 plot.py
```

### Generate data
```shell
make gen
```
Then generate a file `test.in` with:
```
./gen <FileSize>
```
### Change timer
Build Copy with
```
make app
```
Use options `TIME=1` or `TIME=2` to switch the timer,
for example:
```
make app TIME=1
```
### Plot the result
`plot.py` reads result from `test.txt`, write the image to `fig.pdf`.
```shell
python3 plot.py
```

# shell
## Usage
Firstly start the shell server:
```shell
./shell <Port>
```
If everything goess well, the program will print:
```
Start listening on port 12345...
```
Then use telnet as a client:
```shell
telnet localhost <Port>
```
Notice that it's allowed to use more than one client at the same time.
After connecting, telnet will receive:
```
Welcome to shell!
/home/w10493/project1/shell$
```

You can type command here, for example:
```shell
ls | wc | wc
```
The output is
```
      1       3      24
```
and the server prints:
```
Client connected from 127.0.0.1:15029
Received from port 15029: ls | wc | wc
```
Use command
```
exit
```
to close the connection. When a client exits, the server prints:
```
Client on port 15029 exited
```
# matrix
## Usage
```shell
./single # input from "data.in", output to "data.out"
./multi # input from "data.in", output to "data.out"
./multi <Size> # output to "random.out"
```
Prepare `data.in` file, and use `./single` or `./multi`
to calculate it. If providing an argument \<Size\>, `multi`
will randomly generate the data as input.
## Test
use
```shell
python3 test.py > test.txt
```
then
```shell
python3 plot.py
```
and the result will be plotted in `fig.pdf`.