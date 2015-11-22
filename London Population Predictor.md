London Population Predictor
========================================================
author: Paul Hodgson
date: 22nd November 2015

2/5 Why is a population predictor needed?
========================================================

This year, London's population reached 8.6m, its highest figure ever. According to predictions, it could grow by a further 2m people over the next few years.

![alt text](http://static.standard.co.uk/s3fs-public/styles/story_large/public/thumbnails/image/2013/12/23/11/street.jpg)



3/5 What does the tool do?
========================================================

To help you explore and understand the latest prediction data, we've created a tool that allows you to select your own unique combination of the following factors:

- Age group (by single year)
- Year of interest (2001 - 2040)
- London Borough of interest



4/5 Inputs
========================================================

The data has a single row for each borough/year combination and a column for the population of each age (ages 0-4 shown below).
<br>

```
  Year Borough.Name   X0   X1   X2   X3   X4
1 2001       Camden 2641 2482 2366 2383 2276
2 2002       Camden 2838 2588 2417 2302 2298
3 2003       Camden 2826 2763 2508 2355 2198
4 2004       Camden 2906 2744 2682 2458 2241
```
<br>
For years 2001-2014, these are based on counts and for future years the value is predicted based on a combination of trend based curves and known housing developments.

5/5 Outputs
========================================================
As well as instantly providing the result that you are looking for, an overview graph of all years is also shown. 
<br>
![alt text](https://raw.githubusercontent.com/Paul-Hodgson/shiny-pop/master/Screenshot.png)
