
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Text Analysis R Package

<!-- badges: start -->
<!-- badges: end -->

# Description

## Objective

Text analysis techniques such as Natural Language Processing (NLP) can
swiftly extract relevant information from different corpus datasets such
as documents, emails, SMS messages, social media and other textual
resources. NLP encompasses some common techniques for analyzing human
language such as tokenization, stemming and lemmatization, sentiment
analysis and text classification.

The goal of this R package “textAnalysisR” is to provide a series of
functions that allows a user to analyze a text dataset using some common
Natural Language Processing techniques, train some models and evaluate
their performance.

## Overview

In this package, we analyze the text dataset as follows:

1.  Load Data from text files
2.  Install necessary packages  
3.  Explore the text dataset  
4.  Visualizing the corpus with word clouds
5.  Data Preprocessing: Standardization and cleaning  

- Convert to lower case  
- Remove punctuations and numbers
- Remove extra white space  
- Remove stop words

6.  Data partitioning: Creating training and testing datasets  
7.  Training a classifier on the data and evaluating model
    performance:  

- Naïve Bayes
- Logistic Regression
- Support Vector Machines (kernel= radial and linear)
- Random Forest.  

6.  Comparing results: Evaluate the model performance and compare them

# Usage

## Programming Language

This package uses R as the main programming langauge and C++ for some
scripts to impove speed of the package.

## Installation

You can install the development version of textAnalysisR as follows:

``` r
#install.package("textAnalysisR")
```

Also, to get started on using this repository, type the following into
your favorite git command line tool:

``` r
#git clone git@github.com:shaveen27/textAnalysisR.git
```

The previous command will download all of the code onto your computer.
You will also need to download the data in study. You can find this in
the *data* folder.

# Demo

There is a *tutorial* script to show how to use this package. We use the
following dataset:

## Dataset

The SMS Spam Collection is a public set of SMS labeled messages that
have been collected for mobile phone spam research.

- SMS Spam Collection:
  <https://archive.ics.uci.edu/dataset/228/sms+spam+collection>

## Tutorial

This tutorial shows an example on how to use this package. It uses the
dataset above and explore the different classifier mentioned in the
description. You cna find this tutorial under the name
**textAnalysis_tutorial**.

### Information

- The code in this repository was written by Aloka Dayarathne, Maha
  Moussa, Shaveen Britto, and Teresa White.