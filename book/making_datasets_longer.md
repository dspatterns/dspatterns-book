# Making Datasets Longer {#making_datasets_longer}



- emphasis should be on tidying for counting
- include advanced examples
- take a dataset that has repeated measures by individual (especially grouped measures): `anscombe`

This chapter covers

- The characteristics of tidy data
- How to reshape a data table using the `pivot_longer()` function
- Further tidying of data tables with the `na_if()` function
- Explain data organization in terms of indexed and cartesian paradigms, see: https://www.storybench.org/pivoting-data-from-columns-to-rows-and-back-in-the-tidyverse/ and https://github.com/apreshill/teachthat/tree/master/pivot and https://github.com/apreshill/teachthat/blob/master/pivot/pivot_multiples.md for animated pivot gifs.
- Use this: https://apreshill.github.io/bakeoff-tidy/

Next chapter should cover
- Doing more summarizing/table-prep with grouped data
- plot using grouped/faceted data

The last two chapters introduced us to data transformation (using **dplyr**) and data visualization (using **ggplot**). We really learned a lot, and we just dove right in with example data tables that were furnished by the **dspatterns** package. The `sw` and `dmd` datasets from Chapters 2 and 3 were tidy datasets. We didn't have to think much about the arrangement of the data within those tables, there were used as is. They just worked. Quite often, however, the datasets you'll encounter and want to use will not be tidy. This can cause problems in your analyses, so we really need to make the effort to tidy them before performing any analysis. This chapter is all about recognizing the difference between tidy and untidy data, and then, using strategies to tidy that data before getting to the analysis stage.

While the **dspatterns** package usually offers tidy datasets, there are a few untidy ones in there as well. We will use the untidy `winniweather` dataset in our examples for this chapter. The dataset contains temperature data (four times daily) for the City of Winnipeg during the month of February 2015. As ever, we get access to all of **dspatterns**'s datasets using `library(dspatterns)`. Once that statement is executed, the untidy `winniweather` table will be available. This is not a large dataset since it has merely 28 rows (one row per day of the study month) and the following six variables:

- `yearmonth`: a character string representing the year and the month; it's always `"2015-2"` in this dataset
- `day`: an integer representing the day of the month
- `temp00_00`, `temp06_00`, `temp12_00`, and `temp18_00`: hourly temperatures in degrees Celsius for the hours of 12 AM, 6 AM, 12 PM, and 6 PM

For more information on this dataset, execute `help(winniweather)` in the **RStudio** console. The help page should provide more background detail than what's provided here.

Let's first learn how to identify untidy data. It's not always plain to see but we'll try to hone this sense by learning the principles of *tidy data*, identifying characteristics that are untidy, and then looking at several examples of untidiness. After that, the focus will be on turning the very untidy `winniweather` dataset into a tidy data table. Our eventual goal will be to generate several exploratory plots of the tidied dataset. In doing so, we'll come across common pitfalls, learn how to fix those problems, and make increasingly better plots.

## What Is Tidy Data?

Tidy data is structured in a standardized way such that it is ready for analysis with tidy tools. Put another way, data values within a tidy dataset are organized in a manner expected by these data analysis tools. Having a standard solves many problems of data cleaning and analysis: we don't need to develop our own specification of what an analysis-ready dataset is, and, downstream data analysis tools can take advantage of a standard spec for tidy data and work well together.

In practice raw data is rarely tidy, and, because of that, it is much harder to work with as a result (downstream analysis tools expect tidy data). If we use techniques for tidying the data before we proceed to the analysis phase of our work, we will experience much less difficulty in that analysis. There will be no need to develop workarounds and there will be an overall lower risk of errors during data analysis.

In general, tidy data has these characteristics:

1. Each variable in the data set is placed in its own column
2. Each observation is placed in its own row
3. Each value is placed in its own cell

It's important to recognize untidy data when you get a new dataset. Detecting such untidiness will help us develop a strategy for tidying that makes the analysis of the data go that much more smoothly. Here is a list of the more common scenarios: 

