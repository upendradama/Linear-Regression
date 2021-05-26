# Simple Linear Regression

### Problem Statement:-

  - Build a model to predict weight gained using calories consumed
  
### Data Understanding   

```{r}
cal <- read.csv("~/desktop/Digi 360/Module 6/DataSets-4/calories_consumed.csv")
head(cal)
```

```{r}
#renaming the columns
colnames(cal) <- c("weight_gained", "cals_consumed")
```

```{r}
# checking the summary
summary(cal)
```

Here, the mean is greater than the median for weight gained so the distribution is right skewed. 

Similarly, the mean is greater than the median for calories consumed so the distribution is right skewed. 

### Visualization

```{r}
boxplot(cal$weight_gained)
```

So, there are no outliers.

```{r}
y <- boxplot(cal$weight_gained)
y$out

```

So, there are no outliers.

Let’s draw scatter diagram to see the relationship between weight gained and calories consumed.

```{r}
plot(cal$cals_consumed, cal$weight_gained) # Scatter plot
```

### Correlation

```{r}
cor(cal$cals_consumed, cal$weight_gained)
```

Here the correlation coefficient value is 0.95 which is greater than 0.85. So, the relationship between weight gained and calories consumed is strong 

### Building the model

```{r}
model <- lm(cal$weight_gained ~ cal$cals_consumed)
summary(model)

```

So, the linear equation is 
y^ = -625.7524 + 0.4202x. Here y^ = calories consumed and x = weight gained. 

### Model Evolution

Here p value is less than 0.05 so we reject the null hypothesis. That means there is significant correlation between weight gained and calories consumed.

Here we also can see R-squared value is 0.8968 which is greater than 0.85. Hence our model is good and we don’t need further transformations. 

Since we are ready with equation, let’s predict the values with 95% CI level.

```{r}
pred <- predict(model, cal)
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

So, we can conclude that our predicted values are 103 points deviated from actual values.

Now let’s visualize the predicted values using a ggplot to add a regression line to it.

```{r}
library(ggplot2)
ggplot(data=cal,aes (x = cals_consumed, y = weight_gained)) +
 geom_point(color='blue') +
 geom_line(color = 'red', data=cal,aes (x = cals_consumed, y = pred))

```

### Conclusion:-

  - The model R^2 is 0.90. So, our model is good.
