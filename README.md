- <a href="#machine-learning-in-r" id="toc-machine-learning-in-r">Machine Learning in R</a>
  - <a href="#setup" id="toc-setup">Setup</a>
  - <a href="#git" id="toc-git">Git</a>
  - <a href="#docker" id="toc-docker">Docker</a>
  - <a href="#code" id="toc-code">Code</a>
  - <a href="#workshop-plan" id="toc-workshop-plan">Workshop Plan</a>
    - <a href="#preparing-data-for-the-modeling-process"
      id="toc-preparing-data-for-the-modeling-process">Preparing Data for the Modeling Process</a>
    - <a href="#eda-and-feature-engineering"
      id="toc-eda-and-feature-engineering">EDA and Feature Engineering</a>
    - <a href="#model-fitting-and-parameter-tuning"
      id="toc-model-fitting-and-parameter-tuning">Model Fitting and Parameter Tuning</a>
    - <a href="#deploying-the-model-into-production"
      id="toc-deploying-the-model-into-production">Deploying the Model into Production</a>

<!-- README.md is generated from README.Rmd. Please edit that file -->

# Machine Learning in R

<!-- badges: start -->

<!-- badges: end -->

Thanks for attending my sessions at [ODSC East 2023](https://odsc.com/boston/). This repo will hold code we write in [Machine Learning in R](https://odsc.com/speakers/machine-learning-in-r-part-i-ii/) workshop.

## Setup

For this course you need a recent version of R. Anything greater than 4.0 is good but 4.2 is even better. I also highly recommend using your IDE/code editor of choice. Most people use either [RStudio](https://www.rstudio.com/products/rstudio/) or [VS Code](https://code.visualstudio.com/) with [R Language Extensions](https://code.visualstudio.com/docs/languages/r).

After you have R and your favorite editor installed, you should install the packages needed today with the following line of code.

<pre class='chroma'>
<span><span class='nf'><a href='https://rdrr.io/r/utils/install.packages.html'>install.packages</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span></span>
<span>  <span class='s'>'here'</span>, <span class='s'>'markdown'</span>, <span class='s'>'rmarkdown'</span>, <span class='s'>'knitr'</span>, <span class='s'>'tidyverse'</span>, <span class='s'>'ggthemes'</span>, <span class='s'>'ggridges'</span>, </span>
<span>  <span class='s'>'tidymodels'</span>, <span class='s'>'coefplot'</span>, <span class='s'>'glmnet'</span>, <span class='s'>'xgboost'</span>, <span class='s'>'vip'</span>, <span class='s'>'DiagrammeR'</span>, <span class='s'>'here'</span>, </span>
<span>  <span class='s'>'DBI'</span>, <span class='s'>'themis'</span>, <span class='s'>'vetiver'</span>, <span class='s'>'fable'</span>, <span class='s'>'tsibble'</span>, <span class='s'>'echarts4r'</span>, <span class='s'>'leaflet'</span>, </span>
<span>  <span class='s'>'leafgl'</span>, <span class='s'>'leafem'</span></span>
<span><span class='o'>)</span><span class='o'>)</span></span></pre>

## Git

If you are comfortable with git, you can clone this repo and have the project structure.

``` sh
git clone https://github.com/jaredlander/odsceast2023.git
```

## Docker

If you are having trouble installing R or the packages, but are comfortable with Docker, you can pull the Docker image using the following command in your terminal.

``` sh
docker pull jaredlander/odsceast2023:4.2.3
```

You can run the container with the following command which will also mount a folder as a volume for you to use.

``` sh
docker run -it --rm --name rstudio_ml -e PASSWORD=password -e ROOT=true -p 8787:8787 -v $PWD/workshop:/home/rstudio/workshop  jaredlander/odsceast2023:4.2.3
```

## Code

Throughout the class I will be pushing code to this repo in case you need to catch up. Most, if not all, will be in the `code` folder.

## Workshop Plan

Modern statistics has become almost synonymous with machine learning, a collection of techniques that utilize today’s incredible computing power. A combination of supervised learning (regression-like models) and unsupervised learning (clustering), the field is supported by theory, yet relies upon intelligent programming for implementation.

In this training session we will work through the entire process of training a machine learning model in R. Starting with the scaffolding of cross-validation, onto exploratory data analysis, feature engineering, model specification, parameter tuning and model selection. We then take the finished model and deploy it as an API in a Docker container for production use.

We will make extensive use the [tidymodels](https://tidymodels.tidymodels.org) framework of R packages.

### Preparing Data for the Modeling Process

The first step in a modeling project is setting up the evaluation loop in order to properly define a model’s performance. To accomplish this we will learn the following tasks:

1.  Load Data
2.  Create train and test sets from the data using the [rsample](https://rsample.tidymodels.org) package
3.  Create cross-validation set from the train set using the [rsample](https://rsample.tidymodels.org) package
4.  Define model evaluation metrics such as RMSE and logloss using the [yardstick](https://github.com/tidymodels/yardstick) package

### EDA and Feature Engineering

Before we can fit a model we must first understand the model by performing exploratory data analysis. After that we prepare the data through feature engineering, also called preprocessing and data munging. The primary steps we will learn include:

1.  Perform summary EDA with [dplyr](https://dplyr.tidyverse.org)
2.  Visualize the data with [ggplot2](https://ggplot2.tidyverse.org)
3.  Balance the data with the [themis](https://github.com/tidymodels/themis) package
4.  Impute or otherwise mark missing data with the [recipes](https://github.com/tidymodels/recipes) package
5.  Perform data transformations with the [recipes](https://github.com/tidymodels/recipes) package
    1.  Numeric centering and scaling
    2.  Collapse noisy categorical data
    3.  Handle new categorical values
    4.  Convert categorical data into dummy (or indicator) variables

### Model Fitting and Parameter Tuning

Now we can begin fitting models. This involves defining the type of model, such as a penalized regression, random forest or boosted tree. This has been simplified thanks to the parsnip and workflows packages. Modern machine learning has essentially become an excercise in brute-forcing over tuning parameters, which we will do by combining the dials and tune package with the previously created cross-validation set.

1.  Define the model structure with the [parsnip](https://github.com/tidymodels/parsnip) package
2.  Set tuning parameter candidates with the [dials](https://dials.tidymodels.org) package
3.  Iterate over the tuning parameter candidates using the [tune](https://tune.tidymodels.org/) package to perform cross-validation
4.  Identify the best model fit with the [yardstick](https://github.com/tidymodels/yardstick) package

### Deploying the Model into Production

After we build various machine learning models we need to make them accessible to others. We use the plumber package to expose our model as a REST API that can be hosted in a Docker container.

1.  Make predictions using the [workflows](https://github.com/tidymodels/workflows) package
2.  Convert the model to an API using the [plumber](https://www.rplumber.io) package
3.  Bundle the model object and API code into a Docker container
4.  Serve that container and use curl to make perform predictions