1. Values of variables used for column headings
2. Summarized data occupying single rows
3. A single observation placed in multiple rows
4. Multiple pieces of data occupying a single cell
5. Rows or columns that are entirely blank

It can be difficult to both recognize when data is untidy and what the best course of action might be when untidiness is detected. The rest of this chapter will use the untidy `winniweather` dataset to point out some of the more common ways that data can be untidy. The lessons will also demonstrate some useful techniques for transforming the untidy dataset into a tidy and useful dataset. The big payoff will be the ability to plot all of the data points in the tidied version of winniweather with **ggplot** (which is not initially possible without severe complications).

## Using **tidyr** to Tidy Our Tables

The **tidyr** package, part of the *Tidyverse*, has been designed to help with the task of tidying tabular data. We only need a few functions from the package to transform an untidy data table (`winniweather`) to a tidy one.

### Identifying Untidiness and Proposing Some Solutions to Tidy Up

The `winniweather` dataset is available in the **dspatterns** package; let's look at the top of the table by printing the dataset.

`<p style="margin-bottom: 0; font-size: 14px"><strong>CODE //</strong> The <code>winniweather</code> dataset, printed to the console.</p>`{=html}

```r
winniweather
#> # A tibble: 28 x 6
#>   yearmonth   day temp00_00 temp06_00 temp12_00 temp18_00
#>   <chr>     <int>     <dbl>     <dbl>     <dbl>     <dbl>
#> 1 2015-2        1     -26.8     -29.2     -22.5     -21  
#> 2 2015-2        2     -19.7     -16.7     -13.9     -17.3
#> 3 2015-2        3     -19.4     -21.1     -14.9     -13.9
#> 4 2015-2        4     -20.2     -23.6     -21.7     -19.7
#> 5 2015-2        5     -18.8     -15.8      -7.8     -13.3
#> 6 2015-2        6     -17       -18.3     -16.9     -14.6
#> # … with 22 more rows
```

The dataset provides hourly temperatures at four times in each day, at `00:00`, `06:00`, `12:00`, and `18:00` (all 24-hour times) in the last four columns. The temperature values are in degrees Celsius. The first column, `yearmonth`, gives us the year and month (as combined string, in a `YYYY-M` format), and the second column (`day`) has the day of the month.

The `winniweather` dataset was introduced as an example of an untidy dataset. Let's look at a few of the traits that make this table untidy. The first and more obvious of these is that there are multiple observations in each line: each line has temperature readings at different times in the day (this is facilitated by encoding column names with time-of-day data). Look at the columns starting with `"temp"`, each contains time data in the column names with a *tempHH_MM* format. According to the principles of tidy data, each observation is placed in its own row. So, to make this tidier, a good strategy is to create `hour` and `temp` columns. This would result in four rows for every row currently in the dataset and this makes intuitive sense because it's really four separate temperature observations.

Another potential problem is that the `yearmonth` column is a combined value of the year and the month. It doesn't make much sense that the year and the month are combined while the day isn't combined with anything. We should split `yearmonth` into `year` and `month` columns since tidy data stipulates that each value is placed in its own cell.

### Addressing Untidyness by Using the `pivot_longer()` Function

Let's start to transform `winniweather` into a tidy dataset by first addressing the `"temp*"` columns with **tidyr**'s `pivot_longer()` function. This function takes multiple columns and collapses them into key-value pairs (making the resulting table longer, with more rows). Put another way, the column names become values in the new key column and the values in each of the targeted columns go into the value column (we can supply our own names for the new key and value columns). It's far better to show than tell in this case. The following demonstrates how we would use `pivot_longer()` to make this table more tidy.


