# Careful Counting Patterns {#careful_counting_patterns}




<style type="text/css">
.ggtab {
  display: flex;
  flex-wrap: wrap;
  outline: #B6B4FA solid 1px;
  padding: 5px;
  margin-bottom: 20px;
}

.ggtab label {
  order: 1; 
  display: block;
  padding: 1rem 2rem;
  cursor: pointer;
  background: white;
  font-weight: bold;
  transition: background ease 0.2s;
}

.ggtab [class^="tab"] {
  order: 99; 
  flex-grow: 1;
  width: 100%;
  display: none;
  padding: 1rem;
  background: white;
}

.ggtab input[type="radio"] {
  display: none;
}

.ggtab input[type="radio"]:checked + label {
  background: #E3E3FD;
}

.ggtab input[type="radio"]:checked + label + [class^="tab"] {
  display: block;
}
</style>

## Introduction

Notes: 

- Use the bakeoff dataset (diamonds has been seen before)
- This chapter really ought to be an intro vis / data inspection/exploration section with multiple packages
- introduce functions:
  - dplyr::glimpse()
  - dplyr::distinct() (getting unique rows by selection of columns)
  - dplyr::count() (counting distinct values by rows; count by series, use built-in sort feature)
  - geom_boxplot()
- use some code from course material that uses bakeoff
  - links: https://alison.netlify.app/rls-plot-twist/#19, https://alison.netlify.app/rls-plot-twist/#19 (counting slides)
- start off with histogram and create this plot: https://alison.netlify.app/rls-plot-twist/#19
- histogram of ages of bakers + other interesting plots
- goals: making exploratory bar charts and histograms (useful for initial understanding of the data)

## Patterns

Explore: exploring a brand new dataset with dplyr and ggplot

Understand: from exploratory plots (confirms or disproves your assumptions about the data) gain an intuition and develop that ability

Explain:

Collaborate:

Communicate:

## Project Ideas

(should have a fully working set of Rmd templates, presented in the form of a project template - this can be prepped for the reader with a function call)

