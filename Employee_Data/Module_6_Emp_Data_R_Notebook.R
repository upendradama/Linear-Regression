# Simple Linear Regression

### Problem Statement:-

  - Build a prediction model for Churn_out_rate
  
### Data Understanding   

```{r}
emp <- read.csv("~/desktop/Digi 360/Module 6/DataSets-4/emp_data.csv")
head(emp)
```

```{r}
#renaming the columns
colnames(emp) <- c("hike","churn")
```

```{r}
# checking the summary
summary(emp)
```

Here, the mean is greater than the median for Salary Hike so the distribution is right skewed. 

Similarly, the mean is greater than the median for churn out rate so the distribution is right skewed. 


### Visualization

```{r}
boxplot(emp$hike)
```

So, there are no outliers.

```{r}
y <- boxplot(emp$churn)
y$out

```

So, there are no outliers.

Let’s draw scatter diagram to see the relationship between hike and churn out rate.

```{r}
plot(emp$hike,emp$churn) # Scatter plot
```

### Correlation

```{r}
cor(emp$hike,emp$churn)
```

Here the correlation coefficient value is 0.91 which is greater than 0.85. So, the relationship between salary hike and churn out rate is strong. 

### Building the model

```{r}
model <- lm(emp$churn ~ emp$hike)
summary(model)

```

So, the linear equation is 
y^ = 244.3649 – 0.1015x. Here y^ = churn out rate and x = salary hike. 

### Model Evolution

Here p value is less than 0.05 so we reject the null hypothesis. That means there is significant correlation between salary hike and churn out rate.

Here we also can see R-squared value is 0.831 which is less than 0.85. Hence our model is not good and we need further transformations. 

Since we are ready with equation, let’s predict the values with 95% CI level.

```{r}
pred <- predict(model, emp)
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

So, we can conclude that our predicted values are 3.99 points deviated from actual values.

Now let’s visualize the predicted values using a ggplot to add a regression line to it.

```{r}
library(ggplot2)
ggplot(data=emp,aes (x = hike, y = churn)) +
 geom_point(color='blue') +
 geom_line(color = 'red', data=emp,aes (x = hike, y = pred))

```

Since our R^2 value 0.83 which is less than 0.85, we need to go for transformations.

### Exponential model

```{r}
plot(emp$hike,log(emp$churn))
```

```{r}
model2 <- lm(log(emp$churn) ~ emp$hike)
summary(model2)

```

Since R^2 value 0.87 is greater than 0.85, let’s stop building the model.

```{r}
log_dt <- predict(model2,interval="confidence")
log_dt

```

```{r}
dt <- exp(log_dt)
dt

```


```{r}
err2 <- emp$churn - dt
err2

```

```{r}
rmse <- sqrt(mean(err2^2))
rmse

```


So, we can conclude that our predicted values are 4.68 points deviated from actual values.

### Conclusion:- 

  - R^2 with linear model is 0.83
  - R^2 with Exponential model is 0.87