```{=html}
<p style="margin-bottom: 0; font-size: 14px"><strong>CODE //</strong> How to make data <code>pivot_longer()</code> and thus make it more tidy.</p>
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size:11px; margin-bottom: 2px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: -0.5px; margin-bottom: 6px; text-indent: 6px; cursor: pointer; font-size: 10px; display: list-item;">Notes on the Code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>We are piping the <code>winniweather</code> dataset to the <code>pivot_longer()</code> function.<br><span style="color:steelblue;font-weight:bold;">#B </span>We start by supplying a set of columns that contain data to be put in a 'longer' format (i.e., one observation per row). The <code>starts_with()</code> function is familiar: it's also used in <strong>dplyr</strong>'s <code>select()</code> function.<br><span style="color:steelblue;font-weight:bold;">#C </span>The <code>names_to</code> argument expects a name for a new column. This new column will contain the column names from the <code>starts_with()</code> selection.<br><span style="color:steelblue;font-weight:bold;">#D </span>The <code>values_to</code> argument also expects a name (again, of your choosing) for a new column; this column will contain the values.
<br style="font-size: 14px;"/>
</details>
```


```r
winni_mod <- 
  winniweather %>%  #A
  pivot_longer(
    starts_with("temp"),  #B
    names_to = "hour",  #C
    values_to = "temp"  #D
  )

winni_mod
#> # A tibble: 112 x 4
#>   yearmonth   day hour       temp
#>   <chr>     <int> <chr>     <dbl>
#> 1 2015-2        1 temp00_00 -26.8
#> 2 2015-2        1 temp06_00 -29.2
#> 3 2015-2        1 temp12_00 -22.5
#> 4 2015-2        1 temp18_00 -21  
#> 5 2015-2        2 temp00_00 -19.7
#> 6 2015-2        2 temp06_00 -16.7
#> # … with 106 more rows
```

The printing of the new `winni_mod` tibble in the console shows the transformation of multiple temperature columns to a single a temp column.

We supplied a key of `"hour"` and a value of `"temp"` and targeted the columns that start with `"temp"` (using the select helper function `starts_with()`, for convenience). What we get in the output table (stored as the variable `winni_mod`) is a longer table of (112 rows) compared to 28 rows in the original table. This is four times the row count of the original since the four separate observations per row in `winniweather` are now given separate rows (as we need one row per observation for tidiness).

Although this is a great start, there is still some work to do to make the resulting table more useful. We can see that the `hour` column in its current state is not ideal as it contains a string with the hour embedded within it. It's better to make that a number representing the hour of day. Let's do that now with a combination of **dplyr**'s `mutate()` function paired with `case_when()`.


```{=html}
<p style="margin-bottom: 0; font-size: 14px"><strong>CODE //</strong> Modifying values in the hour column with <code>mutate()</code>.</p>
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size:11px; margin-bottom: 2px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: -0.5px; margin-bottom: 6px; text-indent: 6px; cursor: pointer; font-size: 10px; display: list-item;">Notes on the Code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>We are piping the <code>winni_mod</code> object to <strong>dplyr</strong>'s <code>mutate()</code> function.<br><span style="color:steelblue;font-weight:bold;">#B </span>The <code>hour</code> column already exists. We are essentially modifying values within the <code>hour</code> column on a case-by-case basis with the <code>case_when()</code> function.<br><span style="color:steelblue;font-weight:bold;">#C </span>Each line represents a different possible case (<code>hour</code> being equal to a specific string) and a replacement value (the integer-based hour of day in 24-hour time).
<br style="font-size: 14px;"/>
</details>
```


```r
winni_mod <- 
  winni_mod %>%  #A
  mutate(hour = case_when(  #B
    hour == "temp00_00" ~ 0L,  #C
    hour == "temp06_00" ~ 6L,  #C
    hour == "temp12_00" ~ 12L,  #C
    hour == "temp18_00" ~ 18L  #C
  ))

winni_mod
#> # A tibble: 112 x 4
#>   yearmonth   day  hour  temp
#>   <chr>     <int> <int> <dbl>
#> 1 2015-2        1     0 -26.8
#> 2 2015-2        1     6 -29.2
#> 3 2015-2        1    12 -22.5
#> 4 2015-2        1    18 -21  
#> 5 2015-2        2     0 -19.7
#> 6 2015-2        2     6 -16.7
#> # … with 106 more rows
```

We now find that `winni_mod` has an `hour` column with integer-based values (instead of text labels).

