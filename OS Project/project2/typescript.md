# Build
Use
```shell
make
```
to compile two executable file `LCM` and `faneuil`.

# LCM
## Settings
Two variables can be modified:
```c
const int MAXSLEEP = 50; // ms
int endnum = 123; // num to exit the program
```
## Test
Use
```shell
./LCM 5
```
The output is (for example):
```
Maximum number of unfilled holes: 5
Begin run.
Larry digs another hole #1.
Moe plants a seed in a hole #1.
Curly fills a planted hole #1.
Larry digs another hole #2.
Moe plants a seed in a hole #2.
Larry digs another hole #3.
Moe plants a seed in a hole #3.
Curly fills a planted hole #2.
Larry digs another hole #4.
Curly fills a planted hole #3.
Moe plants a seed in a hole #4.
Larry digs another hole #5.
Curly fills a planted hole #4.
Moe plants a seed in a hole #5.
Larry digs another hole #6.
Moe plants a seed in a hole #6.
Curly fills a planted hole #5.
Larry digs another hole #7.
Moe plants a seed in a hole #7.
Curly fills a planted hole #6.
Larry digs another hole #8.
Moe plants a seed in a hole #8.
Curly fills a planted hole #7.
Larry digs another hole #9.
Curly fills a planted hole #8.
Moe plants a seed in a hole #9.
Larry digs another hole #10.
Moe plants a seed in a hole #10.
Curly fills a planted hole #9.
Larry digs another hole #11.
Curly fills a planted hole #10.
Moe plants a seed in a hole #11.
Larry digs another hole #12.
Moe plants a seed in a hole #12.
Curly fills a planted hole #11.
Larry digs another hole #13.
Curly fills a planted hole #12.
Moe plants a seed in a hole #13.
Larry digs another hole #14.
Moe plants a seed in a hole #14.
Curly fills a planted hole #13.
Larry digs another hole #15.
Moe plants a seed in a hole #15.
Curly fills a planted hole #14.
Larry digs another hole #16.
Moe plants a seed in a hole #16.
Curly fills a planted hole #15.
Larry digs another hole #17.
Curly fills a planted hole #16.
Moe plants a seed in a hole #17.
Larry digs another hole #18.
Curly fills a planted hole #17.
Larry digs another hole #19.
Moe plants a seed in a hole #18.
Moe plants a seed in a hole #19.
Curly fills a planted hole #18.
Larry digs another hole #20.
Moe plants a seed in a hole #20.
Curly fills a planted hole #19.
Larry digs another hole #21.
Moe plants a seed in a hole #21.
Curly fills a planted hole #20.
Larry digs another hole #22.
Moe plants a seed in a hole #22.
Curly fills a planted hole #21.
Larry digs another hole #23.
Larry digs another hole #24.
Curly fills a planted hole #22.
Moe plants a seed in a hole #23.
Larry digs another hole #25.
Moe plants a seed in a hole #24.
Curly fills a planted hole #23.
Larry digs another hole #26.
Moe plants a seed in a hole #25.
Curly fills a planted hole #24.
Larry digs another hole #27.
Moe plants a seed in a hole #26.
Curly fills a planted hole #25.
Larry digs another hole #28.
Curly fills a planted hole #26.
Moe plants a seed in a hole #27.
Larry digs another hole #29.
Curly fills a planted hole #27.
Moe plants a seed in a hole #28.
Moe plants a seed in a hole #29.
Larry digs another hole #30.
Moe plants a seed in a hole #30.
Curly fills a planted hole #28.
Larry digs another hole #31.
Moe plants a seed in a hole #31.
Curly fills a planted hole #29.
Larry digs another hole #32.
Curly fills a planted hole #30.
Moe plants a seed in a hole #32.
Larry digs another hole #33.
Curly fills a planted hole #31.
Moe plants a seed in a hole #33.
Larry digs another hole #34.
Moe plants a seed in a hole #34.
Curly fills a planted hole #32.
Larry digs another hole #35.
Curly fills a planted hole #33.
Moe plants a seed in a hole #35.
Larry digs another hole #36.
Moe plants a seed in a hole #36.
Curly fills a planted hole #34.
Larry digs another hole #37.
Curly fills a planted hole #35.
Moe plants a seed in a hole #37.
Larry digs another hole #38.
Curly fills a planted hole #36.
Moe plants a seed in a hole #38.
Larry digs another hole #39.
Curly fills a planted hole #37.
Moe plants a seed in a hole #39.
Larry digs another hole #40.
Moe plants a seed in a hole #40.
Curly fills a planted hole #38.
Larry digs another hole #41.
Moe plants a seed in a hole #41.
Curly fills a planted hole #39.
Larry digs another hole #42.
Curly fills a planted hole #40.
Moe plants a seed in a hole #42.
Larry digs another hole #43.
Moe plants a seed in a hole #43.
Curly fills a planted hole #41.
Larry digs another hole #44.
Curly fills a planted hole #42.
Moe plants a seed in a hole #44.
Larry digs another hole #45.
Moe plants a seed in a hole #45.
Larry digs another hole #46.
Curly fills a planted hole #43.
Larry digs another hole #47.
Moe plants a seed in a hole #46.
Curly fills a planted hole #44.
Larry digs another hole #48.
Moe plants a seed in a hole #47.
Larry digs another hole #49.
Curly fills a planted hole #45.
Moe plants a seed in a hole #48.
Moe plants a seed in a hole #49.
Larry digs another hole #50.
Curly fills a planted hole #46.
Larry digs another hole #51.
Moe plants a seed in a hole #50.
Curly fills a planted hole #47.
Larry digs another hole #52.
Moe plants a seed in a hole #51.
Curly fills a planted hole #48.
Larry digs another hole #53.
Curly fills a planted hole #49.
Moe plants a seed in a hole #52.
Moe plants a seed in a hole #53.
Larry digs another hole #54.
Curly fills a planted hole #50.
Moe plants a seed in a hole #54.
Larry digs another hole #55.
Curly fills a planted hole #51.
Larry digs another hole #56.
Moe plants a seed in a hole #55.
Curly fills a planted hole #52.
Larry digs another hole #57.
Moe plants a seed in a hole #56.
Curly fills a planted hole #53.
Moe plants a seed in a hole #57.
Curly fills a planted hole #54.
Larry digs another hole #58.
Curly fills a planted hole #55.
Larry digs another hole #59.
Moe plants a seed in a hole #58.
Curly fills a planted hole #56.
Larry digs another hole #60.
Curly fills a planted hole #57.
Moe plants a seed in a hole #59.
Moe plants a seed in a hole #60.
Larry digs another hole #61.
Moe plants a seed in a hole #61.
Curly fills a planted hole #58.
Larry digs another hole #62.
Curly fills a planted hole #59.
Moe plants a seed in a hole #62.
Curly fills a planted hole #60.
Larry digs another hole #63.
Curly fills a planted hole #61.
Larry digs another hole #64.
Moe plants a seed in a hole #63.
Moe plants a seed in a hole #64.
Curly fills a planted hole #62.
Larry digs another hole #65.
Curly fills a planted hole #63.
Moe plants a seed in a hole #65.
Larry digs another hole #66.
Curly fills a planted hole #64.
Moe plants a seed in a hole #66.
Larry digs another hole #67.
Curly fills a planted hole #65.
Moe plants a seed in a hole #67.
Larry digs another hole #68.
Curly fills a planted hole #66.
Larry digs another hole #69.
Moe plants a seed in a hole #68.
Larry digs another hole #70.
Moe plants a seed in a hole #69.
Moe plants a seed in a hole #70.
Curly fills a planted hole #67.
Larry digs another hole #71.
Moe plants a seed in a hole #71.
Larry digs another hole #72.
Curly fills a planted hole #68.
Moe plants a seed in a hole #72.
Larry digs another hole #73.
Curly fills a planted hole #69.
Moe plants a seed in a hole #73.
Curly fills a planted hole #70.
Larry digs another hole #74.
Moe plants a seed in a hole #74.
Curly fills a planted hole #71.
Larry digs another hole #75.
Larry digs another hole #76.
Moe plants a seed in a hole #75.
Curly fills a planted hole #72.
Moe plants a seed in a hole #76.
Larry digs another hole #77.
Curly fills a planted hole #73.
Moe plants a seed in a hole #77.
Curly fills a planted hole #74.
Larry digs another hole #78.
Curly fills a planted hole #75.
Moe plants a seed in a hole #78.
Larry digs another hole #79.
Curly fills a planted hole #76.
Curly fills a planted hole #77.
Moe plants a seed in a hole #79.
Larry digs another hole #80.
Curly fills a planted hole #78.
Moe plants a seed in a hole #80.
Larry digs another hole #81.
Curly fills a planted hole #79.
Larry digs another hole #82.
Moe plants a seed in a hole #81.
Curly fills a planted hole #80.
Moe plants a seed in a hole #82.
Larry digs another hole #83.
Curly fills a planted hole #81.
Moe plants a seed in a hole #83.
Larry digs another hole #84.
Moe plants a seed in a hole #84.
Curly fills a planted hole #82.
Larry digs another hole #85.
Moe plants a seed in a hole #85.
Curly fills a planted hole #83.
Larry digs another hole #86.
Moe plants a seed in a hole #86.
Curly fills a planted hole #84.
Larry digs another hole #87.
Moe plants a seed in a hole #87.
Curly fills a planted hole #85.
Larry digs another hole #88.
Curly fills a planted hole #86.
Moe plants a seed in a hole #88.
Larry digs another hole #89.
Curly fills a planted hole #87.
Curly fills a planted hole #88.
Moe plants a seed in a hole #89.
Larry digs another hole #90.
Curly fills a planted hole #89.
Moe plants a seed in a hole #90.
Larry digs another hole #91.
Curly fills a planted hole #90.
Moe plants a seed in a hole #91.
Curly fills a planted hole #91.
Larry digs another hole #92.
Moe plants a seed in a hole #92.
Curly fills a planted hole #92.
Larry digs another hole #93.
Moe plants a seed in a hole #93.
Curly fills a planted hole #93.
Larry digs another hole #94.
Moe plants a seed in a hole #94.
Larry digs another hole #95.
Curly fills a planted hole #94.
Moe plants a seed in a hole #95.
Curly fills a planted hole #95.
Larry digs another hole #96.
Moe plants a seed in a hole #96.
Larry digs another hole #97.
Curly fills a planted hole #96.
Larry digs another hole #98.
Moe plants a seed in a hole #97.
Curly fills a planted hole #97.
Larry digs another hole #99.
Moe plants a seed in a hole #98.
Moe plants a seed in a hole #99.
Larry digs another hole #100.
Curly fills a planted hole #98.
Moe plants a seed in a hole #100.
Larry digs another hole #101.
Curly fills a planted hole #99.
Moe plants a seed in a hole #101.
Curly fills a planted hole #100.
Larry digs another hole #102.
Moe plants a seed in a hole #102.
Larry digs another hole #103.
Moe plants a seed in a hole #103.
Curly fills a planted hole #101.
Larry digs another hole #104.
Curly fills a planted hole #102.
Moe plants a seed in a hole #104.
Curly fills a planted hole #103.
Larry digs another hole #105.
Moe plants a seed in a hole #105.
Curly fills a planted hole #104.
Larry digs another hole #106.
Larry digs another hole #107.
Moe plants a seed in a hole #106.
Curly fills a planted hole #105.
Curly fills a planted hole #106.
Larry digs another hole #108.
Moe plants a seed in a hole #107.
Larry digs another hole #109.
Moe plants a seed in a hole #108.
Curly fills a planted hole #107.
Larry digs another hole #110.
Curly fills a planted hole #108.
Moe plants a seed in a hole #109.
Curly fills a planted hole #109.
Larry digs another hole #111.
Moe plants a seed in a hole #110.
Moe plants a seed in a hole #111.
Curly fills a planted hole #110.
Larry digs another hole #112.
Curly fills a planted hole #111.
Larry digs another hole #113.
Moe plants a seed in a hole #112.
Larry digs another hole #114.
Curly fills a planted hole #112.
Moe plants a seed in a hole #113.
Larry digs another hole #115.
Curly fills a planted hole #113.
Larry digs another hole #116.
Moe plants a seed in a hole #114.
Curly fills a planted hole #114.
Moe plants a seed in a hole #115.
Larry digs another hole #117.
Moe plants a seed in a hole #116.
Curly fills a planted hole #115.
Moe plants a seed in a hole #117.
Larry digs another hole #118.
Curly fills a planted hole #116.
Moe plants a seed in a hole #118.
Larry digs another hole #119.
Curly fills a planted hole #117.
Moe plants a seed in a hole #119.
Larry digs another hole #120.
Curly fills a planted hole #118.
Moe plants a seed in a hole #120.
Larry digs another hole #121.
Curly fills a planted hole #119.
Larry digs another hole #122.
Curly fills a planted hole #120.
Moe plants a seed in a hole #121.
Larry digs another hole #123.
Moe plants a seed in a hole #122.
Curly fills a planted hole #121.
Moe plants a seed in a hole #123.
Curly fills a planted hole #122.
Curly fills a planted hole #123.
End run.
```
# faneuil
## Settings
Four variables can be modified:
```c
// Probability, spec_per = 1 - 0.6 - 0.2 = 0.2
const double IMM_PER = 0.6;
const double JUD_PER = 0.2;

const int MAXSLEEP = 50; // ms
#define MAXTHREAD 12345
```

