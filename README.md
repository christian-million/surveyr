# svdg_survey

Functions to ease summarizing the SVDG Member Survey results.

# Motivation

For interactive exploratory data analysis, it is much less cognitively taxing to structure survey response data as a dataframe where each column is a question, and each row is a unique individuals response. Unfortunately, I'm pretty sure this goes against the tidyverse principles.

To conform with tidyverse principles, one would want to `gather` all of the questions and responses into two columns. This would make performing routine `dplyr` and `ggplot2` calls much easier. Depending on the structure and content of your survey questions and responses, though, each response may be of a different variable type. For example, in the same survey, I could have a question that asks participants what their annual income is (numeric) and a question that asks them to write 5 sentences on their opinion of the economy. Because each question may have a different response type, I would need to add a `type` variable to my dataframe, which is easy enough. Though again, it takes a little more cognitive effort to restructure the conceptualization of this data when exploring it interactively.

So how do I use my fave tidy tools without tidy data? Gotta make me some of them fancy wrapper functions.

In summmary, to reduce the *extraordinarily taxing* reconceptualization involved with tidy data, I decided to spend hours crafting functions that will save me seconds over my lifetime on future survey response EDA. Luckily, re-inventing the wheel is a great way for me to learn more about programming concepts and the inner workings of R.

# How is this thing going to work?

Inspired by [David Robinson's](http://varianceexplained.org/) [stacksurveyr package](https://github.com/dgrtwo/stacksurveyr), these functions work on survey data structured as a dataframe in tandem with a "survey schema" which defines the variable types, question names, and other details.

I'm using SVDG's Member Survey as an example data set on which to create these functions, hence the repo name.

# To Do:

I figured I would keep a list of ideas to explore and tasks to accomplish here in the README until I make enough progress to turn this bad boy into a solid, stand-alone, personal package.

- schema structure creator functions? Oooooo.
- standardize variable name usage.
- make function names more evocative, with standard verbs and structure.
- make `response_scales` return the `unique` of the argument, if response_type is factor/ordered and scale arg not supplied.
- handle multiple arguments to `openize`
- ERROR HANDLE ANYTHING AT ALL
- survey response summary statistic functions. (i.e., response rate, responses per question.)
- quick visuals to compare response X by response Y (group_by, depending on x and y var_type)
- change structure to package format, for quick reloads and better workflow
- clarify goals of package and function
- comment stuff

# Oh, crap.

This [package](https://github.com/andrie/surveydata) pretty much captured the essence of where I wanted this package to go (and does it so much more elegantly). So maybe I can incorporate it's structure in order to add onto things like:

- Handling Open Ended Questions
- More plots
- Tidy Eval (So we don't have to use quotes)

Well, we'll see what happens moving forward. At least I am learning a lot!