Remember that `mutate()` modifies existing columns (or creates new ones) by providing it with a column name (here, `hour`) and an expression. The `case_when()` function and the resulting expression we have here is useful when you want to supply different logic on a case-by-case basis. The different cases are `hour` being equivalent to each of the four different `temp*` values. To the right of each `~` symbol are the expressions for each case. The expressions are very simple in every case: use the integer values of `0`, `6`, `12`, or `18` (the trailing `L` tells **R** to store these values as integers).

### Using the `separate()` Function to Split a Column into Several

We can now separate `yearmonth` into `year` and `month` columns. We'll make these integer columns just like hour. The **tidyr** function to use here is `separate()` and it contains all the features we need to split a column of data into multiple columns.

Using the `separate()` function effectively only requires a little planning, which will be outlined here. To start, we know which column we want to separate (`yearmonth`) and we also have names for the new columns (`year` and `month`). These names will be used within the col and into arguments of `separate()`. Secondly, we know that the `yearmonth` column in this dataset contains the `2015-2` value repeated in all rows (i.e., there is a single unique value). We ultimately want the `2015` part in a new `year` column and the `2` part in a new `month` column. That the hyphen separates the values we want in our new columns is ideal for our use of `separate()`: we can use `sep = "-"` and the function will understand that values before and after that character will comprise the new columns. Lastly, we are taking a character column as input (`yearmonth`) and we'd like integer-based values in the new `year` and `month` columns. We can ask `separate()` to do this conversion for us with the `convert = TRUE` option. Let's see how this comes together in the code and table output:


```{=html}
<p style="margin-bottom: 0; font-size: 14px"><strong>CODE //</strong> Separating the <code>yearmonth</code> column into <code>year</code> and <code>month</code> columns.</p>
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size:11px; margin-bottom: 2px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: -0.5px; margin-bottom: 6px; text-indent: 6px; cursor: pointer; font-size: 10px; display: list-item;">Notes on the Code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>The <code>winni_mod</code> object is piped into the <code>separate()</code> function, the result of that is stored as <code>winni_tidy</code>.<br><span style="color:steelblue;font-weight:bold;">#B </span>For the <code>col</code> argument, we should provide the column name that contains the string to separate into multiple columns (<code>yearmonth</code>). The column name shouldn't be in quotes because the column exists.<br><span style="color:steelblue;font-weight:bold;">#C </span>The <code>into</code> argument lets us define column names for the split string. Since we are separating a string into two parts, we will provide two column names (in <code>c()</code>): <code>year</code> and <code>month</code>. These new names need to be in quotes because they don't yet exist.<br><span style="color:steelblue;font-weight:bold;">#D </span>With <code>sep</code>, we provide an instruction on how to separate the strings in <code>col</code>. In this case, we are splitting on a hyphen (<code>-</code>): everything left of it will be put into the <code>year</code> column, everything to the right of the hyphen is placed in the <code>month</code> column.<br><span style="color:steelblue;font-weight:bold;">#E </span>Using <code>convert = TRUE</code> will convert the new columns (<code>year</code> and <code>month</code>) to integer-type columns in this case.
<br style="font-size: 14px;"/>
</details>
```


```r
winni_tidy <-  #A
  winni_mod %>%                
  separate(
    col = yearmonth,  #B
    into = c("year", "month"),  #C
    sep = "-",  #D
    convert = TRUE  #E
  )

winni_tidy
#> # A tibble: 112 x 5
#>    year month   day  hour  temp
#>   <int> <int> <int> <int> <dbl>
#> 1  2015     2     1     0 -26.8
#> 2  2015     2     1     6 -29.2
#> 3  2015     2     1    12 -22.5
#> 4  2015     2     1    18 -21  
#> 5  2015     2     2     0 -19.7
#> 6  2015     2     2     6 -16.7
#> # … with 106 more rows
```

We see from the table printed in the console that the `yearmonth` column has been replaced by the `year` and `month` columns.

