# Simple Linear Regression

### Problem Statement:-

  - Build a prediction model for Salary_hike
  
### Data Understanding   

```{r}
sal <- read.csv("~/desktop/Digi 360/Module 6/DataSets-4/Salary_Data.csv")
head(sal)
```

```{r}
#renaming the columns
colnames(sal) <- c("exp","salary")
```

```{r}
# checking the summary
summary(sal)
```

Here, the mean is greater than the median for experience so the distribution is right skewed. 

Similarly, the mean is greater than the median for salary hike so the distribution is right skewed. 


### Visualization

```{r}
x <- boxplot(sal$exp)
x$out
```

So, there are no outliers.

```{r}
y <- boxplot(sal$salary)
y$out

```

So, there are no outliers.

Let’s draw scatter diagram to see the relationship between salary hike and Experience.

```{r}
plot(sal$exp, sal$salary) # Scatter plot
```

### Correlation

```{r}
cor(sal$exp, sal$salary)
```

Here the correlation coefficient value is 0.98 which is greater than 0.85. So, the relationship between salary hike and years of experience is strong. 

### Building the model

```{r}
model <- lm(sal$salary ~ sal$exp)
summary(model)

```

So, the linear equation is 
y^ = 25792.2 + 9450x. Here y^ = salary hike and x = years of experience. 


### Model Evolution

Here p value is less than 0.05 so we reject the null hypothesis. That means there is significant correlation between salary hike and years of experience.

Here we also can see R-squared value is 0.957 which is greater than 0.85. Hence our model is good and we don’t need further transformations. 

Since we are ready with equation, let’s predict the values with 95% CI level.

```{r}
pred <- predict(model, sal)
model$residuals

```

```{r}
confint(model, level =0.95)
```

```{r}
predict(model, interval = "confidence")
```

### Accuracy 

Now let’s find out the accuracy. 

```{r}
#Finding RMSE
rmse <- sqrt(mean(model$residuals^2))
rmse
```

So, we can conclude that our predicted values are 5592 points deviated from actual values.

Now let’s visualize the predicted values using a ggplot to add a regression line to it.

```{r}
library(ggplot2)
ggplot(data=sal,aes (x = exp, y = salary)) +
 geom_point(color='blue') +
 geom_line(color = 'red', data=sal,aes (x = exp, y = pred))

```

### Conclusion:-

  - The model R^2 is 0.96. So, our model is good.