The moma dataset (https://apreshill.github.io/data-vis-labs-2018/02-moma.html) would be great for a project
- explore using the lisa palette from paletteer


## This chapter covers

- What the **ggplot** **R** package is and how it can be used to create plots from tabular data
- Creating a scatterplot from a dataset, using different aesthetic choices (e.g., shapes, color, and more)
- Using faceted plots: multiple subplots that facilitate comparisons across groups of data
- Customizing text in key plot elements
- Modifying the placement of automatically generated legends
- Alternating between transforming data with **dplyr** and visualizing data with **ggplot**

Data visualization is a useful process for generating insights. It is often necessary to transform data before it's ready for plotting, and, the **dplyr** functions we just learned about make those transformations possible. Now, we will learn about how to create beautiful and informative plots with **ggplot** (actually called **ggplot2** but cited throughout this book more simply as **ggplot**). While **ggplot** provides functionality to create a wide selection of plot types, we will begin by focusing on a single type of plot: the scatterplot.

This book's package, **dspatterns**, provides the input data we'll need to build our example plots. From that package the `dmd` dataset will be used (it's a simplified version of the `diamonds` dataset that is available in the **ggplot** package). Whenever we load in the **dspatterns** package using `library(dspatterns)`, the dmd table will be available; you can verify this by executing `dmd` in the **R** console. This particular dataset has nearly 2,700 rows, one for each diamond and its attributes, and the following 6 variables:

- `carats`: the weight of the diamond in carats, where each carat is 0.2 grams
- `depth`: a depth percentage of the diamond that takes into account the diamond's length, width, and depth distances
- `color`, `cut`, and `clarity`: provides qualitative measures of the diamond's color, cut, and clarity; the common measures are `"Fair"`, `"Great"`, and `"The Best"`
- `price`: the price of the diamond in US Dollars

For more information on this dataset, execute `?dmd` in the **RStudio** console. A help page will appear.

Near the end of this chapter we will circle back to **dplyr** and learn how to modify our input data to make revisions to plots with **ggplot**. The lesson to be learned here is that data transformation and data visualization are common, intertwined tasks in a typical data analysis workflow. Because of that, we'll delve into how to effectively alternate between these activities during an exploratory data analysis.

## Using **ggplot** to Create Plots

Through a number of simple examples with the `dmd` dataset, we'll develop an understanding of how to use **ggplot** to create very simple plots. The output plots will be presented above the code required to create each, and notes will be provided with each code listing.

### Making Simple **ggplot** Scatterplots

Let's describe a simple scatterplot with the `dmd` variables `carats` (the weight of the diamond) and `price` (the price in US dollars). The very first instruction we'll provide is a `ggplot()` function call. This requires data (we'll use the `dmd` table as data), and, it also has an argument called mapping. We'll map `carats` to the *x* axis and `price` to the *y* axis, and this will be wrapped up inside the `aes()` object (`aes` stands for aesthetics). This last part implies that the axes to which data values are bound are aesthetic properties, and that's really how the *Grammar of Graphics* sees it (along with other aesthetic properties like the shape and color of marks). After running the code chunk, we'll get the plot shown as *Figure \@ref(fig:gg-empty-p)*.

<span id="fig:gg-empty-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Making our first <strong>ggplot</strong>.</p>`{=html}
<div class="ggtab">
<input type="radio" name="gg-empty-tab" id="gg-empty-c" checked="checked">
<label for="gg-empty-c">Code</label>
<div class="tab">

```r
ggplot(data = dmd, mapping = aes(x = carats, y = price))  #A
```
</div>
<input type="radio" name="gg-empty-tab" id="gg-empty-p">
<label for="gg-empty-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/gg-empty-p-1.png" alt="(ref:gg-empty-p)" width="70%" />
<p class="caption">(\#fig:gg-empty-p)(ref:gg-empty-p)</p>
</div>
(ref:gg-empty-p) Our first **ggplot** plot is... empty.
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>This <strong>ggplot</strong> statement adds data and defines the <code>x</code> and <code>y</code> aesthetics. However, there is no layer that actually visualizes the data.
<br style="font-size: 14px;"/>
</details>
```


We might be surprised that what we see in *Figure \@ref(fig:gg-empty-p)* is essentially an empty plot. What we do have however are the plot axes (with values and labels), and you might notice that the ranges of the axis values encompass the extent of data (it's hard to know without seeing the data but this is indeed the case). To actually get the `price` vs. `carats` data points onto the plot, we have to add a *geom*—this stands for geometry—and, in this case, we will use `geom_point()`. This *geom* provides a method for plotting the data. Let's take a look at the new code and the resulting plot (*Figure \@ref(fig:dmd-carats-price-p)*).

<span id="fig:dmd-carats-price-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Using <code>geom_point()</code> adds a layer of points.</p>`{=html}
<div class="ggtab">
<input type="radio" name="dmd-carats-price-tab" id="dmd-carats-price-c" checked="checked">
<label for="dmd-carats-price-c">Code</label>
<div class="tab">

```r
ggplot(data = dmd, mapping = aes(x = carats, y = price)) +  #A
  geom_point()  #B
```
</div>
<input type="radio" name="dmd-carats-price-tab" id="dmd-carats-price-p">
<label for="dmd-carats-price-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/dmd-carats-price-p-1.png" alt="(ref:dmd-carats-price-p)" width="70%" />
<p class="caption">(\#fig:dmd-carats-price-p)(ref:dmd-carats-price-p)</p>
</div>
(ref:dmd-carats-price-p) Our first **ggplot** plot... with data!
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>Same line as in the previous code; need to add a linking `` sign.<br><span style="color:steelblue;font-weight:bold;">#B </span>The <code>geom_point()</code> function makes all the difference here. It creates a layer of data points.
<br style="font-size: 14px;"/>
</details>
```


The plot indeed now has data points thanks to the use of `geom_point()`! There are a lot of *geom* functions in **ggplot** and all have the form `geom_...()` (e.g., `geom_bar()`, `geom_boxplot()`, `geom_text()`, etc.). Each *geom* essentially adds a layer to the plot. 

.callout
Note: In the plotting code for *Figures \@ref(fig:gg-empty-p) and \@ref(fig:dmd-carats-price-p)*, notice that the two statements are joined by a `+`. This is different than the pipe operator (`%>%`) that was used to join together, or pipe, the **dplyr** statements in the last lesson. This is sometimes a point of confusion so always try to remember that **ggplot** exclusively uses `+` whereas every other package of the *Tidyverse* (and beyond) uses `%>%`.
.callout

Let's unpack what's happening in the previous code listing just a bit more. The first line with `ggplot()` allows you to set default values that are passed down to later statements. So, `geom_point()` is receiving the data of `dmd` and also the aesthetics defined in the `aes()` object. We'll see in later examples that any values provided after the `ggplot()` statement will take precedence over the defaults (to convince ourselves fully, we'll need to go through those examples).

In looking at the relationship between diamond price (`price`) against the weight in carats (`carats`) in the above, it's easy to see a positive correlation between the two variables. When doing data exploration, we may also want to compare other pairs of variables to see what our data tells us. Since these types of plots only take two lines of code to generate, we can and should try to do enough exploration so that we get a better intuition on the data. So, let's try this again, but this time we'll use the numerical `depth` variable (a geometric measure of the diamond) in place of `carats`, giving us the plot in *Figure \@ref(fig:dmd-carats-depth-p)*.

<span id="fig:dmd-carats-depth-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Using a different <em>y</em> value.</p>`{=html}
<div class="ggtab">
<input type="radio" name="dmd-carats-depth-tab" id="dmd-carats-depth-c" checked="checked">
<label for="dmd-carats-depth-c">Code</label>
<div class="tab">

```r
ggplot(data = dmd, mapping = aes(x = carats, y = depth)) +  #A
  geom_point()
```
</div>
<input type="radio" name="dmd-carats-depth-tab" id="dmd-carats-depth-p">
<label for="dmd-carats-depth-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/dmd-carats-depth-p-1.png" alt="(ref:dmd-carats-depth-p)" width="70%" />
<p class="caption">(\#fig:dmd-carats-depth-p)(ref:dmd-carats-depth-p)</p>
</div>
(ref:dmd-carats-depth-p) Experimenting with different variables for `x` and `y` results in a different plot. It's not very informative but that's okay, we are learning.
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>This time, <code>y</code> is set to the <code>depth</code> variable.
<br style="font-size: 14px;"/>
</details>
```


While the variables in *Figure \@ref(fig:dmd-carats-depth-p)* do not show any correlation to each other, we can see that the `depth` measure is generally in the range of `55` to `70`. This plot may not be of much importance, but the process of exploration will provide us with different viewpoints on our data. This feeling of discovery as we make many exploratory plots can be rewarding, and the speed at which we could make the plots incites more exploration into the data.

One of the great things about **ggplot** is that we have a quite a few aesthetic properties we could map to variables. Let's return to the price vs. carats comparison and map a shape aesthetic to a different variable in `dmd`: `clarity`. The `clarity` variable is discrete (or categorical), providing a one of three character-based values that qualitatively state how clear the diamond is *Figure \@ref(fig:dmd-shape-for-clarity-p)*.

<span id="fig:dmd-shape-for-clarity-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Using the <code>shape</code> aesthetic.</p>`{=html}
<div class="ggtab">
<input type="radio" name="dmd-shape-for-clarity-tab" id="dmd-shape-for-clarity-c" checked="checked">
<label for="dmd-shape-for-clarity-c">Code</label>
<div class="tab">

```r
ggplot(
  dmd,
  mapping = aes(x = carats, y = price, shape = clarity)  #A
) +
  geom_point()
```
</div>
<input type="radio" name="dmd-shape-for-clarity-tab" id="dmd-shape-for-clarity-p">
<label for="dmd-shape-for-clarity-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/dmd-shape-for-clarity-p-1.png" alt="(ref:dmd-shape-for-clarity-p)" width="70%" />
<p class="caption">(\#fig:dmd-shape-for-clarity-p)(ref:dmd-shape-for-clarity-p)</p>
</div>
(ref:dmd-shape-for-clarity-p) Mapping an aesthetic other than `x` and `y` can show us how groupings of data interrelate.
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>We add the <code>shape</code> aesthetic, mapping it to the <code>clarity</code> variable.
<br style="font-size: 14px;"/>
</details>
```


Because we defined an additional aesthetic property by putting `shape = clarity` inside the `aes()` function, **ggplot**: (1) automatically maps data-point shapes to the different discrete values in the `clarity` column, (2) applies those shapes to each of the data points, and (3) draws a legend to describe the shape mappings for `clarity`. Here, we can see that the data points belonging to `"The Best"` `clarity` (square shape) generally yield the highest prices at a given weight compared to the other two descriptors (notice that the points labeled as `"Fair"` are further to the right).

We have plenty of options for modifying this plot. The large number of data points in the plot shows a fairly high degree of overplotting, and so it's harder to see where the data points are most concentrated. A common way to solve this visualization problem is to add transparency to the data points. We do this in **ggplot** by setting the alpha value in `geom_point()` to a relatively low value in the `0` to `1` scale. In our new code we will use `alpha = 0.25` but if overplotting is more severe, lower values will often yield better results (*Figure \@ref(fig:dmd-carats-price-alpha-p)*).

<span id="fig:dmd-carats-price-alpha-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Using the alpha argument in <code>geom_point()</code>.</p>`{=html}
<div class="ggtab">
<input type="radio" name="dmd-carats-price-alpha-tab" id="dmd-carats-price-alpha-c" checked="checked">
<label for="dmd-carats-price-alpha-c">Code</label>
<div class="tab">

```r
ggplot(dmd, mapping = aes(x = carats, y = price, shape = clarity)) +
  geom_point(alpha = 0.25)  #A
```
</div>
<input type="radio" name="dmd-carats-price-alpha-tab" id="dmd-carats-price-alpha-p">
<label for="dmd-carats-price-alpha-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/dmd-carats-price-alpha-p-1.png" alt="(ref:dmd-carats-price-alpha-p)" width="70%" />
<p class="caption">(\#fig:dmd-carats-price-alpha-p)(ref:dmd-carats-price-alpha-p)</p>
</div>
(ref:dmd-carats-price-alpha-p) The use of transparency (or, `alpha`) can alleviate the problems associated with a high degree of overplotting.
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>Supplying an <code>alpha</code> value of <code>0.25</code> (in the range of <code>0</code>–<code>1</code>) makes the points relatively transparent.
<br style="font-size: 14px;"/>
</details>
```


What if we simply wanted all the points to be of a specified color instead of the default opaque black? In this case, if we wanted to use `gray50` as a color (it's a medium gray), we would need to add `color = "gray50"` inside of `geom_point()` and we also need to remove the `color` aesthetic (`color = clarity`) in the initial mapping. This results in uniformly gray data points in the output plot (*Figure \@ref(fig:dmd-all-gray50-points-p)*).

<span id="fig:dmd-all-gray50-points-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Setting a fixed color inside of <code>geom_point()</code>.</p>`{=html}
<div class="ggtab">
<input type="radio" name="dmd-all-gray50-points-tab" id="dmd-all-gray50-points-c" checked="checked">
<label for="dmd-all-gray50-points-c">Code</label>
<div class="tab">

```r
ggplot(dmd, mapping = aes(x = carats, y = price)) +
  geom_point(color = "gray50")  #A
```
</div>
<input type="radio" name="dmd-all-gray50-points-tab" id="dmd-all-gray50-points-p">
<label for="dmd-all-gray50-points-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/dmd-all-gray50-points-p-1.png" alt="(ref:dmd-all-gray50-points-p)" width="70%" />
<p class="caption">(\#fig:dmd-all-gray50-points-p)(ref:dmd-all-gray50-points-p)</p>
</div>
(ref:dmd-all-gray50-points-p) Setting all points to a specific color is possible and sometimes desirable.
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>The <code>&quot;gray50&quot;</code> color is halfway between white and black; and, the higher the number, the lighter the gray.
<br style="font-size: 14px;"/>
</details>
```


The point *geom* can be used with quite a few aesthetics, these are:

- `x` and `y` — positions on the *x* and *y* axes (these are absolutely required for the positioning of dots)
- `color` — the color value for the border of the mark
- `fill` — the color that fills the inside of a mark
- `alpha` — the transparency of the colors of a mark
- `shape` — the shape of the mark
- `size` — the size of the mark

The only way to get a feel for what's available in terms of the visual aesthetics is a series of examples that outline the plethora of options for each visual aesthetic. We'll cycle through some options for the color-related aesthetics (`color`, `fill`, and `alpha`) and the differentiation-related aesthetics (`shape` and `size`).

Let's start off with the example given in the next code listing, where `price` vs. `carats` is plotted (*Figure \@ref(fig:dmd-aesthetics-1-p)*). Here we are using the `color` aesthetic for `cut` and the `shape` aesthetic for `clarity`. These aesthetics are defined at the mapping argument of `geom_point()` (enclosed within `aes()`). The point geom needs data and the aesthetics `x` and `y` but it inherits those from the preceding `ggplot()` statement.

<span id="fig:dmd-aesthetics-1-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Using <code>color</code> and <code>shape</code> aesthetics.</p>`{=html}
<div class="ggtab">
<input type="radio" name="dmd-aesthetics-1-tab" id="dmd-aesthetics-1-c" checked="checked">
<label for="dmd-aesthetics-1-c">Code</label>
<div class="tab">

```r
ggplot(dmd, aes(x = carats, y = price)) +  #A
  geom_point(mapping = aes(color = cut, shape = clarity))
```
</div>
<input type="radio" name="dmd-aesthetics-1-tab" id="dmd-aesthetics-1-p">
<label for="dmd-aesthetics-1-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/dmd-aesthetics-1-p-1.png" alt="(ref:dmd-aesthetics-1-p)" width="70%" />
<p class="caption">(\#fig:dmd-aesthetics-1-p)(ref:dmd-aesthetics-1-p)</p>
</div>
(ref:dmd-aesthetics-1-p) Defining two visual aesthetics that give us data points with different colors and shapes.
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>A total of four aesthetics are used here: <code>x</code>, <code>y</code>, <code>color</code>, and <code>shape</code>.
<br style="font-size: 14px;"/>
</details>
```


There are two legends in *Figure \@ref(fig:dmd-aesthetics-1-p)* (both at the right), since we defined two aesthetics aside from `x` and `y`. We will see later that we can modify the legend position and the legend titles as well.

In the next code listing we will experiment with the `alpha` aesthetic, setting a low, fixed value for it.

<span id="fig:dmd-aesthetics-2-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Using the <code>size</code> aesthetic and a fixed <code>alpha</code>.</p>`{=html}
<div class="ggtab">
<input type="radio" name="dmd-aesthetics-2-tab" id="dmd-aesthetics-2-c" checked="checked">
<label for="dmd-aesthetics-2-c">Code</label>
<div class="tab">

```r
ggplot(dmd, aes(x = carats, y = price)) +
  geom_point(mapping = aes(size = depth), alpha = 0.05)  #A
```
</div>
<input type="radio" name="dmd-aesthetics-2-tab" id="dmd-aesthetics-2-p">
<label for="dmd-aesthetics-2-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/dmd-aesthetics-2-p-1.png" alt="(ref:dmd-aesthetics-2-p)" width="70%" />
<p class="caption">(\#fig:dmd-aesthetics-2-p)(ref:dmd-aesthetics-2-p)</p>
</div>
(ref:dmd-aesthetics-2-p) Using a combination of the `size` aesthetic and a fixed `alpha` value.
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>The small value for <code>alpha</code> (<code>0.05</code>) makes non-overlapping data points barely visible.
<br style="font-size: 14px;"/>
</details>
```


*Figure \@ref(fig:dmd-aesthetics-2-p)* shows the same data as previous but uses the `size` aesthetic (mapping to `depth`) instead of `color` and `shape` (so, we're going back to the default dot shape). All points indiscriminately get an `alpha` value of `0.05` (`0` is fully transparent, `1` is entirely opaque). Because the `alpha` aesthetic is given outside of the `aes()` object, we have no mapping to a data variable and that's why a numerical value is used.

Next, let's use nothing but fixed values for the `color`, `fill`, and `shape` aesthetics.

<span id="fig:dmd-aesthetics-3-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Supplying fixed values for <code>color</code>, <code>fill</code>, and <code>shape</code>.</p>`{=html}
<div class="ggtab">
<input type="radio" name="dmd-aesthetics-3-tab" id="dmd-aesthetics-3-c" checked="checked">
<label for="dmd-aesthetics-3-c">Code</label>
<div class="tab">

```r
ggplot(dmd, aes(x = carats, y = price)) +
  geom_point(color = "gray50", fill = "#AAAFEF", shape = 23)  #A
```
</div>
<input type="radio" name="dmd-aesthetics-3-tab" id="dmd-aesthetics-3-p">
<label for="dmd-aesthetics-3-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/dmd-aesthetics-3-p-1.png" alt="(ref:dmd-aesthetics-3-p)" width="70%" />
<p class="caption">(\#fig:dmd-aesthetics-3-p)(ref:dmd-aesthetics-3-p)</p>
</div>
(ref:dmd-aesthetics-3-p) The use of fixed values for the `color`, `fill`, and `shape` aesthetics.
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>The points' <code>color</code>, <code>fill</code>, and <code>shape</code> aesthetics are set manually.
<br style="font-size: 14px;"/>
</details>
```


In *Figure \@ref(fig:dmd-aesthetics-3-p)*, we see the effect of no aesthetics being provided in `aes()` other than the mandatory `x` and `y`. We are going manual here and setting fixed `color`, `fill`, and `shape` values. Note that due to the lack of visual aesthetic mappings, there is no legend.

Shapes are always provided as a number; shape `23` happens be one that accepts both a `color` and a `fill` aesthetic—this is less common among **ggplot** shape types. Given that we often need to know what colors and shapes are available, please refer to *Appendix 1* where reference diagrams show all of the **ggplot** shapes and named colors.

.callout
Note: For the `fill` aesthetic, a hexadecimal color name is provided (`#AAAFEF`). This is a great system for representing a huge range of colors but its understandably harder to memorize many colors this way. A good recommendation is to use a color picker to find a color you like and to retrieve the hex color code. Sites like <http://www.color-hex.com/> or <https://coolors.co/> are helpful for this.
.callout

Most of the aesthetics in previous examples were applied to categorical variables. Now let's have another look at the result of applying an aesthetic to a continuous variable: `depth`.

<span id="fig:dmd-aesthetics-4-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Applying the <code>color</code> aesthetic to the <code>depth</code> variable.</p>`{=html}
<div class="ggtab">
<input type="radio" name="dmd-aesthetics-4-tab" id="dmd-aesthetics-4-c" checked="checked">
<label for="dmd-aesthetics-4-c">Code</label>
<div class="tab">

```r
ggplot(dmd, aes(x = carats, y = price)) +
  geom_point(mapping = aes(color = depth, shape = clarity))  #A
```
</div>
<input type="radio" name="dmd-aesthetics-4-tab" id="dmd-aesthetics-4-p">
<label for="dmd-aesthetics-4-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/dmd-aesthetics-4-p-1.png" alt="(ref:dmd-aesthetics-4-p)" width="70%" />
<p class="caption">(\#fig:dmd-aesthetics-4-p)(ref:dmd-aesthetics-4-p)</p>
</div>
(ref:dmd-aesthetics-4-p) Using the `color` aesthetic on a continuous variable results in the data points mapped to a gradient of colors.
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>Because the <code>depth</code> variable is numeric and continuous, we get a gradient of blue tones mapped to data points.
<br style="font-size: 14px;"/>
</details>
```


In *Figure \@ref(fig:dmd-aesthetics-4-p)*, we get the resulting plot from the four aesthetic mappings of `x`, `y`, `color` and `shape`. The `shape` of the data points is mapped to the discrete `clarity` variable and the `color` of the data points is mapped to the continuous `depth` variable (where brighter blues indicate higher values). As with *Figure \@ref(fig:dmd-aesthetics-1-p)* we get two legends here because there are two visual aesthetics mapped to data.

## Facets and the Art of Faceting in **ggplot**

Facets are a way of splitting a single plot into multiple subplots. The splitting of the dataset is based on a grouping (or a combination of groups). In this way, we get a set of panels where each panel displays a different subset of the data. This is great for comparisons across groupings and, by default, each of the panels will have fixed coordinates (i.e., common scales: we can make easy comparisons of data point values across panels). There are two functions in **ggplot** that let us create faceted plots: `facet_wrap()` and `facet_grid()`.

### Faceting by One Variable

The diamonds described in the `dmd` dataset have discrete variables that are useful for faceting: `color`, `cut`, and `clarity`. What if we could make our plot of `price` vs. `carats` for each of the three cases of clarity (e.g., diamonds with Fair clarity in the first plot, and similarly diamonds with Great and The Best clarity in the second and third plots)? What if these plots could all appear together as a combined graphic? That there is faceting. So let's take the much earlier code used to create `dmd_carats_price` and apply the `facet_wrap()` function to facet by clarity, giving us *Figure \@ref(fig:dmd-facet-clarity-p)*.

<span id="fig:dmd-facet-clarity-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Using an additional statement with <code>facet_wrap()</code> gives us a faceted plot.</p>`{=html}
<div class="ggtab">
<input type="radio" name="dmd-facet-clarity-tab" id="dmd-facet-clarity-c" checked="checked">
<label for="dmd-facet-clarity-c">Code</label>
<div class="tab">

```r
ggplot(dmd, aes(x = carats, y = price)) +
  geom_point() +
  facet_wrap(facets = vars(clarity))  #A
```
</div>
<input type="radio" name="dmd-facet-clarity-tab" id="dmd-facet-clarity-p">
<label for="dmd-facet-clarity-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/dmd-facet-clarity-p-1.png" alt="(ref:dmd-facet-clarity-p)" width="70%" />
<p class="caption">(\#fig:dmd-facet-clarity-p)(ref:dmd-facet-clarity-p)</p>
</div>
(ref:dmd-facet-clarity-p) Faceting by a single categorical variable.
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>The <code>facet_wrap()</code> function requires one or more variable names wrapped in <code>vars()</code>.
<br style="font-size: 14px;"/>
</details>
```


We can see a clear difference in pricing for similarly weighted diamonds between the `"Fair"` and `"The Best"` plots (labels are shown in the panel strips), and less of a difference in the pricing between the `"Great"` and `"The Best"` facets of `clarity.` Faceting makes these types of comparisons relatively easy.

If we were to make separate plots (being careful to filter the dataset by each unique value of `clarity`) they would likely all have different axis ranges, making it harder to compare data across those plots. Further to this, the plots wouldn't be positioned in a way that allows visually scan for differences and this in turn would slow down our analysis. 

In the facets argument of `facet_wrap()`, we needed to wrap the variables we are faceting by in `vars()`. Because a different panel will be made for each unique value in the variable we provide to `vars()`, we have to remember to choose variables that don't have too many distinct values.

### Faceting by Two Variables

We can choose to provide multiple variables to `vars()` and **ggplot** will handle the faceting of interactions between those variables. Let's extend the example that produced *Figure \@ref(fig:dmd-facet-clarity-p)* and incorporate the `cut` variable, which contains the same discrete values as `clarity` (*Figure \@ref(fig:dmd-facet-cut-clarity-p)*).

<span id="fig:dmd-facet-cut-clarity-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Faceting by two variables: <code>cut</code> and <code>clarity</code>.</p>`{=html}
<div class="ggtab">
<input type="radio" name="dmd-facet-cut-clarity-tab" id="dmd-facet-cut-clarity-c" checked="checked">
<label for="dmd-facet-cut-clarity-c">Code</label>
<div class="tab">

```r
ggplot(dmd, aes(x = carats, y = price)) +
  geom_point() +
  facet_wrap(facets = vars(cut, clarity))  #A
```
</div>
<input type="radio" name="dmd-facet-cut-clarity-tab" id="dmd-facet-cut-clarity-p">
<label for="dmd-facet-cut-clarity-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/dmd-facet-cut-clarity-p-1.png" alt="(ref:dmd-facet-cut-clarity-p)" width="70%" />
<p class="caption">(\#fig:dmd-facet-cut-clarity-p)(ref:dmd-facet-cut-clarity-p)</p>
</div>
(ref:dmd-facet-cut-clarity-p) Faceting by two categorical variables with `facet_wrap()`.
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>The <code>vars()</code> function inside <code>facet_wrap()</code> needs variables to be separated by commas.
<br style="font-size: 14px;"/>
</details>
```


The panel strips now show values for the `cut` and the `clarity` faceting variables. If we had instead used `vars(clarity, cut)`, the ordering of panels would be different. In the above plot, the top-left panel shows the lowest-quality combination of `clarity` and `cut` and the panel at bottom-right provides a plot of the rarefied set of diamonds with the best `clarity` and `cut`.

The default appearance of the labels in the strips can make it difficult to distinguish the variables. In the next code listing we will use a nice option, which is `labeller = label_both` inside `facet_wrap()`. This will format the panel strip labels to include both the variable name and value for each panel (*Figure \@ref(fig:dmd-facet-cut-clarity-labeller-p)*).

<span id="fig:dmd-facet-cut-clarity-labeller-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Using the <code>labeller</code> function <code>label_both</code> to create informative labels for facets.</p>`{=html}
<div class="ggtab">
<input type="radio" name="dmd-facet-cut-clarity-labeller-tab" id="dmd-facet-cut-clarity-labeller-c" checked="checked">
<label for="dmd-facet-cut-clarity-labeller-c">Code</label>
<div class="tab">

```r
ggplot(dmd, aes(x = carats, y = price)) +
  geom_point() +
  facet_wrap(facets = vars(cut, clarity), labeller = label_both)  #A
```
</div>
<input type="radio" name="dmd-facet-cut-clarity-labeller-tab" id="dmd-facet-cut-clarity-labeller-p">
<label for="dmd-facet-cut-clarity-labeller-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/dmd-facet-cut-clarity-labeller-p-1.png" alt="(ref:dmd-facet-cut-clarity-labeller-p)" width="70%" />
<p class="caption">(\#fig:dmd-facet-cut-clarity-labeller-p)(ref:dmd-facet-cut-clarity-labeller-p)</p>
</div>
(ref:dmd-facet-cut-clarity-labeller-p) Faceting by two categorical variables and making clearer which variables the labels belong to (by way of `labeller = label_both`).
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>The <code>label_both</code> function supplied to the labeller argument doesn't need parentheses.
<br style="font-size: 14px;"/>
</details>
```


The `facet_wrap()` way of faceting is to make a set of panels with a layout that is from left to right, top to bottom. By default, **ggplot** chooses the optimal layout depending on the number of panels but we can modify this by using the `ncol` and `nrow` arguments of `facet_wrap()`. *Figure \@ref(fig:dmd-facet-cut-clarity-wide-p)* provides an example where we make a wide layout by using `nrow = 1`. 

<span id="fig:dmd-facet-cut-clarity-wide-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> We can specify the total number of rows of plot panels with the <code>nrow</code> argument.</p>`{=html}
<div class="ggtab">
<input type="radio" name="dmd-facet-cut-clarity-wide-tab" id="dmd-facet-cut-clarity-wide-c" checked="checked">
<label for="dmd-facet-cut-clarity-wide-c">Code</label>
<div class="tab">

```r
ggplot(dmd, aes(x = carats, y = price)) +
  geom_point() +
  facet_wrap(
    facets = vars(cut, clarity),
    nrow = 1,  #A
    labeller = label_both
  )
```
</div>
<input type="radio" name="dmd-facet-cut-clarity-wide-tab" id="dmd-facet-cut-clarity-wide-p">
<label for="dmd-facet-cut-clarity-wide-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/dmd-facet-cut-clarity-wide-p-1.png" alt="(ref:dmd-facet-cut-clarity-wide-p)" width="70%" />
<p class="caption">(\#fig:dmd-facet-cut-clarity-wide-p)(ref:dmd-facet-cut-clarity-wide-p)</p>
</div>
(ref:dmd-facet-cut-clarity-wide-p) We can influence the layout of panels by setting a value for `nrow` (we can optionally set a value for `ncol` as well).
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>The <code>nrow</code> argument must be placed inside <code>facet_wrap()</code>; the use of <code>ncol</code> (number of columns) is optional.
<br style="font-size: 14px;"/>
</details>
```


Only one row of panels is generated. Be careful when there is a very large number of panels, as labels on the *x* axis may collide with one another. We can specify the number of columns (`ncol`) or the number of rows (`nrow`) in final layout. Interestingly, we can choose to supply a value to one or both of these arguments.

When faceting by two variables, the use of `facet_grid()` might result in a better appearance of panels. As the name of the function implies, panels are placed into a strict grid. The faceting variables provide the *x* and *y* positions of the panels. Let's rework the plot to the grid layout to demonstrate this. The changes to make are to use `facet_grid()` instead of `facet_wrap()` and, within that, use the `rows` and `cols` arguments (both with `vars()`) to tell **ggplot** which faceting variables should run across rows or columns (*Figure \@ref(fig:dmd-facet-cut-clarity-grid-p)*).

<span id="fig:dmd-facet-cut-clarity-grid-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Using <code>facet_grid()</code> provides a slightly different visualization of the faceted plot panels.</p>`{=html}
<div class="ggtab">
<input type="radio" name="dmd-facet-cut-clarity-grid-tab" id="dmd-facet-cut-clarity-grid-c" checked="checked">
<label for="dmd-facet-cut-clarity-grid-c">Code</label>
<div class="tab">

```r
ggplot(dmd, aes(x = carats, y = price)) +
  geom_point(alpha = 0.2) +
  facet_grid(
    rows = vars(cut), cols = vars(clarity),  #A
    labeller = label_both
  )
```
</div>
<input type="radio" name="dmd-facet-cut-clarity-grid-tab" id="dmd-facet-cut-clarity-grid-p">
<label for="dmd-facet-cut-clarity-grid-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/dmd-facet-cut-clarity-grid-p-1.png" alt="(ref:dmd-facet-cut-clarity-grid-p)" width="70%" />
<p class="caption">(\#fig:dmd-facet-cut-clarity-grid-p)(ref:dmd-facet-cut-clarity-grid-p)</p>
</div>
(ref:dmd-facet-cut-clarity-grid-p) Faceting by two categorical variables with `facet_grid()`.
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>Instead of the optional <code>nrow</code> and <code>ncol</code> arguments of <code>facet_wrap()</code>, we have the required arguments of <code>rows</code> and <code>cols</code> (each requires variables placed inside <code>vars()</code>).
<br style="font-size: 14px;"/>
</details>
```


This arrangement makes is slightly easier to see that the rows of plots represent different values of `cut`. The choice in whether to use `facet_grid()` over `facet_wrap()` is often a matter of taste or practicality. When faceting by a single variable, `facet_wrap()` might be the best way. If there are two faceting variables, try both `facet_wrap()` and `facet_grid()` and then make a call on which approach to faceting works best for that case. Until you develop a better feel for how these faceting options work, don't be afraid to experiment with both functions.

## Working with labels and titles

Through most of the **ggplot** examples we've worked through up to this point, default text was applied to plot elements such as the axis labels and the legend titles. While this is certainly convenient and sufficient for most exploratory plots, we may want to customize the text elements for the purpose of presentation and more effective communication.

Most label customization can be done using the `labs()` function, so, let's make a plot with labels of our own choosing (*Figure \@ref(fig:plot-new-labs-p)*). The general construction is to add several `[aesthetic name] = "[label name]"` name-value pairs, separated by commas, inside `labs()`.

<span id="fig:plot-new-labs-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> The <code>labs()</code> function gives us the opportunity to provide our own labels for different plot elements.</p>`{=html}
<div class="ggtab">
<input type="radio" name="plot-new-labs-tab" id="plot-new-labs-c" checked="checked">
<label for="plot-new-labs-c">Code</label>
<div class="tab">

```r
ggplot(dmd, mapping = aes(x = carats, y = price)) +
  geom_point(mapping = aes(shape = clarity)) +
  labs(
    x = "Weight of the Diamond (carats)",  #A
    y = "Price (USD)", 
    shape = "Diamond Clarity" 
  )
```
</div>
<input type="radio" name="plot-new-labs-tab" id="plot-new-labs-p">
<label for="plot-new-labs-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/plot-new-labs-p-1.png" alt="(ref:plot-new-labs-p)" width="70%" />
<p class="caption">(\#fig:plot-new-labs-p)(ref:plot-new-labs-p)</p>
</div>
(ref:plot-new-labs-p) Replacement of default labels in the plot axis and legend titles with `labs()`.
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>All of the label text needs to be put in quotes.
<br style="font-size: 14px;"/>
</details>
```


Let's further augment our plot with a title and a caption. These elements are very useful for communicating what the plot is showing and for providing extra details which can be important for the intended audience. The text elements of `title` and `subtitle` can be used to add a descriptive title and subtitle above the plot. Should we need to further describe aspects of the plot, a `caption` (which appears below the plot) can be used. *Figure \@ref(fig:plot-labs-titles-p)* provides an example that shows all of these textual elements.

<span id="fig:plot-labs-titles-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> We can specify the plot's <code>title</code>, <code>subtitle</code>, and <code>caption</code> inside <code>labs()</code> as well.</p>`{=html}
<div class="ggtab">
<input type="radio" name="plot-labs-titles-tab" id="plot-labs-titles-c" checked="checked">
<label for="plot-labs-titles-c">Code</label>
<div class="tab">

```r
ggplot(dmd, mapping = aes(x = carats, y = price)) +
  geom_point(mapping = aes(shape = clarity)) +
  labs(
    title = "The Relationship Between Diamond Weight on Price",  #A
    subtitle = "Quality of diamond clarity is indicated by shape",  #B
    caption = "Data taken from the `dmd` dataset",  #C
    x = "Weight of the Diamond (carats)",  #D
    y = "Price (USD)",  #E
    shape = "Diamond Clarity"  #F
  )
```
</div>
<input type="radio" name="plot-labs-titles-tab" id="plot-labs-titles-p">
<label for="plot-labs-titles-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/plot-labs-titles-p-1.png" alt="(ref:plot-labs-titles-p)" width="70%" />
<p class="caption">(\#fig:plot-labs-titles-p)(ref:plot-labs-titles-p)</p>
</div>
(ref:plot-labs-titles-p) Replacement of default labels and the addition of a `title`, `subtitle`, and a `caption`. All with `labs()`.
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A,#B,#C </span>These label elements adorn the top and bottom of the plot.<br><span style="color:steelblue;font-weight:bold;">#D,#E </span>These are the axis labels.<br><span style="color:steelblue;font-weight:bold;">#F </span>This label is for the legend. It refers to the shape aesthetic used in <code>geom_point()</code>.
<br style="font-size: 14px;"/>
</details>
```


Adding linebreaks to long labels: Should we need to add line breaks because a label is too long for a single line, one or more linebreak characters (`\n`) can be inserted into the label text (e.g., `color = "Diamond\nCut"`).

The plot in *Figure \@ref(fig:plot-labs-titles-p)* is very presentable and wouldn't be out of place in a presentation or a report. The usage of the `title`, `subtitle`, and `caption` elements is entirely up to you. Experiment with using them in different situations and develop your own style!

## Modifying the Location of Legends

The placement of legends is a common customization. While the default placement on the right is reasonable, you might find that placing legends below the plot can be more aesthetically pleasing. The customization of legend placement is done with the `theme()` function. This function actually allows one to modify virtually any component in the plot, and it has a huge number of arguments. While we won't go into depth on setting themes or getting a handle on theme customization until later in the book, we'll simply use the `theme()` function with the `legend.position` and `legend.justification` arguments to provide a few handy methods related to legend placement.

Let's start with a basic plot on which to base future examples by including the `theme(legend.position = "right")` statement. The resulting plot is shown as *Figure \@ref(fig:plot-legend-right-p)*.

<span id="fig:plot-legend-right-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Using the <code>legend.position</code> argument of <code>theme()</code> to put the legend to the right of the plot.</p>`{=html}
<div class="ggtab">
<input type="radio" name="plot-legend-right-tab" id="plot-legend-right-c" checked="checked">
<label for="plot-legend-right-c">Code</label>
<div class="tab">

```r
ggplot(dmd, aes(x = carats, y = price)) +
  geom_point(aes(shape = clarity)) +
  labs(shape = "Clarity") +
  theme(legend.position = "right")  #A
```
</div>
<input type="radio" name="plot-legend-right-tab" id="plot-legend-right-p">
<label for="plot-legend-right-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/plot-legend-right-p-1.png" alt="(ref:plot-legend-right-p)" width="70%" />
<p class="caption">(\#fig:plot-legend-right-p)(ref:plot-legend-right-p)</p>
</div>
(ref:plot-legend-right-p) Putting the legend to the right (this is the default placement).
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>The <code>theme()</code> function has a lot of options. The <code>legend.position</code> option allows us to place the legend in one of four different areas.
<br style="font-size: 14px;"/>
</details>
```


The plotting code in the previous listing includes the `theme(legend.position = "right")` statement, however, it doesn't really need this statement since `legend.position = "right"` is the default (we see this throughout the plots we made). Nonetheless, this example provides a useful template for understanding how this argument works within `theme()`.

The legend can be put in other locations. The plotting code can be revised to place the legend at the `"bottom"` of the plot.

<span id="fig:plot-legend-bottom-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Using the <code>legend.position</code> argument of <code>theme()</code> to put the legend below the plot.</p>`{=html}
<div class="ggtab">
<input type="radio" name="plot-legend-bottom-tab" id="plot-legend-bottom-c" checked="checked">
<label for="plot-legend-bottom-c">Code</label>
<div class="tab">

```r
ggplot(dmd, aes(x = carats, y = price)) +
  geom_point(aes(shape = clarity)) +
  labs(shape = "Clarity") +
  theme(legend.position = "bottom")  #A
```
</div>
<input type="radio" name="plot-legend-bottom-tab" id="plot-legend-bottom-p">
<label for="plot-legend-bottom-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/plot-legend-bottom-p-1.png" alt="(ref:plot-legend-bottom-p)" width="70%" />
<p class="caption">(\#fig:plot-legend-bottom-p)(ref:plot-legend-bottom-p)</p>
</div>
(ref:plot-legend-bottom-p) Putting the legend at the bottom.
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>Setting the legend position to the bottom creates a horizontal layout, which presents well if the legend doesn't have too many items.
<br style="font-size: 14px;"/>
</details>
```


By using `"bottom"` instead of `"right"` for `legend.position`, we see that the legend is at the bottom. We can also use the values `"top"` and `"left"` to place the legend at the top or to the left.

Using the `legend.justification` argument in `theme()` we can have the legend vertically justified to the `"top"` of the plot.

<span id="fig:plot-legend-just-top-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Use the <code>legend.justification</code> argument of <code>theme()</code> to justify the legend toward the top of the visualization.</p>`{=html}
<div class="ggtab">
<input type="radio" name="plot-legend-just-top-tab" id="plot-legend-just-top-c" checked="checked">
<label for="plot-legend-just-top-c">Code</label>
<div class="tab">

```r
ggplot(dmd, aes(x = carats, y = price)) +
  geom_point(aes(shape = clarity)) +
  labs(shape = "Clarity") +
  theme(legend.justification = "top")  #A
```
</div>
<input type="radio" name="plot-legend-just-top-tab" id="plot-legend-just-top-p">
<label for="plot-legend-just-top-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/plot-legend-just-top-p-1.png" alt="(ref:plot-legend-just-top-p)" width="70%" />
<p class="caption">(\#fig:plot-legend-just-top-p)(ref:plot-legend-just-top-p)</p>
</div>
(ref:plot-legend-just-top-p) Default legend position to the right but justified to the top.
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>Here, the legend position is to the right (that's the default position). We can justify the legend to the top of the visualization with <code>legend.justification</code>.
<br style="font-size: 14px;"/>
</details>
```


Other values can be used, like `"bottom"`, `"left"`, and `"right"`. We can also combine positioning and justification by providing values to both `legend.position` and `legend.justification`. One use of that (not shown, but looks great) is `theme(legend.position = "bottom", legend.justification = "right")`.

But what if we don't want the legend at all? This is sometimes the case and it's not very obvious how we might hide our legend. The thing to do here is to use `theme(legend.position = "none")`. Then, the legend disappears as we can see in *Figure \@ref(fig:plot-no-legend-p)*.

<span id="fig:plot-no-legend-p"></span>
`<p style="margin-bottom: 6px; font-size: 15px"><strong>CODE //</strong> Using the <code>legend.position</code> argument of <code>theme()</code> to remove the legend entirely.</p>`{=html}
<div class="ggtab">
<input type="radio" name="plot-no-legend-tab" id="plot-no-legend-c" checked="checked">
<label for="plot-no-legend-c">Code</label>
<div class="tab">

```r
ggplot(dmd, aes(x = carats, y = price)) +
  geom_point(aes(shape = clarity)) +
  labs(shape = "Clarity") +
  theme(legend.position = "none")  #A
```
</div>
<input type="radio" name="plot-no-legend-tab" id="plot-no-legend-p">
<label for="plot-no-legend-p">Plot</label>
<div class="tab">
<div class="figure" style="text-align: center">
<img src="careful_counting_patterns_files/figure-html/plot-no-legend-p-1.png" alt="(ref:plot-no-legend-p)" width="70%" />
<p class="caption">(\#fig:plot-no-legend-p)(ref:plot-no-legend-p)</p>
</div>
(ref:plot-no-legend-p) A plot with no legend at all. 
</div>
</div>

```{=html}
<details style="font-family: &#39;Open Sans&#39;, sans-serif; color: #333333; font-size: 12px; margin-bottom: 12px; padding-top: 4px; padding-bottom: 4px;">
<summary style="outline-style: solid; outline-width: 1px; outline-color: #B6B4FA; background-color: white; margin-left: 0.5px; margin-top: -10px; padding-left: 5px; text-indent: 1px; cursor: pointer; font-size: 12px; display: list-item;">Notes on the code</summary>
<span style="color:steelblue;font-weight:bold;">#A </span>There are instances where we don't want or need the legend. To do that, we set <code>legend.position</code> to <code>&quot;none&quot;</code>.
<br style="font-size: 14px;"/>
</details>
```


In this example code, there are still labels defined for the nonexistent legend in `labs()` but it's okay to leave them in without worrying about an error.

## Summary

- We used the **ggplot** package to create many variations of a scatterplot (from the `sw` dataset) using different aesthetics (e.g., shapes, color, etc.)
- Faceted plots were explained and experimented with using the `facet_wrap()` and `facet_grid()` functions
- We modified text in key plot elements using the `labs()` function
- We altered the placement of legends by using options in the `theme()` function

## Exercises

Notes
 - questions might be split nicely into quiz-type questions (definitive answers), open-ended/requiring exploration
 - reframe questions about practices to emphasize the reasons for doing so (e.g., first question should be reframed)


1. When you are creating a new **R Markdown** document for visualization with **ggplot**, what **R** statement should be written (and executed) before any plotting?

2. What is the first function that should use when making a **ggplot** plot?

3. Three mini-questions about `aes()`: (a) What does `aes` stand for?, (b) Can we leave out the `mapping =` part before the `aes()` object?, and (c) What goes inside of the `aes()` object?

4. The following two statements can produce exactly the same plot: (1) `ggplot(data = dmd, mapping = aes(x = carats, y = price)) + geom_point()`, (2) `ggplot() + geom_point(data = dmd, mapping = aes(x = carats, y = price))`. If they are different statements, why do they produce the same plot?

5. How would you modify the **ggplot** code (`ggplot(data = dmd, mapping = aes(x = carats, y = price)) + geom_point()`) to ensure that all points are colored `"red"`?

6. What is the difference in the between these two sets of statements? (1) `ggplot(dmd, aes(x = carats, y = price, color = depth)) + geom_point()`, (2) `ggplot(dmd, aes(x = carats, y = price)) + geom_point(color = "blue")`. What effect does this difference have on the plots they generate and why do these plotting differences occur?

7. What types of colors can be supplied to `color` if we are not using color inside `aes()`?

8. The `geom_point()` function requires two aesthetics to absolutely be defined (either directly within `geom_point()` or within the `ggplot()` function). What are their names?

9. What would the plot look like if you were to use the plotting code: `ggplot(data = dmd, mapping = aes(x = carats, y = price)) + geom_point(mapping = aes(size = price))`?

10. When faceting with `facet_wrap()` or `facet_grid()`, what is the function that we need to wrap the data's column names in?

11. When using `facet_wrap()`, which arguments allow us to control the number of panel rows and panel columns?

12. In one of the **ggplot** examples we used `alpha = 0.2`. What is the effect of using `alpha = 0.0`?

13. What single **ggplot** function can we use to relabel legend titles and to provide a plot title?

14. Suppose we were to write the following plotting code: `ggplot(data = dmd, mapping = aes(x = carats, y = price)) + geom_point(mapping = aes(color = depth)) + labs(color = "Depth") + labs(title = "Price vs. Carats")`. Is it okay to use two `labs()` statements like that?

15. How would you rewrite the plotting code in *Q14* so that the shape of each data point is an open (non-filled) diamond?

16. How does one remove all legends from a plot?

17. Rewrite the plotting code in *Q14* so both of these things are accomplished: (1) placing the legend to the left of the plot area, and (2) justifying the legend components to the bottom of the plot area.

18. When using `labs()` to add labels to a plot, are we able to use a subtitle and without specifying a title?

19. We've seen in the lesson's examples that using `facet_grid()` with single variables in `rows` and `cols` produces a 2D grid of panels. What happens if we use two variables in either `rows` or `cols`? The following plotting code has this very thing: `ggplot(dmd, aes(x = carats, y = price)) + geom_point() + facet_grid(rows = vars(color, cut), cols = vars(clarity))`.

20. Try running the following plotting code: `ggplot(dmd, aes(x = carats, y = price)) + geom_point(aes(shape = depth))`. It results in an error. Why do you think this error occurs? What can be done instead?

## Possible Answers (put in `details` section for each question)

1. A `library` statement should ideally come first and be executed first. This could be `library(tidyverse)` (or `library(ggplot2)` if you know you just want to use functions from **ggplot**).

2. The first function should be `ggplot()`.

3. Answers to the three mini-questions about `aes()`: 
  a. The `aes` stands for aesthetics.
  b. Yes, we can leave out the argument name `mapping`. We can even leave out the argument name `data`. We just need to make sure that the data object is placed first in the function body and that `aes()` comes next. These statements create a valid plot: `ggplot(dmd, aes(x = carats, y = price)) + geom_point()`
  c. Inside `aes()` we have aesthetic mappings (and indeed the `aes()` object is required after `mapping =`). Aesthetic mappings are name-value pairs where data column names are assigned to aesthetics such as `x`, `y`, `color`, `size`, etc.

4. Both pieces of plotting code are functionally equivalent because the `ggplot()` function provides defaults for data and mapping to any subsequent functions that require them. In statement (1) these objects are inherited by the `geom_point()` layer, in statement (2) these objects are created in and used directly by the `geom_point()` layer.

5. To get all points in red, one must ensure that `color = "red"` is given in `geom_point()` and that it is *not* inside `aes()`. This is the plotting code: `ggplot(data = dmd, mapping = aes(x = carats, y = price)) + geom_point(color = "red")`. 

6. The difference lies in how we are using the color argument. In statement (1) `color` is used inside of `aes()` and so we are allowed to map a variable to it (each data point's color varies according to the value of depth). In statement (2) we are using `color` outside of `aes()` and providing a single value of `"blue"` thus making all of the plotted data points appear blue.

7. When using color outside of `aes()` we can provide a color name (e.g., `"red"`, `"blue"`, `"green"`) or a hexadecimal color code (e.g., `"#EFEFEF"`, etc.).

8. The required aesthetics for `geom_point()` are `x` and `y`. (All other aesthetics for `geom_point()` will receive default values if not provided.)

9. The size of the data points would become larger as `price` increases. Also, a legend is displayed for `price` (to the right of the plot area).

10. We must wrap column names in `vars()` when using `facet_wrap()` or `facet_grid()`.

11. We can use `nrow` to specify the number of rows of panels. We can use `ncol` to specify the number of columns of panels.

12. With `alpha = 0.0`, all points in the *geom* (we used `geom_point()` in the previous examples) would be fully transparent, or, invisible.

13. The **ggplot** function for working with labels is `labs()`.

14. It definitely OK to use multiple `labs()` statements. The end result is additive, and these statements don't overwrite previous ones.

15. We need to define a constant `shape` aesthetic to overwrite the default constant `shape`. The open diamond is shape `5`, so the revised plotting code for this is: `ggplot(data = dmd, mapping = aes(x = carats, y = price)) + geom_point(mapping = aes(color = depth), shape = 5) + labs(color = "Depth") + labs(title = "Price vs. Carats")`.

16. Removal of all plot legends can be accomplished through the use of `theme(legend.position = “none”)`.

17. We can rewrite the plotting code like this: `ggplot(data = dmd, mapping = aes(x = carats, y = price)) + geom_point(mapping = aes(color = depth), shape = 5) + labs(color = "Depth") + labs(title = "Price vs. Carats") + theme(legend.position = "left", legend.justification = "bottom")`.

18. It is possible use `subtitle` without using a `title` in a plot! The sizing of the it will be the same as a subtitle that's used with a title. 

19. What we get if we run the plotting code is rows of panels that incorporate combinations of `color` and `cut` values in the strip titles, and, columns of `clarity` facets. Additionally, we can see that some of the subplots are empty because the data doesn't have all combinations of `color`, `cut`, and `clarity.`

20. The error message we get from this plotting code reads `Error: A continuous variable can not be mapped to shape`. Because the `depth` variable encompasses a range of values, it is considered to be continuous. Since we have limited numbers of shapes and its inherently difficult to map shapes on continuous scale, **ggplot** cannot construct a plot. One option is to map `depth` to a different visual aesthetic like `color` or `size.` Another option is to use **dplyr** to first modify the dataset by generating a categorical variable based on `depth.`


## Project


(should have a fully working set of Rmd templates, presented in the form of a project template - this can be prepped for the reader with a function call)

The moma dataset (https://apreshill.github.io/data-vis-labs-2018/02-moma.html) would be great for a project
- explore using the lisa palette from paletteer


### Intro


### Data


### Goals


### Instructions

 - instructions on using project wizard


### Packages Needed

 - installation details (script with `library()` calls)
 - possibly use: https://github.com/rstudio4edu/rmd4edu/blob/master/R/lesson.R