This table is now tidy! As a last thing to do we could arrange the rows to be in the order of the observation times. This is the perfect case for using the `arrange()` function.


```{=html}
<p style="margin-bottom: 0; font-size: 14px"><strong>CODE //</strong> Using <code>arrange()</code> to put the observations in the correct order.</p>
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size:11px; margin-bottom: 2px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: -0.5px; margin-bottom: 6px; text-indent: 6px; cursor: pointer; font-size: 10px; display: list-item;">Notes on the Code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>The <code>arrange()</code> function from the <strong>dplyr</strong> package takes unquoted column names (or expressions with <code>desc()</code>, not shown here but demonstrated in Chapter 2). The order is important. We are sorting first by <code>year</code>, then <code>month</code>, then <code>day</code>, and finally by <code>hour</code>.
<br style="font-size: 14px;"/>
</details>
```


```r
winni_tidy <- 
  winni_tidy %>%
  arrange(year, month, day, hour)  #A

winni_tidy
#> # A tibble: 112 x 5
#>    year month   day  hour  temp
#>   <int> <int> <int> <int> <dbl>
#> 1  2015     2     1     0 -26.8
#> 2  2015     2     1     6 -29.2
#> 3  2015     2     1    12 -22.5
#> 4  2015     2     1    18 -21  
#> 5  2015     2     2     0 -19.7
#> 6  2015     2     2     6 -16.7
#> # … with 106 more rows
```

The output is now arranged, and the printed tibble above allows us to verify this.

Recall that the columns given to `arrange()` have a sorting priority. Here we are sorting in order of the largest time parts to the smallest (`year`, `month`, `day`, `hour`). Furthermore, the arrangement is in ascending order, where the time of each observation is increasing as we move down the table.

### Inspecting Our Tidied Data by Plotting with **ggplot**

We now have a single observation per row and, as far as we can tell, all observations are accounted for. There is immense value in having our data in a tidy format. For one thing, it's easier now to plot the data as time-series plot using **ggplot**. We do have to make one more alteration though (and this is only a small change). We should create a date-time column so that each point in time is represented by a single variable. We can do that with **dplyr**'s `mutate()` function and the base function `ISOdate()`. With those functions, the new `iso_date` column can be created by supplying all of the time-component columns to `ISOdate()`.

`<p style="margin-bottom: 0; font-size: 14px"><strong>CODE //</strong> A date-time column is necessary for <strong>ggplot</strong>-based time-series plots.</p>`{=html}

```r
winni_tidy <- 
  winni_tidy %>%
  mutate(iso_date = ISOdate(year, month, day, hour))

winni_tidy
#> # A tibble: 112 x 6
#>    year month   day  hour  temp iso_date           
#>   <int> <int> <int> <int> <dbl> <dttm>             
#> 1  2015     2     1     0 -26.8 2015-02-01 00:00:00
#> 2  2015     2     1     6 -29.2 2015-02-01 06:00:00
#> 3  2015     2     1    12 -22.5 2015-02-01 12:00:00
#> 4  2015     2     1    18 -21   2015-02-01 18:00:00
#> 5  2015     2     2     0 -19.7 2015-02-02 00:00:00
#> 6  2015     2     2     6 -16.7 2015-02-02 06:00:00
#> # … with 106 more rows
```

The `winni_tidy` table now indeed contains a new column called `iso_date`. The `iso_date` column appears to have a type with the `<dttm>` (date-time) abbreviation in the tibble print out. The object type of `iso_date` is not `character` or `numeric` but instead `POSIXct`. It's a convenient way to store accurate date-time values in a single column of a table.

About `POSIXct`: Under the hood, the `POSIXct` data type contains the number of seconds since the start of January 1, 1970. Positive numbers represent the number of seconds after this time, and negative numbers represent the number of seconds beforehand. Try using the `Sys.time()` function (which gives you a `POSIXct` object with the current date-time) with `as.numeric()` in the **R** console like this: `Sys.time() %>% as.numeric()`. You'll get the number of seconds after `1970-01-01 00:00:00`. 

