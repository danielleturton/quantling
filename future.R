


## Making summary tables with `dplyr`

`dplyr` is an R package which makes it very easy to look at summaries of data.  Even though some people consider it more advanced, I think it's a good idea to introduce beginners to it from the start.  We're going to try to do the same using this package.  

We already loaded it in at the start, but if you hadn't have done that by now, the following code would not work.  Always make sure you've run the line `library(dplyr)` at the beginning of each session to run this kind of code.

`dplyr` makes regular use of this set of symbols, which it calls the *pipe*: `%>%`. This signifies to R that you haven't finished with your code yet, and it needs to look to the next line to figure out what's happening next. It's *piping* the code to the next line. If you get an error message about the pipe `%>%`, it probably means you haven't loaded in `dplyr`.

```{r}
dialect_data %>%
  group_by(age_group) %>% # the independent variable
  count(foot_strut) %>% # the dependent variable
  mutate(prop = prop.table(n))
```
Can you see how this package allows us to do the same thing as we did before, but a bit quicker?  
  
  Create a chunk below and try creating some other summaries in `dplyr`.  First, let's create a summary for another independent variable of `foot_strut`:
```{r}
# here you can look at another independent variable's affect on foot_strut

```

Now let's try a different independent *and* dependent variable.  Insert a new chunk below:





We've seen in this section that there's always (at least!) a couple of ways to do things in R.  In the next section we'll look at making some plots, starting off with the R base graphics, and moving on to some more advanced packages which look more difficult at the beginning, but actually make life easier in the end, and produce much nicer looking plots.




# Plots

## Base R graphics
Let's try making a plot of the `foot_strut` variable.  We can use Base R's `barplot` function to do this, and it's useful that we've already made tables of the frequencies and proportions.  

We could just plot the raw frequencies, but this isn't very helpful:
```{r}
barplot(foot_strut.tab)
```
This graph looks quite rubbish.  It's unclear what the trend is, as our sample is so biased towards young people.  Also, it's annoying for us that R automatically plots factor levels in alphabetical order, because it puts the middle aged group at the front.  We'll come to that in a bit.  

Firstly, can you try plotting the proportions instead of the frequencies?  Try it in the chunk below, and shout me if you get stuck.
```{r}
#create a barplot with the proportions of foot_strut instead of raw numbers

```


Can we get it so that it goes in order of age group?  Let's take a look at the factor levels of `age_group` using the levels function:
```{r}
levels(dialect_data$age_group)
```

Can you see that they are in alphabetical order?  We can change the order of these levels.  Again, there are many ways to do this.  We'll be looking at how you do it in 1) base R and 2) `dplyr`.  Firstly, we'll look at how you do it in base R.  In the chunk below, I've actually created a new variable called `age_group_ordered`.  You don't have to do this usually, you can just re-specify the order of `age_group`.  However, I want to keep the old order to show you how to reorder in `dplyr` too.  Saying that, sometimes, if you're not sure of what you're doing, it's better to avoid writing over the old.

Let's reorder the factor levels:
```{r}
# reordering
dialect_data$age_group_ordered = factor(dialect_data$age_group,levels(dialect_data$age_group)[c(3, 1, 2)])

#having a look at new order
levels(dialect_data$age_group_ordered)
```

Try the plot again with the new order by creating a chunk below:






## Plots in `ggplot2`

Not only do `ggplot2` plots look prettier and are easier to customise, we can also combine them with `dplyr` code to make data changes efficiently.  Both packages are written by Hadley Wickham, whose R [style guide](http://adv-r.had.co.nz/Style.html) we discussed earlier in this course.

The package to make ggplots is called `ggplot2`.  Remember the `2` when you load in the package, otherwise it won't work.  We already loaded it in before, but you'll need to do that each time you start R by calling `library(ggplot2)`.

The plot call initially looks a lot more complicated. But `gg` stands for *grammar of graphics*, and as you get used to using it, you'll realise it's much easier to switch between different kinds of graphs, and customise the look of them.

Let's try a barplot for foot_strut and age_group in `ggplot2`:
  ```{r}
ggplot(dialect_data, aes(age_group_ordered, fill = foot_strut)) + 
  geom_bar()
```

This has given us the frequencies.  Again, it'd be better to see the percentages, rather than the raw numbers.  We can do this easily by adding `position="fill"` to the `geom_bar()` bit:

```{r}
ggplot(dialect_data, aes(age_group_ordered, fill = foot_strut)) +
geom_bar(position="fill")
```

The beauty of ggplot is that you can just stack up command after command using the `+` symbol to customise your plot.

I can change the x axis title:
```{r}
ggplot(dialect_data, aes(age_group_ordered, fill = foot_strut)) +
geom_bar(position="fill") +
xlab("age group")
```

I can move the legend to the bottom:
```{r}
ggplot(dialect_data, aes(age_group_ordered, fill = foot_strut)) +
geom_bar(position="fill") +
xlab("age group") +
theme(legend.position = "bottom")
```

I can change the colours:
```{r}
ggplot(dialect_data, aes(age_group_ordered, fill = foot_strut)) +
geom_bar(position="fill") +
xlab("age group") +
theme(legend.position = "bottom") +
scale_fill_manual(values = c("red", "yellow"))
```

Try changing the colours yourself in the chunk below:
```{r}
#my ggplot with new colours

```

In fact, if you're bad at choosing which colours go together, there are many in built colour palettes that you can use.  A list can be found [here](https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/colorPaletteCheatsheet.pdf) alongside the colour names that R accepts.

Let's try a palette.  I'm going to try Set1 from the above link.  Try messing around with it to get a colour scheme you like.
```{r}
ggplot(dialect_data, aes(age_group_ordered, fill = foot_strut)) +
  geom_bar(position="fill") +
  scale_fill_brewer(palette="Set1") 
```

Try creating a plot from scratch using a different dependent variable.  Our phonological variables are pretty orderly- they only have two factor levels, or variants.  How do things start to look with some of our syntactic variables, or lexical?  Try to make three plots: one new phonological, one new syntactic and one new lexical.

Once you've done that, you could look at other things that you can play around with in the settings of `ggplot2`.  Here you can find the [ggplot cheat sheet](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf).

Next week, we'll be looking at how to automatically save figures to pdf. 