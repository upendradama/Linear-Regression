# Simple Linear Regression

### Problem Statement:-

  - Build a model to predict delivery time using sorting time
  
### Data Understanding   

```{r}
time <- read.csv("~/desktop/Digi 360/Module 6/DataSets-4/delivery_time.csv")
head(time)
```

```{r}
#renaming the columns
colnames(time) <- c("d_time","s_time")
```

```{r}
# checking the summary
summary(time)
```

Here, the mean is less than the median for delivery time so the distribution is left skewed. 

Whereas, the mean is greater than the median for sorting time so the distribution is right skewed. 

### Visualization

```{r}
boxplot(time$s_time)
```

So, there are no outliers.

```{r}
y <- boxplot(time$s_time)
y$out

```

So, there are no outliers.

Let’s draw scatter diagram to see the relationship between delivery time and sorting time.

```{r}
plot(time$s_time,time$d_time) # Scatter plot
```

### Correlation

```{r}
cor(time$s_time,time$d_time)
```

Here the correlation coefficient value is 0.83 which is less than 0.85. So, the relationship between delivery time and sorting time is moderate. 

### Building the model

```{r}
model <- lm(time$d_time ~ time$s_time)
summary(model)

```

So, the linear equation is 
y^ = 6.583 + 1.649x. Here y^ = sorting time and x = delivery time. 

### Model Evolution

Here p value is less than 0.05 so we reject the null hypothesis. That means there is significant correlation between delivery time and sorting time.

Here we also can see R-squared value is 0.6823 which is less than 0.85. Hence our model is not good and we need to go for transformations. 


Since we are ready with equation, let’s predict the values with 95% CI level.

```{r}
pred <- predict(model, time)
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

So, we can conclude that our predicted values are 2.79 points deviated from actual values.

Now let’s visualize the predicted values using a ggplot to add a regression line to it.

```{r}
library(ggplot2)
ggplot(data=time,aes (x = s_time, y = d_time)) +
 geom_point(color='blue') +
 geom_line(color = 'red', data=time,aes (x = s_time, y = pred))

```

Since our R^2 value 0.6823 which is less than 0.85, we need to go for transformations.

### Log Model

```{r}
plot(log(time$s_time),time$d_time)
```

```{r}
model2 <- lm(time$d_time ~ log(time$s_time))
summary(model2)
```
Since R^2 value is still less than 0.85, let’s go to exponential model.

### Exponential model

```{r}
plot(time$s_time,log(time$d_time))
```

```{r}
model3 <- lm(log(time$d_time) ~ time$s_time)
summary(model3)

```

Since R^2 value 0.7109 is still less than 0.85, let’s go to 2 degree polynomial model.

### 2 degree polynomial model

```{r}
model4 <- lm(log(time$d_time) ~ time$s_time + I(time$s_time * time$s_time))
summary(model4)
```

```{r}
log_dt <- predict(model4,interval="confidence")
log_dt

```

```{r}
dt <- exp(log_dt)
dt

```


```{r}
err2 <- time$d_time - dt
err2

```

```{r}
rmse <- sqrt(mean(err2^2))
rmse

```


Here R^2 value 0.7649. We can go for further transformations but it will lead to over fitting. So, let's stop the building model here.

### Conclusion:- 

  - R^2 with linear model is 0.68
  - R^2 with Log model is 0.70
  - R^2 with Exponential model is 0.71
  - R^2 with 2nd Degree Polynomial model is 0.76