Now that we have the time data represented in a single column, a basic scatterplot in **ggplot** requires only two statements: the `ggplot()` call followed by defining a layer of points with the `geom_point()` function.


```{=html}
<p style="margin-bottom: 0; font-size: 14px"><strong>CODE //</strong> A scatterplot of all observations in <code>winni_tidy</code> using <strong>ggplot</strong>.</p>
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size:11px; margin-bottom: 2px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: -0.5px; margin-bottom: 6px; text-indent: 6px; cursor: pointer; font-size: 10px; display: list-item;">Notes on the Code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>The <code>ggplot()</code> function call begins the plotting process, where we provide the tidied <code>winni_tidy</code> table as the plot data.<br><span style="color:steelblue;font-weight:bold;">#B </span>We use the <code>geom_point()</code> <em>geom</em> to indicate that we want a scatterplot. We are giving this function the minimally required aesthetics of <code>x</code> and <code>y</code> (the <code>iso_date</code> and <code>temp</code> columns in <code>winni_tidy</code>).
<br style="font-size: 14px;"/>
</details>
```


```r
ggplot(data = winni_tidy) +  #A
  geom_point(aes(x = iso_date, y = temp))  #B
```

<div class="figure" style="text-align: center">
<img src="making_datasets_longer_files/figure-html/winni-tidy-ggplot-1-1.png" alt="(ref:winni-tidy-ggplot-1)" width="70%" />
<p class="caption">(\#fig:winni-tidy-ggplot-1)(ref:winni-tidy-ggplot-1)</p>
</div>
(ref:winni-tidy-ggplot-1) The scatterplot with all temperature data reveals a spurious data point.

The plot we obtain from this code might surprise us since there is a temperature value with an extremely high value (`9999`). Plots like these are easy to create and are very useful for finding anomalous values hiding in the dataset. In this case, we see a single spurious value. There is a logical explanation for why we have a very high temperature value in this dataset: it is actually missing value. In datasets you may obtain from different sources, the encoding of missing values can take various forms. Sometimes, the field is blank, there may be text (e.g., `"N/A"`, `"missing"`, `"-"`, etc.), or, in this case, it may be a value of the same type (`numeric`) but set to a physically improbable value (9999 degrees Celsius!). Once we know how missing values are encoded for any particular dataset, we can take action to re-encode as proper `NA` values. In this way, our tidy tools, such as **ggplot**, can better handle the data.

### Replacing Missing Values with Actual `NA`s

The `winni_tidy` table that we worked hard to make tidy requires yet another change in the name of tidiness. The `9999` value, which is a missing value according to the data creator, needs to be transformed to an `NA` value. The **tidyr** package has a useful function for this, and it works nicely in conjunction with **dplyr**'s mutate: the `na_if()` function. We can use the same construction as with `mutate()`/`case_when()` to modify the temp column, replacing that `9999` value with an `NA` value.


```{=html}
<p style="margin-bottom: 0; font-size: 14px"><strong>CODE //</strong> Replacement of missing values with the <code>mutate()</code> and <code>na_if()</code> functions.</p>
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size:11px; margin-bottom: 2px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: -0.5px; margin-bottom: 6px; text-indent: 6px; cursor: pointer; font-size: 10px; display: list-item;">Notes on the Code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>The <code>na_if()</code> function is used inside of <code>mutate()</code> to modify the <code>temp</code> column. Inside <code>na_if()</code> we first supply the column name to modify, then, we supply the value that is considered to be an <code>NA</code> value.
<br style="font-size: 14px;"/>
</details>
```


```r
winni_tidy <-  
  winni_tidy %>%
  mutate(temp = na_if(temp, 9999))  #A
```

The code that mutates the `winni_tidy` table writes over the previous version of `winni_tidy.` How do we verify that the change has been successful? After all, using `winni_tidy` by itself only shows us the first few rows of the table. We need a better way to inspect the modified table, so that we can sanity check our work.

A reasonable method involves both **dplyr**'s `select()` function and the base **R** function `summary()`. The idea is to reduce the table to the column of interest first, and then get summary statistics for the single column (so as to not clutter up the console with summary output for many columns). We won't overwrite the `winni_tidy` object with a reassignment here, we just want to inspect the table non-destructively.


```{=html}
<p style="margin-bottom: 0; font-size: 14px"><strong>CODE //</strong> Inspecting the data in a column (<code>temp</code>) to verify that the mutation had occurred.</p>
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size:11px; margin-bottom: 2px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: -0.5px; margin-bottom: 6px; text-indent: 6px; cursor: pointer; font-size: 10px; display: list-item;">Notes on the Code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>No reassignment back to <code>winni_tidy</code> here like in previous code listings, we just want to inspect the data.<br><span style="color:steelblue;font-weight:bold;">#B </span>We are selecting the <code>temp</code> column to focus only on that column's summary statistics.<br><span style="color:steelblue;font-weight:bold;">#C </span>The <code>summary()</code> function is very useful for getting simple summary statistics and validating one's assumptions of the data.
<br style="font-size: 14px;"/>
</details>
```


```r
winni_tidy %>%  #A
  select(temp) %>%  #B
  summary()  #C
#>       temp       
#>  Min.   :-32.30  
#>  1st Qu.:-22.40  
#>  Median :-18.50  
#>  Mean   :-18.61  
#>  3rd Qu.:-14.60  
#>  Max.   : -3.30  
#>  NA's   :1
```

The output shows that the maximum value for `temp` is now `-3.30` and not `9999`, which is a huge improvement! Also, we now have a single `NA` value in the `temp` column (this was our doing).

On this road to tidiness, we have accomplished quite a lot. This is very much how it goes with real data, it's often a touch-and-go process of tidying, inspecting, tidying, inspecting, and so on.

Let's now plot this data again. The next bit of plotting code isn't different than the previous plotting code, but it's here again for sake of convenience.


```{=html}
<p style="margin-bottom: 0; font-size: 14px"><strong>CODE //</strong> Another attempt at a scatterplot of all the observations in <code>winni_tidy</code> (the even tidier version).</p>
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size:11px; margin-bottom: 2px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: -0.5px; margin-bottom: 6px; text-indent: 6px; cursor: pointer; font-size: 10px; display: list-item;">Notes on the Code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>This <strong>ggplot</strong> code is unchanged from before, which just goes to show that <strong>ggplot</strong> code can be highly reusable.
<br style="font-size: 14px;"/>
</details>
```


```r
ggplot(data = winni_tidy) +  #A
  geom_point(aes(x = iso_date, y = temp))
#> Warning: Removed 1 rows containing missing values (geom_point).
```

<div class="figure" style="text-align: center">
<img src="making_datasets_longer_files/figure-html/winni-tidy-ggplot-2-1.png" alt="(ref:winni-tidy-ggplot-2)" width="70%" />
<p class="caption">(\#fig:winni-tidy-ggplot-2)(ref:winni-tidy-ggplot-2)</p>
</div>
(ref:winni-tidy-ggplot-2) The scatterplot with all temperature data after dealing with the spurious data point.

This plot is much changed from the previous one. This plot is now usable, since the temperature value of `9999` has now been classified as an `NA` value (and `NA` values aren't plotted, of course). Let's make things interesting and facet the plot by the hour of day. We have that flexibility now since there is an `hour` column. We do this in **ggplot** with the `facet_wrap()` function, and the result is a plot with four facets (*Figure \@ref(fig:winni-tidy-ggplot-3)*).


```{=html}
<p style="margin-bottom: 0; font-size: 14px"><strong>CODE //</strong> Faceting the temperatures in winni_tidy by the time of day.</p>
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size:11px; margin-bottom: 2px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: -0.5px; margin-bottom: 6px; text-indent: 6px; cursor: pointer; font-size: 10px; display: list-item;">Notes on the Code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>We are using <code>facet_wrap()</code> to make a set of plots faceted by the four different hours that temperatures are available each day in this dataset. The <code>labeler = label_both</code> statement always provides useful information and is a nice touch.
<br style="font-size: 14px;"/>
</details>
```


```r
ggplot(data = winni_tidy) +
  geom_point(aes(x = iso_date, y = temp)) +
  facet_wrap(vars(hour), labeller = label_both)  #A
#> Warning: Removed 1 rows containing missing values (geom_point).
```

<div class="figure" style="text-align: center">
<img src="making_datasets_longer_files/figure-html/winni-tidy-ggplot-3-1.png" alt="(ref:winni-tidy-ggplot-3)" width="70%" />
<p class="caption">(\#fig:winni-tidy-ggplot-3)(ref:winni-tidy-ggplot-3)</p>
</div>
(ref:winni-tidy-ggplot-3) A scatterplot with facets. Now possible with our tidy data.

The plot of *Figure \@ref(fig:winni-tidy-ggplot-3)* couldn't be generated without our tidying transformations. Actually, none of these plots could be made with the same number of data points we have here. The data were effectively divided across four columns, and, we didn't have a date-time column. But now, we have the freedom to further transform the tidy data (e.g., filtering the data, converting temperature values to degrees Fahrenheit, etc.) and plot again with ease.

## Summary

- We learned the rules of tidy data and, conversely, we can identify which ways a dataset is untidy (important for strategizing on methods to tidy the dataset)
- By using the `pivot_longer()`, `separate()`, and `na_if()` functions from the **tidyr** package, we were able to tidy an otherwise untidy dataset
- Various strategies can be used to verify that tidied datasets have been transformed correctly: through plotting via **ggplot**, printing and inspecting the tibble, etc.

## Exercises

1. We used the `separate()` function to split values in one column to two columns. When doing so, why was `yearmonth` column not in quotation marks whereas the `year` and `month` columns were?

2. Previously, we used the `arrange()` function to put the observations in the correct order (observations of temperature by ascending time). If we didn't do this beforehand, what would be resulting plots look like?

3. The `ISOdate()` function was used to create a POSIXct date-time column. There is also an `ISOdatetime()` function. Take a look at the help file (`?ISOdate` has an article with both functions) and state why using `ISOdate()` was the better choice.

4. Entirely empty columns (`NA`s all the way down) are not entirely uncommon in a dataset. Sometimes we can safely discard such columns. How would you do this if `winni_tidy` had an empty column called `empty`? Provide a statement.

5. Sometimes, we'll get data tables that have entirely empty rows (`NA`s in every field). We typically want to discard those rows. Consult the **tidyr** documentation and find out which function helps us do this. How would you use that function to remove an entirely empty row from `winni_tidy`?

6. Recall that we replaced the 'missing' (`9999`) value with the combination of the `mutate()` and `na_if()` functions. After that, the table was inspected with `summary()` to see that the change was made. Can you think of another way to check that the `9999` value in `temp` was recoded with an `NA` value?

## Possible Answers

1. The reason that `yearmonth` was not in quotation marks is because the column (at the time of the function call) existed in the data table. Columns that exist are, by convention, not put in quotes. The `year` and `month` columns at the time of the function call did not exist (they were yet to be made), that's why they are in quotes.

2. The plots would look no different without the `arrange()` transformation. Then, why did we do it? It was a good review of the `arrange()` function.

3. The `ISOdate()` function has defaults for the time parts (`hour = 12`, `min = 0`, `sec = 0`) and for the time zone (`tz = "GMT"`) whereas `ISOdatetime()` has no such default values. As our data did not have minute or second time components, we would have to specify our own values for those.

4. The easiest way to do this is to use **dplyr**'s `select()` function: `winni_tidy %>% select(-empty)`.

5. The `drop_na()` function from **tidyr** allows us to remove entirely or partially empty rows. One or more entirely empty rows in `winni_tidy` can be removed with `winni_tidy %>% drop_na()`.

6. One possible, alternate method is to use **dplyr**'s `filter()` function to check for both an `NA` and for a `9999` value in the temp column: `winni_tidy %>% filter(is.na(temp) | temp == 9999)`. Success looks like a single row with an `NA` in the temp column.