## Test
Use
```shell
./faneuil
```
The program runs in an infinite loop, so at some point press Ctrl+C.
The output is (for example):
```
Immigrant #0 enter
Immigrant #0 checkIn
Judge #0 enter
Immigrant #0 sitDown
Judge #0 confirm the immigrant #0
Judge #0 leave
Immigrant #0 swear
Immigrant #0 getCertificate
Immigrant #0 leave
Immigrant #1 enter
Immigrant #1 checkIn
Immigrant #1 sitDown
Immigrant #2 enter
Immigrant #2 checkIn
Immigrant #2 sitDown
Immigrant #3 enter
Immigrant #3 checkIn
Immigrant #3 sitDown
Immigrant #4 enter
Immigrant #4 checkIn
Immigrant #4 sitDown
Immigrant #5 enter
Immigrant #5 checkIn
Immigrant #5 sitDown
Immigrant #6 enter
Immigrant #6 checkIn
Immigrant #7 enter
Immigrant #7 checkIn
Immigrant #6 sitDown
Immigrant #7 sitDown
Immigrant #8 enter
Immigrant #8 checkIn
Immigrant #9 enter
Immigrant #9 checkIn
Immigrant #9 sitDown
Immigrant #8 sitDown
Immigrant #10 enter
Spectator #0 enter
Immigrant #10 checkIn
Spectator #0 spectate
Immigrant #10 sitDown
Immigrant #11 enter
Immigrant #11 checkIn
Immigrant #11 sitDown
Immigrant #12 enter
Immigrant #12 checkIn
Immigrant #12 sitDown
Spectator #0 leave
Immigrant #13 enter
Immigrant #13 checkIn
Immigrant #13 sitDown
Immigrant #14 enter
Immigrant #14 checkIn
Immigrant #14 sitDown
Spectator #1 enter
Spectator #1 spectate
Spectator #1 leave
Immigrant #15 enter
Immigrant #15 checkIn
Immigrant #15 sitDown
Spectator #2 enter
Spectator #2 spectate
Immigrant #16 enter
Immigrant #16 checkIn
Immigrant #16 sitDown
Spectator #2 leave
Immigrant #17 enter
Immigrant #17 checkIn
Immigrant #17 sitDown
Immigrant #18 enter
Immigrant #18 checkIn
Immigrant #18 sitDown
Judge #1 enter
Judge #1 confirm the immigrant #14
Judge #1 confirm the immigrant #5
Judge #1 confirm the immigrant #11
Judge #1 confirm the immigrant #3
Judge #1 confirm the immigrant #7
Judge #1 confirm the immigrant #12
Judge #1 confirm the immigrant #9
Judge #1 confirm the immigrant #16
Immigrant #9 swear
Judge #1 confirm the immigrant #15
Immigrant #12 swear
Judge #1 confirm the immigrant #10
Judge #1 confirm the immigrant #13
Judge #1 confirm the immigrant #1
Immigrant #16 swear
Judge #1 confirm the immigrant #18
Judge #1 confirm the immigrant #6
Immigrant #3 swear
Immigrant #11 swear
Judge #1 confirm the immigrant #4
Immigrant #11 getCertificate
Judge #1 confirm the immigrant #2
Immigrant #6 swear
Immigrant #4 swear
Judge #1 confirm the immigrant #8
Judge #1 confirm the immigrant #17
Immigrant #14 swear
Immigrant #5 swear
Immigrant #17 swear
Immigrant #9 getCertificate
Immigrant #13 swear
Immigrant #7 swear
Immigrant #16 getCertificate
Immigrant #3 getCertificate
Immigrant #7 getCertificate
Immigrant #15 swear
Immigrant #18 swear
Immigrant #14 getCertificate
Immigrant #1 swear
Immigrant #17 getCertificate
Immigrant #10 swear
Immigrant #12 getCertificate
Immigrant #5 getCertificate
Immigrant #8 swear
Immigrant #6 getCertificate
Immigrant #4 getCertificate
Immigrant #15 getCertificate
Judge #1 leave
Immigrant #2 swear
Immigrant #13 getCertificate
Immigrant #1 getCertificate
Immigrant #18 getCertificate
Immigrant #10 getCertificate
Immigrant #8 getCertificate
Immigrant #11 leave
Immigrant #2 getCertificate
Immigrant #9 leave
Immigrant #16 leave
Immigrant #3 leave
Immigrant #7 leave
Immigrant #14 leave
Immigrant #17 leave
Immigrant #12 leave
Immigrant #5 leave
Immigrant #6 leave
Immigrant #4 leave
Immigrant #15 leave
Immigrant #13 leave
Immigrant #1 leave
Immigrant #18 leave
Immigrant #10 leave
Immigrant #8 leave
Judge #2 enter
Judge #2 leave
Immigrant #2 leave
Immigrant #19 enter
Immigrant #20 enter
Immigrant #19 checkIn
Immigrant #20 checkIn
Immigrant #20 sitDown
Immigrant #19 sitDown
Immigrant #21 enter
Immigrant #21 checkIn
Immigrant #21 sitDown
Immigrant #22 enter
Immigrant #22 checkIn
Immigrant #22 sitDown
Immigrant #23 enter
Immigrant #23 checkIn
Immigrant #23 sitDown
Immigrant #24 enter
Immigrant #24 checkIn
Immigrant #24 sitDown
Immigrant #25 enter
Immigrant #25 checkIn
Immigrant #25 sitDown
Immigrant #26 enter
Immigrant #26 checkIn
Immigrant #26 sitDown
Immigrant #27 enter
Immigrant #27 checkIn
Immigrant #27 sitDown
Spectator #3 enter
Spectator #3 spectate
Immigrant #28 enter
Immigrant #28 checkIn
Immigrant #28 sitDown
Spectator #3 leave
Immigrant #29 enter
Immigrant #29 checkIn
Immigrant #29 sitDown
Immigrant #30 enter
Immigrant #30 checkIn
Immigrant #30 sitDown
Immigrant #31 enter
Immigrant #31 checkIn
Immigrant #31 sitDown
Spectator #4 enter
Spectator #4 spectate
Spectator #4 leave
Immigrant #32 enter
Immigrant #32 checkIn
Immigrant #32 sitDown
Immigrant #33 enter
Immigrant #33 checkIn
Immigrant #33 sitDown
Spectator #5 enter
Spectator #5 spectate
Immigrant #34 enter
Immigrant #34 checkIn
Immigrant #34 sitDown
Spectator #5 leave
Spectator #6 enter
Spectator #6 spectate
Spectator #6 leave
Immigrant #35 enter
Immigrant #35 checkIn
Immigrant #35 sitDown
Spectator #7 enter
Spectator #7 spectate
Spectator #7 leave
Spectator #8 enter
Spectator #8 spectate
Judge #3 enter
Judge #3 confirm the immigrant #21
Judge #3 confirm the immigrant #23
Judge #3 confirm the immigrant #34
Judge #3 confirm the immigrant #26
Judge #3 confirm the immigrant #32
Judge #3 confirm the immigrant #22
Immigrant #32 swear
Immigrant #21 swear
Judge #3 confirm the immigrant #19
Judge #3 confirm the immigrant #29
Immigrant #32 getCertificate
Judge #3 confirm the immigrant #25
Immigrant #22 swear
Judge #3 confirm the immigrant #33
Judge #3 confirm the immigrant #31
Judge #3 confirm the immigrant #30
Judge #3 confirm the immigrant #24
Judge #3 confirm the immigrant #20
Immigrant #24 swear
Immigrant #31 swear
Immigrant #19 swear
Judge #3 confirm the immigrant #27
Immigrant #30 swear
Immigrant #21 getCertificate
Judge #3 confirm the immigrant #28
Immigrant #34 swear
Judge #3 confirm the immigrant #35
Immigrant #31 getCertificate
Immigrant #26 swear
Immigrant #23 swear
Immigrant #27 swear
Immigrant #26 getCertificate
Immigrant #22 getCertificate
Immigrant #24 getCertificate
Immigrant #29 swear
Immigrant #20 swear
Immigrant #28 swear
Immigrant #35 swear
Immigrant #25 swear
Immigrant #27 getCertificate
Immigrant #19 getCertificate
Judge #3 leave
Immigrant #33 swear
Immigrant #33 getCertificate
Immigrant #30 getCertificate
Immigrant #28 getCertificate
Immigrant #23 getCertificate
Immigrant #34 getCertificate
Immigrant #20 getCertificate
Immigrant #25 getCertificate
Immigrant #29 getCertificate
Immigrant #35 getCertificate
Immigrant #32 leave
Immigrant #21 leave
Immigrant #31 leave
Immigrant #26 leave
Immigrant #22 leave
Immigrant #24 leave
Spectator #8 leave
Immigrant #36 enter
Immigrant #36 checkIn
Immigrant #27 leave
Immigrant #36 sitDown
Immigrant #19 leave
Immigrant #33 leave
Immigrant #30 leave
Immigrant #28 leave
Immigrant #23 leave
Immigrant #34 leave
Immigrant #20 leave
Immigrant #25 leave
Immigrant #29 leave
Immigrant #35 leave
Immigrant #37 enter
Immigrant #38 enter
Immigrant #37 checkIn
Immigrant #38 checkIn
Immigrant #38 sitDown
Immigrant #37 sitDown
Immigrant #39 enter
Immigrant #39 checkIn
Immigrant #39 sitDown
Immigrant #40 enter
Immigrant #40 checkIn
Immigrant #40 sitDown
Spectator #9 enter
Spectator #9 spectate
Spectator #9 leave
Judge #4 enter
Judge #4 confirm the immigrant #37
Judge #4 confirm the immigrant #40
Immigrant #40 swear
Judge #4 confirm the immigrant #36
Immigrant #36 swear
Judge #4 confirm the immigrant #38
Immigrant #40 getCertificate
Judge #4 confirm the immigrant #39
Immigrant #37 swear
Immigrant #36 getCertificate
Judge #4 leave
Immigrant #39 swear
Immigrant #39 getCertificate
Immigrant #38 swear
Immigrant #37 getCertificate
Immigrant #40 leave
Immigrant #38 getCertificate
Immigrant #36 leave
Immigrant #39 leave
Immigrant #37 leave
Immigrant #38 leave
Spectator #10 enter
Spectator #10 spectate
Spectator #10 leave
Immigrant #41 enter
Immigrant #41 checkIn
Immigrant #41 sitDown
Spectator #11 enter
Spectator #11 spectate
Spectator #11 leave
Immigrant #42 enter
Immigrant #42 checkIn
Immigrant #42 sitDown
Spectator #12 enter
Spectator #12 spectate
Immigrant #43 enter
Immigrant #43 checkIn
Immigrant #43 sitDown
```