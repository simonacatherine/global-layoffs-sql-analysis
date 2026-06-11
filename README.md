# Global Layoffs Data Cleaning & Exploratory Analysis

## Project Overview

This project focuses on cleaning and analyzing a real-world global layoffs dataset using SQL (MySQL). The dataset was cleaned to improve consistency and accuracy, followed by exploratory data analysis to identify layoff trends across companies, industries, countries, funding stages, and time periods.

## Tech Stack

* SQL (MySQL)

## Objectives

* Clean and standardize raw layoff data
* Handle duplicates, null values, and inconsistent records
* Transform and validate date formats for analysis
* Perform exploratory analysis to identify layoff trends and workforce reduction patterns

## Data Cleaning Process

* Removed duplicate records using `ROW_NUMBER()` and window functions
* Standardized inconsistent values in industry, country, and company fields
* Handled null and blank values through updates and joins
* Converted date columns from text format to SQL date datatype
* Removed unnecessary records with missing layoff information

## Exploratory Analysis Performed

* Company-wise layoffs analysis
* Industry-wise layoffs trends
* Yearly layoff analysis
* Stage-wise layoffs comparison
* Monthly layoff trends and rolling totals
* Top companies by layoffs using ranking functions
* Analysis of companies with 100% workforce layoffs

## Key SQL Concepts Used

* CTEs (Common Table Expressions)
* Window Functions
* Self Joins
* Rolling Aggregations
* Ranking Functions
* Data Cleaning Operations

## Files Included

* `layoffs.csv` → Dataset used for analysis
* `layoff_datacleaning.sql` → SQL queries for data cleaning 
* `layoff_eda.sql` → SQL queries for exploratory analysis
  
## Dataset

Dataset sourced from Kaggle: Global Tech Layoffs Dataset (2022–Present)
https://www.kaggle.com/datasets/swaptr/layoffs-2022/data
