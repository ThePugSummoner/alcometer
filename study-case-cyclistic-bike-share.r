{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "9a5148bc",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:15.238002Z",
     "iopub.status.busy": "2024-02-22T23:00:15.236451Z",
     "iopub.status.idle": "2024-02-22T23:00:16.124680Z",
     "shell.execute_reply": "2024-02-22T23:00:16.123508Z"
    },
    "papermill": {
     "duration": 0.899847,
     "end_time": "2024-02-22T23:00:16.126508",
     "exception": false,
     "start_time": "2024-02-22T23:00:15.226661",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching core tidyverse packages\u001b[22m ──────────────────────── tidyverse 2.0.0 ──\n",
      "\u001b[32m✔\u001b[39m \u001b[34mdplyr    \u001b[39m 1.1.4     \u001b[32m✔\u001b[39m \u001b[34mreadr    \u001b[39m 2.1.4\n",
      "\u001b[32m✔\u001b[39m \u001b[34mforcats  \u001b[39m 1.0.0     \u001b[32m✔\u001b[39m \u001b[34mstringr  \u001b[39m 1.5.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2  \u001b[39m 3.4.4     \u001b[32m✔\u001b[39m \u001b[34mtibble   \u001b[39m 3.2.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mlubridate\u001b[39m 1.9.3     \u001b[32m✔\u001b[39m \u001b[34mtidyr    \u001b[39m 1.3.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mpurrr    \u001b[39m 1.0.2     \n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\u001b[36mℹ\u001b[39m Use the conflicted package (\u001b[3m\u001b[34m<http://conflicted.r-lib.org/>\u001b[39m\u001b[23m) to force all conflicts to become errors\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "'cyclistic-tripdata-2023-2024'"
      ],
      "text/latex": [
       "'cyclistic-tripdata-2023-2024'"
      ],
      "text/markdown": [
       "'cyclistic-tripdata-2023-2024'"
      ],
      "text/plain": [
       "[1] \"cyclistic-tripdata-2023-2024\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# This R environment comes with many helpful analytics packages installed\n",
    "# It is defined by the kaggle/rstats Docker image: https://github.com/kaggle/docker-rstats\n",
    "# For example, here's a helpful package to load\n",
    "\n",
    "library(tidyverse) # metapackage of all tidyverse packages\n",
    "\n",
    "# Input data files are available in the read-only \"../input/\" directory\n",
    "# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory\n",
    "\n",
    "list.files(path = \"../input\")\n",
    "\n",
    "# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using \"Save & Run All\" \n",
    "# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current session"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "f57cfa3e",
   "metadata": {
    "papermill": {
     "duration": 0.0076,
     "end_time": "2024-02-22T23:00:16.142303",
     "exception": false,
     "start_time": "2024-02-22T23:00:16.134703",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# How do annual members and casual riders use Cyclistic bikes dfferently?"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "23de49f0",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:16.182271Z",
     "iopub.status.busy": "2024-02-22T23:00:16.159244Z",
     "iopub.status.idle": "2024-02-22T23:00:16.193354Z",
     "shell.execute_reply": "2024-02-22T23:00:16.192166Z"
    },
    "papermill": {
     "duration": 0.044982,
     "end_time": "2024-02-22T23:00:16.194984",
     "exception": false,
     "start_time": "2024-02-22T23:00:16.150002",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "library(tidyverse)\n",
    "library(readr)\n",
    "library(dplyr)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "789c7970",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:16.212589Z",
     "iopub.status.busy": "2024-02-22T23:00:16.211512Z",
     "iopub.status.idle": "2024-02-22T23:00:40.046123Z",
     "shell.execute_reply": "2024-02-22T23:00:40.044757Z"
    },
    "papermill": {
     "duration": 23.846621,
     "end_time": "2024-02-22T23:00:40.049297",
     "exception": false,
     "start_time": "2024-02-22T23:00:16.202676",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1mRows: \u001b[22m\u001b[34m144873\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m13\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m224073\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m13\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m362518\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m13\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m537113\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m13\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m666371\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m13\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m771693\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m13\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m767650\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m13\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m719618\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m13\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m604827\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m13\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m426590\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m13\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m258678\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m13\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m190445\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m13\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n"
     ]
    }
   ],
   "source": [
    "tripdata_2024_01 <- read_csv(\"/kaggle/input/cyclistic-tripdata-2023-2024/202401-divvy-tripdata.csv\")\n",
    "tripdata_2023_12 <- read_csv(\"/kaggle/input/cyclistic-tripdata-2023-2024/202312-divvy-tripdata.csv\")\n",
    "tripdata_2023_11 <- read_csv(\"/kaggle/input/cyclistic-tripdata-2023-2024/202311-divvy-tripdata.csv\")\n",
    "tripdata_2023_10 <- read_csv(\"/kaggle/input/cyclistic-tripdata-2023-2024/202310-divvy-tripdata.csv\")\n",
    "tripdata_2023_09 <- read_csv(\"/kaggle/input/cyclistic-tripdata-2023-2024/202309-divvy-tripdata.csv\")\n",
    "tripdata_2023_08 <- read_csv(\"/kaggle/input/cyclistic-tripdata-2023-2024/202308-divvy-tripdata.csv\")\n",
    "tripdata_2023_07 <- read_csv(\"/kaggle/input/cyclistic-tripdata-2023-2024/202307-divvy-tripdata.csv\")\n",
    "tripdata_2023_06 <- read_csv(\"/kaggle/input/cyclistic-tripdata-2023-2024/202306-divvy-tripdata.csv\")\n",
    "tripdata_2023_05 <- read_csv(\"/kaggle/input/cyclistic-tripdata-2023-2024/202305-divvy-tripdata.csv\")\n",
    "tripdata_2023_04 <- read_csv(\"/kaggle/input/cyclistic-tripdata-2023-2024/202304-divvy-tripdata.csv\")\n",
    "tripdata_2023_03 <- read_csv(\"/kaggle/input/cyclistic-tripdata-2023-2024/202303-divvy-tripdata.csv\")\n",
    "tripdata_2023_02 <- read_csv(\"/kaggle/input/cyclistic-tripdata-2023-2024/202302-divvy-tripdata.csv\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "b4cde53b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:40.072923Z",
     "iopub.status.busy": "2024-02-22T23:00:40.071376Z",
     "iopub.status.idle": "2024-02-22T23:00:40.115471Z",
     "shell.execute_reply": "2024-02-22T23:00:40.113925Z"
    },
    "papermill": {
     "duration": 0.057954,
     "end_time": "2024-02-22T23:00:40.117347",
     "exception": false,
     "start_time": "2024-02-22T23:00:40.059393",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 13</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>ride_id</th><th scope=col>rideable_type</th><th scope=col>started_at</th><th scope=col>ended_at</th><th scope=col>start_station_name</th><th scope=col>start_station_id</th><th scope=col>end_station_name</th><th scope=col>end_station_id</th><th scope=col>start_lat</th><th scope=col>start_lng</th><th scope=col>end_lat</th><th scope=col>end_lng</th><th scope=col>member_casual</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>C1D650626C8C899A</td><td>electric_bike</td><td>2024-01-12 15:30:27</td><td>2024-01-12 15:37:59</td><td><span style=white-space:pre-wrap>Wells St &amp; Elm St         </span></td><td>KA1504000135</td><td>Kingsbury St &amp; Kinzie St </td><td>KA1503000043</td><td>41.90327</td><td>-87.63474</td><td>41.88918</td><td>-87.63851</td><td>member</td></tr>\n",
       "\t<tr><td>EECD38BDB25BFCB0</td><td>electric_bike</td><td>2024-01-08 15:45:46</td><td>2024-01-08 15:52:59</td><td><span style=white-space:pre-wrap>Wells St &amp; Elm St         </span></td><td>KA1504000135</td><td>Kingsbury St &amp; Kinzie St </td><td>KA1503000043</td><td>41.90294</td><td>-87.63444</td><td>41.88918</td><td>-87.63851</td><td>member</td></tr>\n",
       "\t<tr><td>F4A9CE78061F17F7</td><td>electric_bike</td><td>2024-01-27 12:27:19</td><td>2024-01-27 12:35:19</td><td><span style=white-space:pre-wrap>Wells St &amp; Elm St         </span></td><td>KA1504000135</td><td>Kingsbury St &amp; Kinzie St </td><td>KA1503000043</td><td>41.90295</td><td>-87.63447</td><td>41.88918</td><td>-87.63851</td><td>member</td></tr>\n",
       "\t<tr><td>0A0D9E15EE50B171</td><td>classic_bike </td><td>2024-01-29 16:26:17</td><td>2024-01-29 16:56:06</td><td><span style=white-space:pre-wrap>Wells St &amp; Randolph St    </span></td><td>TA1305000030</td><td>Larrabee St &amp; Webster Ave</td><td><span style=white-space:pre-wrap>13193       </span></td><td>41.88430</td><td>-87.63396</td><td>41.92182</td><td>-87.64414</td><td>member</td></tr>\n",
       "\t<tr><td>33FFC9805E3EFF9A</td><td>classic_bike </td><td>2024-01-31 05:43:23</td><td>2024-01-31 06:09:35</td><td>Lincoln Ave &amp; Waveland Ave</td><td><span style=white-space:pre-wrap>13253       </span></td><td>Kingsbury St &amp; Kinzie St </td><td>KA1503000043</td><td>41.94880</td><td>-87.67528</td><td>41.88918</td><td>-87.63851</td><td>member</td></tr>\n",
       "\t<tr><td>C96080812CD285C5</td><td>classic_bike </td><td>2024-01-07 11:21:24</td><td>2024-01-07 11:30:03</td><td><span style=white-space:pre-wrap>Wells St &amp; Elm St         </span></td><td>KA1504000135</td><td>Kingsbury St &amp; Kinzie St </td><td>KA1503000043</td><td>41.90322</td><td>-87.63432</td><td>41.88918</td><td>-87.63851</td><td>member</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 13\n",
       "\\begin{tabular}{lllllllllllll}\n",
       " ride\\_id & rideable\\_type & started\\_at & ended\\_at & start\\_station\\_name & start\\_station\\_id & end\\_station\\_name & end\\_station\\_id & start\\_lat & start\\_lng & end\\_lat & end\\_lng & member\\_casual\\\\\n",
       " <chr> & <chr> & <dttm> & <dttm> & <chr> & <chr> & <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t C1D650626C8C899A & electric\\_bike & 2024-01-12 15:30:27 & 2024-01-12 15:37:59 & Wells St \\& Elm St          & KA1504000135 & Kingsbury St \\& Kinzie St  & KA1503000043 & 41.90327 & -87.63474 & 41.88918 & -87.63851 & member\\\\\n",
       "\t EECD38BDB25BFCB0 & electric\\_bike & 2024-01-08 15:45:46 & 2024-01-08 15:52:59 & Wells St \\& Elm St          & KA1504000135 & Kingsbury St \\& Kinzie St  & KA1503000043 & 41.90294 & -87.63444 & 41.88918 & -87.63851 & member\\\\\n",
       "\t F4A9CE78061F17F7 & electric\\_bike & 2024-01-27 12:27:19 & 2024-01-27 12:35:19 & Wells St \\& Elm St          & KA1504000135 & Kingsbury St \\& Kinzie St  & KA1503000043 & 41.90295 & -87.63447 & 41.88918 & -87.63851 & member\\\\\n",
       "\t 0A0D9E15EE50B171 & classic\\_bike  & 2024-01-29 16:26:17 & 2024-01-29 16:56:06 & Wells St \\& Randolph St     & TA1305000030 & Larrabee St \\& Webster Ave & 13193        & 41.88430 & -87.63396 & 41.92182 & -87.64414 & member\\\\\n",
       "\t 33FFC9805E3EFF9A & classic\\_bike  & 2024-01-31 05:43:23 & 2024-01-31 06:09:35 & Lincoln Ave \\& Waveland Ave & 13253        & Kingsbury St \\& Kinzie St  & KA1503000043 & 41.94880 & -87.67528 & 41.88918 & -87.63851 & member\\\\\n",
       "\t C96080812CD285C5 & classic\\_bike  & 2024-01-07 11:21:24 & 2024-01-07 11:30:03 & Wells St \\& Elm St          & KA1504000135 & Kingsbury St \\& Kinzie St  & KA1503000043 & 41.90322 & -87.63432 & 41.88918 & -87.63851 & member\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 13\n",
       "\n",
       "| ride_id &lt;chr&gt; | rideable_type &lt;chr&gt; | started_at &lt;dttm&gt; | ended_at &lt;dttm&gt; | start_station_name &lt;chr&gt; | start_station_id &lt;chr&gt; | end_station_name &lt;chr&gt; | end_station_id &lt;chr&gt; | start_lat &lt;dbl&gt; | start_lng &lt;dbl&gt; | end_lat &lt;dbl&gt; | end_lng &lt;dbl&gt; | member_casual &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| C1D650626C8C899A | electric_bike | 2024-01-12 15:30:27 | 2024-01-12 15:37:59 | Wells St &amp; Elm St          | KA1504000135 | Kingsbury St &amp; Kinzie St  | KA1503000043 | 41.90327 | -87.63474 | 41.88918 | -87.63851 | member |\n",
       "| EECD38BDB25BFCB0 | electric_bike | 2024-01-08 15:45:46 | 2024-01-08 15:52:59 | Wells St &amp; Elm St          | KA1504000135 | Kingsbury St &amp; Kinzie St  | KA1503000043 | 41.90294 | -87.63444 | 41.88918 | -87.63851 | member |\n",
       "| F4A9CE78061F17F7 | electric_bike | 2024-01-27 12:27:19 | 2024-01-27 12:35:19 | Wells St &amp; Elm St          | KA1504000135 | Kingsbury St &amp; Kinzie St  | KA1503000043 | 41.90295 | -87.63447 | 41.88918 | -87.63851 | member |\n",
       "| 0A0D9E15EE50B171 | classic_bike  | 2024-01-29 16:26:17 | 2024-01-29 16:56:06 | Wells St &amp; Randolph St     | TA1305000030 | Larrabee St &amp; Webster Ave | 13193        | 41.88430 | -87.63396 | 41.92182 | -87.64414 | member |\n",
       "| 33FFC9805E3EFF9A | classic_bike  | 2024-01-31 05:43:23 | 2024-01-31 06:09:35 | Lincoln Ave &amp; Waveland Ave | 13253        | Kingsbury St &amp; Kinzie St  | KA1503000043 | 41.94880 | -87.67528 | 41.88918 | -87.63851 | member |\n",
       "| C96080812CD285C5 | classic_bike  | 2024-01-07 11:21:24 | 2024-01-07 11:30:03 | Wells St &amp; Elm St          | KA1504000135 | Kingsbury St &amp; Kinzie St  | KA1503000043 | 41.90322 | -87.63432 | 41.88918 | -87.63851 | member |\n",
       "\n"
      ],
      "text/plain": [
       "  ride_id          rideable_type started_at          ended_at           \n",
       "1 C1D650626C8C899A electric_bike 2024-01-12 15:30:27 2024-01-12 15:37:59\n",
       "2 EECD38BDB25BFCB0 electric_bike 2024-01-08 15:45:46 2024-01-08 15:52:59\n",
       "3 F4A9CE78061F17F7 electric_bike 2024-01-27 12:27:19 2024-01-27 12:35:19\n",
       "4 0A0D9E15EE50B171 classic_bike  2024-01-29 16:26:17 2024-01-29 16:56:06\n",
       "5 33FFC9805E3EFF9A classic_bike  2024-01-31 05:43:23 2024-01-31 06:09:35\n",
       "6 C96080812CD285C5 classic_bike  2024-01-07 11:21:24 2024-01-07 11:30:03\n",
       "  start_station_name         start_station_id end_station_name         \n",
       "1 Wells St & Elm St          KA1504000135     Kingsbury St & Kinzie St \n",
       "2 Wells St & Elm St          KA1504000135     Kingsbury St & Kinzie St \n",
       "3 Wells St & Elm St          KA1504000135     Kingsbury St & Kinzie St \n",
       "4 Wells St & Randolph St     TA1305000030     Larrabee St & Webster Ave\n",
       "5 Lincoln Ave & Waveland Ave 13253            Kingsbury St & Kinzie St \n",
       "6 Wells St & Elm St          KA1504000135     Kingsbury St & Kinzie St \n",
       "  end_station_id start_lat start_lng end_lat  end_lng   member_casual\n",
       "1 KA1503000043   41.90327  -87.63474 41.88918 -87.63851 member       \n",
       "2 KA1503000043   41.90294  -87.63444 41.88918 -87.63851 member       \n",
       "3 KA1503000043   41.90295  -87.63447 41.88918 -87.63851 member       \n",
       "4 13193          41.88430  -87.63396 41.92182 -87.64414 member       \n",
       "5 KA1503000043   41.94880  -87.67528 41.88918 -87.63851 member       \n",
       "6 KA1503000043   41.90322  -87.63432 41.88918 -87.63851 member       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(tripdata_2024_01)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "5ee8ae3e",
   "metadata": {
    "papermill": {
     "duration": 0.009403,
     "end_time": "2024-02-22T23:00:40.136393",
     "exception": false,
     "start_time": "2024-02-22T23:00:40.126990",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## STEP 2: WRANGLE DATA AND COMBINE INTO A SINGLE FILE\n",
    "\n",
    "#### Compare column names each of the files. Inspect the dataframes and look for incongruencies.\n",
    "\n",
    "#### While the column names in the same order we can use a command to join them into one file."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "a36ae43b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:40.158634Z",
     "iopub.status.busy": "2024-02-22T23:00:40.157096Z",
     "iopub.status.idle": "2024-02-22T23:00:40.172361Z",
     "shell.execute_reply": "2024-02-22T23:00:40.171035Z"
    },
    "papermill": {
     "duration": 0.029551,
     "end_time": "2024-02-22T23:00:40.175204",
     "exception": false,
     "start_time": "2024-02-22T23:00:40.145653",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'start_lat'\n",
       "10. 'start_lng'\n",
       "11. 'end_lat'\n",
       "12. 'end_lng'\n",
       "13. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       " [4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       " [7] \"end_station_name\"   \"end_station_id\"     \"start_lat\"         \n",
       "[10] \"start_lng\"          \"end_lat\"            \"end_lng\"           \n",
       "[13] \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "colnames(tripdata_2023_02)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "c310134f",
   "metadata": {
    "papermill": {
     "duration": 0.009817,
     "end_time": "2024-02-22T23:00:40.194883",
     "exception": false,
     "start_time": "2024-02-22T23:00:40.185066",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### ..."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "5677d40b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:40.218067Z",
     "iopub.status.busy": "2024-02-22T23:00:40.216291Z",
     "iopub.status.idle": "2024-02-22T23:00:40.234721Z",
     "shell.execute_reply": "2024-02-22T23:00:40.232531Z"
    },
    "papermill": {
     "duration": 0.033096,
     "end_time": "2024-02-22T23:00:40.237575",
     "exception": false,
     "start_time": "2024-02-22T23:00:40.204479",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'start_lat'\n",
       "10. 'start_lng'\n",
       "11. 'end_lat'\n",
       "12. 'end_lng'\n",
       "13. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       " [4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       " [7] \"end_station_name\"   \"end_station_id\"     \"start_lat\"         \n",
       "[10] \"start_lng\"          \"end_lat\"            \"end_lng\"           \n",
       "[13] \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "colnames(tripdata_2024_01)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "b9d61463",
   "metadata": {
    "papermill": {
     "duration": 0.010347,
     "end_time": "2024-02-22T23:00:40.258442",
     "exception": false,
     "start_time": "2024-02-22T23:00:40.248095",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Stack individual monthly data frames into one big data frame."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "16009cb7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:40.282042Z",
     "iopub.status.busy": "2024-02-22T23:00:40.280567Z",
     "iopub.status.idle": "2024-02-22T23:00:50.977052Z",
     "shell.execute_reply": "2024-02-22T23:00:50.975075Z"
    },
    "papermill": {
     "duration": 10.711082,
     "end_time": "2024-02-22T23:00:50.979550",
     "exception": false,
     "start_time": "2024-02-22T23:00:40.268468",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 13</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>ride_id</th><th scope=col>rideable_type</th><th scope=col>started_at</th><th scope=col>ended_at</th><th scope=col>start_station_name</th><th scope=col>start_station_id</th><th scope=col>end_station_name</th><th scope=col>end_station_id</th><th scope=col>start_lat</th><th scope=col>start_lng</th><th scope=col>end_lat</th><th scope=col>end_lng</th><th scope=col>member_casual</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>C1D650626C8C899A</td><td>electric_bike</td><td>2024-01-12 15:30:27</td><td>2024-01-12 15:37:59</td><td><span style=white-space:pre-wrap>Wells St &amp; Elm St         </span></td><td>KA1504000135</td><td>Kingsbury St &amp; Kinzie St </td><td>KA1503000043</td><td>41.90327</td><td>-87.63474</td><td>41.88918</td><td>-87.63851</td><td>member</td></tr>\n",
       "\t<tr><td>EECD38BDB25BFCB0</td><td>electric_bike</td><td>2024-01-08 15:45:46</td><td>2024-01-08 15:52:59</td><td><span style=white-space:pre-wrap>Wells St &amp; Elm St         </span></td><td>KA1504000135</td><td>Kingsbury St &amp; Kinzie St </td><td>KA1503000043</td><td>41.90294</td><td>-87.63444</td><td>41.88918</td><td>-87.63851</td><td>member</td></tr>\n",
       "\t<tr><td>F4A9CE78061F17F7</td><td>electric_bike</td><td>2024-01-27 12:27:19</td><td>2024-01-27 12:35:19</td><td><span style=white-space:pre-wrap>Wells St &amp; Elm St         </span></td><td>KA1504000135</td><td>Kingsbury St &amp; Kinzie St </td><td>KA1503000043</td><td>41.90295</td><td>-87.63447</td><td>41.88918</td><td>-87.63851</td><td>member</td></tr>\n",
       "\t<tr><td>0A0D9E15EE50B171</td><td>classic_bike </td><td>2024-01-29 16:26:17</td><td>2024-01-29 16:56:06</td><td><span style=white-space:pre-wrap>Wells St &amp; Randolph St    </span></td><td>TA1305000030</td><td>Larrabee St &amp; Webster Ave</td><td><span style=white-space:pre-wrap>13193       </span></td><td>41.88430</td><td>-87.63396</td><td>41.92182</td><td>-87.64414</td><td>member</td></tr>\n",
       "\t<tr><td>33FFC9805E3EFF9A</td><td>classic_bike </td><td>2024-01-31 05:43:23</td><td>2024-01-31 06:09:35</td><td>Lincoln Ave &amp; Waveland Ave</td><td><span style=white-space:pre-wrap>13253       </span></td><td>Kingsbury St &amp; Kinzie St </td><td>KA1503000043</td><td>41.94880</td><td>-87.67528</td><td>41.88918</td><td>-87.63851</td><td>member</td></tr>\n",
       "\t<tr><td>C96080812CD285C5</td><td>classic_bike </td><td>2024-01-07 11:21:24</td><td>2024-01-07 11:30:03</td><td><span style=white-space:pre-wrap>Wells St &amp; Elm St         </span></td><td>KA1504000135</td><td>Kingsbury St &amp; Kinzie St </td><td>KA1503000043</td><td>41.90322</td><td>-87.63432</td><td>41.88918</td><td>-87.63851</td><td>member</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 13\n",
       "\\begin{tabular}{lllllllllllll}\n",
       " ride\\_id & rideable\\_type & started\\_at & ended\\_at & start\\_station\\_name & start\\_station\\_id & end\\_station\\_name & end\\_station\\_id & start\\_lat & start\\_lng & end\\_lat & end\\_lng & member\\_casual\\\\\n",
       " <chr> & <chr> & <dttm> & <dttm> & <chr> & <chr> & <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t C1D650626C8C899A & electric\\_bike & 2024-01-12 15:30:27 & 2024-01-12 15:37:59 & Wells St \\& Elm St          & KA1504000135 & Kingsbury St \\& Kinzie St  & KA1503000043 & 41.90327 & -87.63474 & 41.88918 & -87.63851 & member\\\\\n",
       "\t EECD38BDB25BFCB0 & electric\\_bike & 2024-01-08 15:45:46 & 2024-01-08 15:52:59 & Wells St \\& Elm St          & KA1504000135 & Kingsbury St \\& Kinzie St  & KA1503000043 & 41.90294 & -87.63444 & 41.88918 & -87.63851 & member\\\\\n",
       "\t F4A9CE78061F17F7 & electric\\_bike & 2024-01-27 12:27:19 & 2024-01-27 12:35:19 & Wells St \\& Elm St          & KA1504000135 & Kingsbury St \\& Kinzie St  & KA1503000043 & 41.90295 & -87.63447 & 41.88918 & -87.63851 & member\\\\\n",
       "\t 0A0D9E15EE50B171 & classic\\_bike  & 2024-01-29 16:26:17 & 2024-01-29 16:56:06 & Wells St \\& Randolph St     & TA1305000030 & Larrabee St \\& Webster Ave & 13193        & 41.88430 & -87.63396 & 41.92182 & -87.64414 & member\\\\\n",
       "\t 33FFC9805E3EFF9A & classic\\_bike  & 2024-01-31 05:43:23 & 2024-01-31 06:09:35 & Lincoln Ave \\& Waveland Ave & 13253        & Kingsbury St \\& Kinzie St  & KA1503000043 & 41.94880 & -87.67528 & 41.88918 & -87.63851 & member\\\\\n",
       "\t C96080812CD285C5 & classic\\_bike  & 2024-01-07 11:21:24 & 2024-01-07 11:30:03 & Wells St \\& Elm St          & KA1504000135 & Kingsbury St \\& Kinzie St  & KA1503000043 & 41.90322 & -87.63432 & 41.88918 & -87.63851 & member\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 13\n",
       "\n",
       "| ride_id &lt;chr&gt; | rideable_type &lt;chr&gt; | started_at &lt;dttm&gt; | ended_at &lt;dttm&gt; | start_station_name &lt;chr&gt; | start_station_id &lt;chr&gt; | end_station_name &lt;chr&gt; | end_station_id &lt;chr&gt; | start_lat &lt;dbl&gt; | start_lng &lt;dbl&gt; | end_lat &lt;dbl&gt; | end_lng &lt;dbl&gt; | member_casual &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| C1D650626C8C899A | electric_bike | 2024-01-12 15:30:27 | 2024-01-12 15:37:59 | Wells St &amp; Elm St          | KA1504000135 | Kingsbury St &amp; Kinzie St  | KA1503000043 | 41.90327 | -87.63474 | 41.88918 | -87.63851 | member |\n",
       "| EECD38BDB25BFCB0 | electric_bike | 2024-01-08 15:45:46 | 2024-01-08 15:52:59 | Wells St &amp; Elm St          | KA1504000135 | Kingsbury St &amp; Kinzie St  | KA1503000043 | 41.90294 | -87.63444 | 41.88918 | -87.63851 | member |\n",
       "| F4A9CE78061F17F7 | electric_bike | 2024-01-27 12:27:19 | 2024-01-27 12:35:19 | Wells St &amp; Elm St          | KA1504000135 | Kingsbury St &amp; Kinzie St  | KA1503000043 | 41.90295 | -87.63447 | 41.88918 | -87.63851 | member |\n",
       "| 0A0D9E15EE50B171 | classic_bike  | 2024-01-29 16:26:17 | 2024-01-29 16:56:06 | Wells St &amp; Randolph St     | TA1305000030 | Larrabee St &amp; Webster Ave | 13193        | 41.88430 | -87.63396 | 41.92182 | -87.64414 | member |\n",
       "| 33FFC9805E3EFF9A | classic_bike  | 2024-01-31 05:43:23 | 2024-01-31 06:09:35 | Lincoln Ave &amp; Waveland Ave | 13253        | Kingsbury St &amp; Kinzie St  | KA1503000043 | 41.94880 | -87.67528 | 41.88918 | -87.63851 | member |\n",
       "| C96080812CD285C5 | classic_bike  | 2024-01-07 11:21:24 | 2024-01-07 11:30:03 | Wells St &amp; Elm St          | KA1504000135 | Kingsbury St &amp; Kinzie St  | KA1503000043 | 41.90322 | -87.63432 | 41.88918 | -87.63851 | member |\n",
       "\n"
      ],
      "text/plain": [
       "  ride_id          rideable_type started_at          ended_at           \n",
       "1 C1D650626C8C899A electric_bike 2024-01-12 15:30:27 2024-01-12 15:37:59\n",
       "2 EECD38BDB25BFCB0 electric_bike 2024-01-08 15:45:46 2024-01-08 15:52:59\n",
       "3 F4A9CE78061F17F7 electric_bike 2024-01-27 12:27:19 2024-01-27 12:35:19\n",
       "4 0A0D9E15EE50B171 classic_bike  2024-01-29 16:26:17 2024-01-29 16:56:06\n",
       "5 33FFC9805E3EFF9A classic_bike  2024-01-31 05:43:23 2024-01-31 06:09:35\n",
       "6 C96080812CD285C5 classic_bike  2024-01-07 11:21:24 2024-01-07 11:30:03\n",
       "  start_station_name         start_station_id end_station_name         \n",
       "1 Wells St & Elm St          KA1504000135     Kingsbury St & Kinzie St \n",
       "2 Wells St & Elm St          KA1504000135     Kingsbury St & Kinzie St \n",
       "3 Wells St & Elm St          KA1504000135     Kingsbury St & Kinzie St \n",
       "4 Wells St & Randolph St     TA1305000030     Larrabee St & Webster Ave\n",
       "5 Lincoln Ave & Waveland Ave 13253            Kingsbury St & Kinzie St \n",
       "6 Wells St & Elm St          KA1504000135     Kingsbury St & Kinzie St \n",
       "  end_station_id start_lat start_lng end_lat  end_lng   member_casual\n",
       "1 KA1503000043   41.90327  -87.63474 41.88918 -87.63851 member       \n",
       "2 KA1503000043   41.90294  -87.63444 41.88918 -87.63851 member       \n",
       "3 KA1503000043   41.90295  -87.63447 41.88918 -87.63851 member       \n",
       "4 13193          41.88430  -87.63396 41.92182 -87.64414 member       \n",
       "5 KA1503000043   41.94880  -87.67528 41.88918 -87.63851 member       \n",
       "6 KA1503000043   41.90322  -87.63432 41.88918 -87.63851 member       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "all_trips <- rbind(tripdata_2024_01, tripdata_2023_12, tripdata_2023_11, tripdata_2023_10, tripdata_2023_09, tripdata_2023_08, tripdata_2023_07,\n",
    "                   tripdata_2023_06, tripdata_2023_05, tripdata_2023_04, tripdata_2023_03, tripdata_2023_02)\n",
    "head(all_trips)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "be508bb5",
   "metadata": {
    "papermill": {
     "duration": 0.010125,
     "end_time": "2024-02-22T23:00:51.000121",
     "exception": false,
     "start_time": "2024-02-22T23:00:50.989996",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# STEP 3: CLEAN UP AND ADD DATA TO PREPARE FOR ANALYSIS\n",
    "\n",
    "#### List of column names"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "32e47355",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:51.023467Z",
     "iopub.status.busy": "2024-02-22T23:00:51.022296Z",
     "iopub.status.idle": "2024-02-22T23:00:51.037305Z",
     "shell.execute_reply": "2024-02-22T23:00:51.035532Z"
    },
    "papermill": {
     "duration": 0.029191,
     "end_time": "2024-02-22T23:00:51.039502",
     "exception": false,
     "start_time": "2024-02-22T23:00:51.010311",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'start_lat'\n",
       "10. 'start_lng'\n",
       "11. 'end_lat'\n",
       "12. 'end_lng'\n",
       "13. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       " [4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       " [7] \"end_station_name\"   \"end_station_id\"     \"start_lat\"         \n",
       "[10] \"start_lng\"          \"end_lat\"            \"end_lng\"           \n",
       "[13] \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "colnames(all_trips) "
   ]
  },
  {
   "cell_type": "markdown",
   "id": "548ee523",
   "metadata": {
    "papermill": {
     "duration": 0.010319,
     "end_time": "2024-02-22T23:00:51.060230",
     "exception": false,
     "start_time": "2024-02-22T23:00:51.049911",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Numbers of rows in data frame"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "844fc208",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:51.083659Z",
     "iopub.status.busy": "2024-02-22T23:00:51.082386Z",
     "iopub.status.idle": "2024-02-22T23:00:51.097440Z",
     "shell.execute_reply": "2024-02-22T23:00:51.095602Z"
    },
    "papermill": {
     "duration": 0.029287,
     "end_time": "2024-02-22T23:00:51.099660",
     "exception": false,
     "start_time": "2024-02-22T23:00:51.070373",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "5674449"
      ],
      "text/latex": [
       "5674449"
      ],
      "text/markdown": [
       "5674449"
      ],
      "text/plain": [
       "[1] 5674449"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "nrow(all_trips)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "876c0e6c",
   "metadata": {
    "papermill": {
     "duration": 0.010393,
     "end_time": "2024-02-22T23:00:51.120552",
     "exception": false,
     "start_time": "2024-02-22T23:00:51.110159",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Dimesnions of the data frame"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "10ac66d7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:51.143887Z",
     "iopub.status.busy": "2024-02-22T23:00:51.142692Z",
     "iopub.status.idle": "2024-02-22T23:00:51.156216Z",
     "shell.execute_reply": "2024-02-22T23:00:51.154971Z"
    },
    "papermill": {
     "duration": 0.027223,
     "end_time": "2024-02-22T23:00:51.158057",
     "exception": false,
     "start_time": "2024-02-22T23:00:51.130834",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>5674449</li><li>13</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 5674449\n",
       "\\item 13\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 5674449\n",
       "2. 13\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 5674449      13"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "dim(all_trips)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "05eb0160",
   "metadata": {
    "papermill": {
     "duration": 0.010367,
     "end_time": "2024-02-22T23:00:51.179100",
     "exception": false,
     "start_time": "2024-02-22T23:00:51.168733",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### First 6 rows of data frame"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "b209003b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:51.202582Z",
     "iopub.status.busy": "2024-02-22T23:00:51.201367Z",
     "iopub.status.idle": "2024-02-22T23:00:51.233641Z",
     "shell.execute_reply": "2024-02-22T23:00:51.232393Z"
    },
    "papermill": {
     "duration": 0.046012,
     "end_time": "2024-02-22T23:00:51.235370",
     "exception": false,
     "start_time": "2024-02-22T23:00:51.189358",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 13</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>ride_id</th><th scope=col>rideable_type</th><th scope=col>started_at</th><th scope=col>ended_at</th><th scope=col>start_station_name</th><th scope=col>start_station_id</th><th scope=col>end_station_name</th><th scope=col>end_station_id</th><th scope=col>start_lat</th><th scope=col>start_lng</th><th scope=col>end_lat</th><th scope=col>end_lng</th><th scope=col>member_casual</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>C1D650626C8C899A</td><td>electric_bike</td><td>2024-01-12 15:30:27</td><td>2024-01-12 15:37:59</td><td><span style=white-space:pre-wrap>Wells St &amp; Elm St         </span></td><td>KA1504000135</td><td>Kingsbury St &amp; Kinzie St </td><td>KA1503000043</td><td>41.90327</td><td>-87.63474</td><td>41.88918</td><td>-87.63851</td><td>member</td></tr>\n",
       "\t<tr><td>EECD38BDB25BFCB0</td><td>electric_bike</td><td>2024-01-08 15:45:46</td><td>2024-01-08 15:52:59</td><td><span style=white-space:pre-wrap>Wells St &amp; Elm St         </span></td><td>KA1504000135</td><td>Kingsbury St &amp; Kinzie St </td><td>KA1503000043</td><td>41.90294</td><td>-87.63444</td><td>41.88918</td><td>-87.63851</td><td>member</td></tr>\n",
       "\t<tr><td>F4A9CE78061F17F7</td><td>electric_bike</td><td>2024-01-27 12:27:19</td><td>2024-01-27 12:35:19</td><td><span style=white-space:pre-wrap>Wells St &amp; Elm St         </span></td><td>KA1504000135</td><td>Kingsbury St &amp; Kinzie St </td><td>KA1503000043</td><td>41.90295</td><td>-87.63447</td><td>41.88918</td><td>-87.63851</td><td>member</td></tr>\n",
       "\t<tr><td>0A0D9E15EE50B171</td><td>classic_bike </td><td>2024-01-29 16:26:17</td><td>2024-01-29 16:56:06</td><td><span style=white-space:pre-wrap>Wells St &amp; Randolph St    </span></td><td>TA1305000030</td><td>Larrabee St &amp; Webster Ave</td><td><span style=white-space:pre-wrap>13193       </span></td><td>41.88430</td><td>-87.63396</td><td>41.92182</td><td>-87.64414</td><td>member</td></tr>\n",
       "\t<tr><td>33FFC9805E3EFF9A</td><td>classic_bike </td><td>2024-01-31 05:43:23</td><td>2024-01-31 06:09:35</td><td>Lincoln Ave &amp; Waveland Ave</td><td><span style=white-space:pre-wrap>13253       </span></td><td>Kingsbury St &amp; Kinzie St </td><td>KA1503000043</td><td>41.94880</td><td>-87.67528</td><td>41.88918</td><td>-87.63851</td><td>member</td></tr>\n",
       "\t<tr><td>C96080812CD285C5</td><td>classic_bike </td><td>2024-01-07 11:21:24</td><td>2024-01-07 11:30:03</td><td><span style=white-space:pre-wrap>Wells St &amp; Elm St         </span></td><td>KA1504000135</td><td>Kingsbury St &amp; Kinzie St </td><td>KA1503000043</td><td>41.90322</td><td>-87.63432</td><td>41.88918</td><td>-87.63851</td><td>member</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 13\n",
       "\\begin{tabular}{lllllllllllll}\n",
       " ride\\_id & rideable\\_type & started\\_at & ended\\_at & start\\_station\\_name & start\\_station\\_id & end\\_station\\_name & end\\_station\\_id & start\\_lat & start\\_lng & end\\_lat & end\\_lng & member\\_casual\\\\\n",
       " <chr> & <chr> & <dttm> & <dttm> & <chr> & <chr> & <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t C1D650626C8C899A & electric\\_bike & 2024-01-12 15:30:27 & 2024-01-12 15:37:59 & Wells St \\& Elm St          & KA1504000135 & Kingsbury St \\& Kinzie St  & KA1503000043 & 41.90327 & -87.63474 & 41.88918 & -87.63851 & member\\\\\n",
       "\t EECD38BDB25BFCB0 & electric\\_bike & 2024-01-08 15:45:46 & 2024-01-08 15:52:59 & Wells St \\& Elm St          & KA1504000135 & Kingsbury St \\& Kinzie St  & KA1503000043 & 41.90294 & -87.63444 & 41.88918 & -87.63851 & member\\\\\n",
       "\t F4A9CE78061F17F7 & electric\\_bike & 2024-01-27 12:27:19 & 2024-01-27 12:35:19 & Wells St \\& Elm St          & KA1504000135 & Kingsbury St \\& Kinzie St  & KA1503000043 & 41.90295 & -87.63447 & 41.88918 & -87.63851 & member\\\\\n",
       "\t 0A0D9E15EE50B171 & classic\\_bike  & 2024-01-29 16:26:17 & 2024-01-29 16:56:06 & Wells St \\& Randolph St     & TA1305000030 & Larrabee St \\& Webster Ave & 13193        & 41.88430 & -87.63396 & 41.92182 & -87.64414 & member\\\\\n",
       "\t 33FFC9805E3EFF9A & classic\\_bike  & 2024-01-31 05:43:23 & 2024-01-31 06:09:35 & Lincoln Ave \\& Waveland Ave & 13253        & Kingsbury St \\& Kinzie St  & KA1503000043 & 41.94880 & -87.67528 & 41.88918 & -87.63851 & member\\\\\n",
       "\t C96080812CD285C5 & classic\\_bike  & 2024-01-07 11:21:24 & 2024-01-07 11:30:03 & Wells St \\& Elm St          & KA1504000135 & Kingsbury St \\& Kinzie St  & KA1503000043 & 41.90322 & -87.63432 & 41.88918 & -87.63851 & member\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 13\n",
       "\n",
       "| ride_id &lt;chr&gt; | rideable_type &lt;chr&gt; | started_at &lt;dttm&gt; | ended_at &lt;dttm&gt; | start_station_name &lt;chr&gt; | start_station_id &lt;chr&gt; | end_station_name &lt;chr&gt; | end_station_id &lt;chr&gt; | start_lat &lt;dbl&gt; | start_lng &lt;dbl&gt; | end_lat &lt;dbl&gt; | end_lng &lt;dbl&gt; | member_casual &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| C1D650626C8C899A | electric_bike | 2024-01-12 15:30:27 | 2024-01-12 15:37:59 | Wells St &amp; Elm St          | KA1504000135 | Kingsbury St &amp; Kinzie St  | KA1503000043 | 41.90327 | -87.63474 | 41.88918 | -87.63851 | member |\n",
       "| EECD38BDB25BFCB0 | electric_bike | 2024-01-08 15:45:46 | 2024-01-08 15:52:59 | Wells St &amp; Elm St          | KA1504000135 | Kingsbury St &amp; Kinzie St  | KA1503000043 | 41.90294 | -87.63444 | 41.88918 | -87.63851 | member |\n",
       "| F4A9CE78061F17F7 | electric_bike | 2024-01-27 12:27:19 | 2024-01-27 12:35:19 | Wells St &amp; Elm St          | KA1504000135 | Kingsbury St &amp; Kinzie St  | KA1503000043 | 41.90295 | -87.63447 | 41.88918 | -87.63851 | member |\n",
       "| 0A0D9E15EE50B171 | classic_bike  | 2024-01-29 16:26:17 | 2024-01-29 16:56:06 | Wells St &amp; Randolph St     | TA1305000030 | Larrabee St &amp; Webster Ave | 13193        | 41.88430 | -87.63396 | 41.92182 | -87.64414 | member |\n",
       "| 33FFC9805E3EFF9A | classic_bike  | 2024-01-31 05:43:23 | 2024-01-31 06:09:35 | Lincoln Ave &amp; Waveland Ave | 13253        | Kingsbury St &amp; Kinzie St  | KA1503000043 | 41.94880 | -87.67528 | 41.88918 | -87.63851 | member |\n",
       "| C96080812CD285C5 | classic_bike  | 2024-01-07 11:21:24 | 2024-01-07 11:30:03 | Wells St &amp; Elm St          | KA1504000135 | Kingsbury St &amp; Kinzie St  | KA1503000043 | 41.90322 | -87.63432 | 41.88918 | -87.63851 | member |\n",
       "\n"
      ],
      "text/plain": [
       "  ride_id          rideable_type started_at          ended_at           \n",
       "1 C1D650626C8C899A electric_bike 2024-01-12 15:30:27 2024-01-12 15:37:59\n",
       "2 EECD38BDB25BFCB0 electric_bike 2024-01-08 15:45:46 2024-01-08 15:52:59\n",
       "3 F4A9CE78061F17F7 electric_bike 2024-01-27 12:27:19 2024-01-27 12:35:19\n",
       "4 0A0D9E15EE50B171 classic_bike  2024-01-29 16:26:17 2024-01-29 16:56:06\n",
       "5 33FFC9805E3EFF9A classic_bike  2024-01-31 05:43:23 2024-01-31 06:09:35\n",
       "6 C96080812CD285C5 classic_bike  2024-01-07 11:21:24 2024-01-07 11:30:03\n",
       "  start_station_name         start_station_id end_station_name         \n",
       "1 Wells St & Elm St          KA1504000135     Kingsbury St & Kinzie St \n",
       "2 Wells St & Elm St          KA1504000135     Kingsbury St & Kinzie St \n",
       "3 Wells St & Elm St          KA1504000135     Kingsbury St & Kinzie St \n",
       "4 Wells St & Randolph St     TA1305000030     Larrabee St & Webster Ave\n",
       "5 Lincoln Ave & Waveland Ave 13253            Kingsbury St & Kinzie St \n",
       "6 Wells St & Elm St          KA1504000135     Kingsbury St & Kinzie St \n",
       "  end_station_id start_lat start_lng end_lat  end_lng   member_casual\n",
       "1 KA1503000043   41.90327  -87.63474 41.88918 -87.63851 member       \n",
       "2 KA1503000043   41.90294  -87.63444 41.88918 -87.63851 member       \n",
       "3 KA1503000043   41.90295  -87.63447 41.88918 -87.63851 member       \n",
       "4 13193          41.88430  -87.63396 41.92182 -87.64414 member       \n",
       "5 KA1503000043   41.94880  -87.67528 41.88918 -87.63851 member       \n",
       "6 KA1503000043   41.90322  -87.63432 41.88918 -87.63851 member       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(all_trips)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "64614b39",
   "metadata": {
    "papermill": {
     "duration": 0.010796,
     "end_time": "2024-02-22T23:00:51.257050",
     "exception": false,
     "start_time": "2024-02-22T23:00:51.246254",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Last 6 rows of data frame"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "1e36d124",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:51.281481Z",
     "iopub.status.busy": "2024-02-22T23:00:51.280324Z",
     "iopub.status.idle": "2024-02-22T23:00:51.313090Z",
     "shell.execute_reply": "2024-02-22T23:00:51.311857Z"
    },
    "papermill": {
     "duration": 0.047061,
     "end_time": "2024-02-22T23:00:51.314879",
     "exception": false,
     "start_time": "2024-02-22T23:00:51.267818",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 13</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>ride_id</th><th scope=col>rideable_type</th><th scope=col>started_at</th><th scope=col>ended_at</th><th scope=col>start_station_name</th><th scope=col>start_station_id</th><th scope=col>end_station_name</th><th scope=col>end_station_id</th><th scope=col>start_lat</th><th scope=col>start_lng</th><th scope=col>end_lat</th><th scope=col>end_lng</th><th scope=col>member_casual</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>B60EA061E2123F62</td><td>electric_bike</td><td>2023-02-04 17:52:34</td><td>2023-02-04 17:59:57</td><td>Clark St &amp; Wrightwood Ave</td><td>TA1305000014</td><td>Sheffield Ave &amp; Waveland Ave</td><td>TA1307000126</td><td>41.92960</td><td>-87.64315</td><td>41.94940</td><td>-87.65453</td><td>member</td></tr>\n",
       "\t<tr><td>C04510F8EBB5EE8A</td><td>classic_bike </td><td>2023-02-08 21:57:22</td><td>2023-02-08 22:08:06</td><td>Clark St &amp; Wrightwood Ave</td><td>TA1305000014</td><td>Sheffield Ave &amp; Waveland Ave</td><td>TA1307000126</td><td>41.92955</td><td>-87.64312</td><td>41.94940</td><td>-87.65453</td><td>member</td></tr>\n",
       "\t<tr><td>187BA364FB265C80</td><td>electric_bike</td><td>2023-02-19 11:29:09</td><td>2023-02-19 11:39:11</td><td>Ogden Ave &amp; Roosevelt Rd </td><td>KA1504000101</td><td><span style=white-space:pre-wrap>Delano Ct &amp; Roosevelt Rd    </span></td><td>KA1706005007</td><td>41.86650</td><td>-87.68448</td><td>41.86749</td><td>-87.63219</td><td>member</td></tr>\n",
       "\t<tr><td>46B54F6B417D1B27</td><td>electric_bike</td><td>2023-02-07 09:01:33</td><td>2023-02-07 09:16:53</td><td>Clark St &amp; Wrightwood Ave</td><td>TA1305000014</td><td><span style=white-space:pre-wrap>Canal St &amp; Madison St       </span></td><td><span style=white-space:pre-wrap>13341       </span></td><td>41.92953</td><td>-87.64325</td><td>41.88241</td><td>-87.63977</td><td>casual</td></tr>\n",
       "\t<tr><td>335B3CAD59F6C016</td><td>electric_bike</td><td>2023-02-22 08:33:22</td><td>2023-02-22 08:50:11</td><td>Clark St &amp; Wrightwood Ave</td><td>TA1305000014</td><td><span style=white-space:pre-wrap>Canal St &amp; Madison St       </span></td><td><span style=white-space:pre-wrap>13341       </span></td><td>41.92961</td><td>-87.64312</td><td>41.88241</td><td>-87.63977</td><td>casual</td></tr>\n",
       "\t<tr><td>03D59518BB151EFA</td><td>classic_bike </td><td>2023-02-01 21:52:17</td><td>2023-02-01 22:04:17</td><td><span style=white-space:pre-wrap>Clark St &amp; Winnemac Ave  </span></td><td>TA1309000035</td><td>Sheffield Ave &amp; Waveland Ave</td><td>TA1307000126</td><td>41.97335</td><td>-87.66786</td><td>41.94940</td><td>-87.65453</td><td>member</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 13\n",
       "\\begin{tabular}{lllllllllllll}\n",
       " ride\\_id & rideable\\_type & started\\_at & ended\\_at & start\\_station\\_name & start\\_station\\_id & end\\_station\\_name & end\\_station\\_id & start\\_lat & start\\_lng & end\\_lat & end\\_lng & member\\_casual\\\\\n",
       " <chr> & <chr> & <dttm> & <dttm> & <chr> & <chr> & <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t B60EA061E2123F62 & electric\\_bike & 2023-02-04 17:52:34 & 2023-02-04 17:59:57 & Clark St \\& Wrightwood Ave & TA1305000014 & Sheffield Ave \\& Waveland Ave & TA1307000126 & 41.92960 & -87.64315 & 41.94940 & -87.65453 & member\\\\\n",
       "\t C04510F8EBB5EE8A & classic\\_bike  & 2023-02-08 21:57:22 & 2023-02-08 22:08:06 & Clark St \\& Wrightwood Ave & TA1305000014 & Sheffield Ave \\& Waveland Ave & TA1307000126 & 41.92955 & -87.64312 & 41.94940 & -87.65453 & member\\\\\n",
       "\t 187BA364FB265C80 & electric\\_bike & 2023-02-19 11:29:09 & 2023-02-19 11:39:11 & Ogden Ave \\& Roosevelt Rd  & KA1504000101 & Delano Ct \\& Roosevelt Rd     & KA1706005007 & 41.86650 & -87.68448 & 41.86749 & -87.63219 & member\\\\\n",
       "\t 46B54F6B417D1B27 & electric\\_bike & 2023-02-07 09:01:33 & 2023-02-07 09:16:53 & Clark St \\& Wrightwood Ave & TA1305000014 & Canal St \\& Madison St        & 13341        & 41.92953 & -87.64325 & 41.88241 & -87.63977 & casual\\\\\n",
       "\t 335B3CAD59F6C016 & electric\\_bike & 2023-02-22 08:33:22 & 2023-02-22 08:50:11 & Clark St \\& Wrightwood Ave & TA1305000014 & Canal St \\& Madison St        & 13341        & 41.92961 & -87.64312 & 41.88241 & -87.63977 & casual\\\\\n",
       "\t 03D59518BB151EFA & classic\\_bike  & 2023-02-01 21:52:17 & 2023-02-01 22:04:17 & Clark St \\& Winnemac Ave   & TA1309000035 & Sheffield Ave \\& Waveland Ave & TA1307000126 & 41.97335 & -87.66786 & 41.94940 & -87.65453 & member\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 13\n",
       "\n",
       "| ride_id &lt;chr&gt; | rideable_type &lt;chr&gt; | started_at &lt;dttm&gt; | ended_at &lt;dttm&gt; | start_station_name &lt;chr&gt; | start_station_id &lt;chr&gt; | end_station_name &lt;chr&gt; | end_station_id &lt;chr&gt; | start_lat &lt;dbl&gt; | start_lng &lt;dbl&gt; | end_lat &lt;dbl&gt; | end_lng &lt;dbl&gt; | member_casual &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| B60EA061E2123F62 | electric_bike | 2023-02-04 17:52:34 | 2023-02-04 17:59:57 | Clark St &amp; Wrightwood Ave | TA1305000014 | Sheffield Ave &amp; Waveland Ave | TA1307000126 | 41.92960 | -87.64315 | 41.94940 | -87.65453 | member |\n",
       "| C04510F8EBB5EE8A | classic_bike  | 2023-02-08 21:57:22 | 2023-02-08 22:08:06 | Clark St &amp; Wrightwood Ave | TA1305000014 | Sheffield Ave &amp; Waveland Ave | TA1307000126 | 41.92955 | -87.64312 | 41.94940 | -87.65453 | member |\n",
       "| 187BA364FB265C80 | electric_bike | 2023-02-19 11:29:09 | 2023-02-19 11:39:11 | Ogden Ave &amp; Roosevelt Rd  | KA1504000101 | Delano Ct &amp; Roosevelt Rd     | KA1706005007 | 41.86650 | -87.68448 | 41.86749 | -87.63219 | member |\n",
       "| 46B54F6B417D1B27 | electric_bike | 2023-02-07 09:01:33 | 2023-02-07 09:16:53 | Clark St &amp; Wrightwood Ave | TA1305000014 | Canal St &amp; Madison St        | 13341        | 41.92953 | -87.64325 | 41.88241 | -87.63977 | casual |\n",
       "| 335B3CAD59F6C016 | electric_bike | 2023-02-22 08:33:22 | 2023-02-22 08:50:11 | Clark St &amp; Wrightwood Ave | TA1305000014 | Canal St &amp; Madison St        | 13341        | 41.92961 | -87.64312 | 41.88241 | -87.63977 | casual |\n",
       "| 03D59518BB151EFA | classic_bike  | 2023-02-01 21:52:17 | 2023-02-01 22:04:17 | Clark St &amp; Winnemac Ave   | TA1309000035 | Sheffield Ave &amp; Waveland Ave | TA1307000126 | 41.97335 | -87.66786 | 41.94940 | -87.65453 | member |\n",
       "\n"
      ],
      "text/plain": [
       "  ride_id          rideable_type started_at          ended_at           \n",
       "1 B60EA061E2123F62 electric_bike 2023-02-04 17:52:34 2023-02-04 17:59:57\n",
       "2 C04510F8EBB5EE8A classic_bike  2023-02-08 21:57:22 2023-02-08 22:08:06\n",
       "3 187BA364FB265C80 electric_bike 2023-02-19 11:29:09 2023-02-19 11:39:11\n",
       "4 46B54F6B417D1B27 electric_bike 2023-02-07 09:01:33 2023-02-07 09:16:53\n",
       "5 335B3CAD59F6C016 electric_bike 2023-02-22 08:33:22 2023-02-22 08:50:11\n",
       "6 03D59518BB151EFA classic_bike  2023-02-01 21:52:17 2023-02-01 22:04:17\n",
       "  start_station_name        start_station_id end_station_name            \n",
       "1 Clark St & Wrightwood Ave TA1305000014     Sheffield Ave & Waveland Ave\n",
       "2 Clark St & Wrightwood Ave TA1305000014     Sheffield Ave & Waveland Ave\n",
       "3 Ogden Ave & Roosevelt Rd  KA1504000101     Delano Ct & Roosevelt Rd    \n",
       "4 Clark St & Wrightwood Ave TA1305000014     Canal St & Madison St       \n",
       "5 Clark St & Wrightwood Ave TA1305000014     Canal St & Madison St       \n",
       "6 Clark St & Winnemac Ave   TA1309000035     Sheffield Ave & Waveland Ave\n",
       "  end_station_id start_lat start_lng end_lat  end_lng   member_casual\n",
       "1 TA1307000126   41.92960  -87.64315 41.94940 -87.65453 member       \n",
       "2 TA1307000126   41.92955  -87.64312 41.94940 -87.65453 member       \n",
       "3 KA1706005007   41.86650  -87.68448 41.86749 -87.63219 member       \n",
       "4 13341          41.92953  -87.64325 41.88241 -87.63977 casual       \n",
       "5 13341          41.92961  -87.64312 41.88241 -87.63977 casual       \n",
       "6 TA1307000126   41.97335  -87.66786 41.94940 -87.65453 member       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "tail(all_trips)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "9a9f4d2b",
   "metadata": {
    "papermill": {
     "duration": 0.010584,
     "end_time": "2024-02-22T23:00:51.336382",
     "exception": false,
     "start_time": "2024-02-22T23:00:51.325798",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### List of columns and data types"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "8725e785",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:51.360414Z",
     "iopub.status.busy": "2024-02-22T23:00:51.359216Z",
     "iopub.status.idle": "2024-02-22T23:00:51.395986Z",
     "shell.execute_reply": "2024-02-22T23:00:51.394480Z"
    },
    "papermill": {
     "duration": 0.050807,
     "end_time": "2024-02-22T23:00:51.397705",
     "exception": false,
     "start_time": "2024-02-22T23:00:51.346898",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "spc_tbl_ [5,674,449 × 13] (S3: spec_tbl_df/tbl_df/tbl/data.frame)\n",
      " $ ride_id           : chr [1:5674449] \"C1D650626C8C899A\" \"EECD38BDB25BFCB0\" \"F4A9CE78061F17F7\" \"0A0D9E15EE50B171\" ...\n",
      " $ rideable_type     : chr [1:5674449] \"electric_bike\" \"electric_bike\" \"electric_bike\" \"classic_bike\" ...\n",
      " $ started_at        : POSIXct[1:5674449], format: \"2024-01-12 15:30:27\" \"2024-01-08 15:45:46\" ...\n",
      " $ ended_at          : POSIXct[1:5674449], format: \"2024-01-12 15:37:59\" \"2024-01-08 15:52:59\" ...\n",
      " $ start_station_name: chr [1:5674449] \"Wells St & Elm St\" \"Wells St & Elm St\" \"Wells St & Elm St\" \"Wells St & Randolph St\" ...\n",
      " $ start_station_id  : chr [1:5674449] \"KA1504000135\" \"KA1504000135\" \"KA1504000135\" \"TA1305000030\" ...\n",
      " $ end_station_name  : chr [1:5674449] \"Kingsbury St & Kinzie St\" \"Kingsbury St & Kinzie St\" \"Kingsbury St & Kinzie St\" \"Larrabee St & Webster Ave\" ...\n",
      " $ end_station_id    : chr [1:5674449] \"KA1503000043\" \"KA1503000043\" \"KA1503000043\" \"13193\" ...\n",
      " $ start_lat         : num [1:5674449] 41.9 41.9 41.9 41.9 41.9 ...\n",
      " $ start_lng         : num [1:5674449] -87.6 -87.6 -87.6 -87.6 -87.7 ...\n",
      " $ end_lat           : num [1:5674449] 41.9 41.9 41.9 41.9 41.9 ...\n",
      " $ end_lng           : num [1:5674449] -87.6 -87.6 -87.6 -87.6 -87.6 ...\n",
      " $ member_casual     : chr [1:5674449] \"member\" \"member\" \"member\" \"member\" ...\n",
      " - attr(*, \"spec\")=\n",
      "  .. cols(\n",
      "  ..   ride_id = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   rideable_type = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   started_at = \u001b[34mcol_datetime(format = \"\")\u001b[39m,\n",
      "  ..   ended_at = \u001b[34mcol_datetime(format = \"\")\u001b[39m,\n",
      "  ..   start_station_name = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   start_station_id = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   end_station_name = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   end_station_id = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   start_lat = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   start_lng = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   end_lat = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   end_lng = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   member_casual = \u001b[31mcol_character()\u001b[39m\n",
      "  .. )\n",
      " - attr(*, \"problems\")=<externalptr> \n"
     ]
    }
   ],
   "source": [
    "str(all_trips)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "84e12df4",
   "metadata": {
    "papermill": {
     "duration": 0.011069,
     "end_time": "2024-02-22T23:00:51.442162",
     "exception": false,
     "start_time": "2024-02-22T23:00:51.431093",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Statistical summary of data"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "c7223fd0",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:51.466144Z",
     "iopub.status.busy": "2024-02-22T23:00:51.464947Z",
     "iopub.status.idle": "2024-02-22T23:00:54.622941Z",
     "shell.execute_reply": "2024-02-22T23:00:54.621808Z"
    },
    "papermill": {
     "duration": 3.172353,
     "end_time": "2024-02-22T23:00:54.625105",
     "exception": false,
     "start_time": "2024-02-22T23:00:51.452752",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "   ride_id          rideable_type        started_at                 \n",
       " Length:5674449     Length:5674449     Min.   :2023-02-01 00:01:34  \n",
       " Class :character   Class :character   1st Qu.:2023-05-29 13:08:15  \n",
       " Mode  :character   Mode  :character   Median :2023-07-27 06:42:33  \n",
       "                                       Mean   :2023-07-27 05:39:54  \n",
       "                                       3rd Qu.:2023-09-24 08:33:28  \n",
       "                                       Max.   :2024-01-31 23:59:40  \n",
       "                                                                    \n",
       "    ended_at                   start_station_name start_station_id  \n",
       " Min.   :2023-02-01 00:08:42   Length:5674449     Length:5674449    \n",
       " 1st Qu.:2023-05-29 13:33:05   Class :character   Class :character  \n",
       " Median :2023-07-27 06:58:21   Mode  :character   Mode  :character  \n",
       " Mean   :2023-07-27 05:58:10                                        \n",
       " 3rd Qu.:2023-09-24 08:59:02                                        \n",
       " Max.   :2024-02-02 00:01:21                                        \n",
       "                                                                    \n",
       " end_station_name   end_station_id       start_lat       start_lng     \n",
       " Length:5674449     Length:5674449     Min.   :41.63   Min.   :-87.94  \n",
       " Class :character   Class :character   1st Qu.:41.88   1st Qu.:-87.66  \n",
       " Mode  :character   Mode  :character   Median :41.90   Median :-87.64  \n",
       "                                       Mean   :41.90   Mean   :-87.65  \n",
       "                                       3rd Qu.:41.93   3rd Qu.:-87.63  \n",
       "                                       Max.   :42.07   Max.   :-87.46  \n",
       "                                                                       \n",
       "    end_lat         end_lng       member_casual     \n",
       " Min.   : 0.00   Min.   :-88.16   Length:5674449    \n",
       " 1st Qu.:41.88   1st Qu.:-87.66   Class :character  \n",
       " Median :41.90   Median :-87.64   Mode  :character  \n",
       " Mean   :41.90   Mean   :-87.65                     \n",
       " 3rd Qu.:41.93   3rd Qu.:-87.63                     \n",
       " Max.   :42.18   Max.   :  0.00                     \n",
       " NA's   :7151    NA's   :7151                       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "summary(all_trips)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "eb6dbe84",
   "metadata": {
    "papermill": {
     "duration": 0.010809,
     "end_time": "2024-02-22T23:00:54.647184",
     "exception": false,
     "start_time": "2024-02-22T23:00:54.636375",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Check member_casual column that there are only two types of users "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "aa566dd4",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:54.671639Z",
     "iopub.status.busy": "2024-02-22T23:00:54.670536Z",
     "iopub.status.idle": "2024-02-22T23:00:54.744683Z",
     "shell.execute_reply": "2024-02-22T23:00:54.742135Z"
    },
    "papermill": {
     "duration": 0.089136,
     "end_time": "2024-02-22T23:00:54.747178",
     "exception": false,
     "start_time": "2024-02-22T23:00:54.658042",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'member'</li><li>'casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'member'\n",
       "\\item 'casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'member'\n",
       "2. 'casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"member\" \"casual\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "unique(all_trips$member_casual)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "d6b813e2",
   "metadata": {
    "papermill": {
     "duration": 0.011269,
     "end_time": "2024-02-22T23:00:54.770069",
     "exception": false,
     "start_time": "2024-02-22T23:00:54.758800",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Add a \"ride_length\" calculation to all_trips (in seconds)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "c6ddb948",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:54.795435Z",
     "iopub.status.busy": "2024-02-22T23:00:54.794258Z",
     "iopub.status.idle": "2024-02-22T23:00:55.839970Z",
     "shell.execute_reply": "2024-02-22T23:00:55.837533Z"
    },
    "papermill": {
     "duration": 1.06115,
     "end_time": "2024-02-22T23:00:55.842453",
     "exception": false,
     "start_time": "2024-02-22T23:00:54.781303",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "tibble [5,674,449 × 15] (S3: tbl_df/tbl/data.frame)\n",
      " $ ride_id           : chr [1:5674449] \"C1D650626C8C899A\" \"EECD38BDB25BFCB0\" \"F4A9CE78061F17F7\" \"0A0D9E15EE50B171\" ...\n",
      " $ rideable_type     : chr [1:5674449] \"electric_bike\" \"electric_bike\" \"electric_bike\" \"classic_bike\" ...\n",
      " $ started_at        : POSIXct[1:5674449], format: \"2024-01-12 15:30:27\" \"2024-01-08 15:45:46\" ...\n",
      " $ ended_at          : POSIXct[1:5674449], format: \"2024-01-12 15:37:59\" \"2024-01-08 15:52:59\" ...\n",
      " $ start_station_name: chr [1:5674449] \"Wells St & Elm St\" \"Wells St & Elm St\" \"Wells St & Elm St\" \"Wells St & Randolph St\" ...\n",
      " $ start_station_id  : chr [1:5674449] \"KA1504000135\" \"KA1504000135\" \"KA1504000135\" \"TA1305000030\" ...\n",
      " $ end_station_name  : chr [1:5674449] \"Kingsbury St & Kinzie St\" \"Kingsbury St & Kinzie St\" \"Kingsbury St & Kinzie St\" \"Larrabee St & Webster Ave\" ...\n",
      " $ end_station_id    : chr [1:5674449] \"KA1503000043\" \"KA1503000043\" \"KA1503000043\" \"13193\" ...\n",
      " $ start_lat         : num [1:5674449] 41.9 41.9 41.9 41.9 41.9 ...\n",
      " $ start_lng         : num [1:5674449] -87.6 -87.6 -87.6 -87.6 -87.7 ...\n",
      " $ end_lat           : num [1:5674449] 41.9 41.9 41.9 41.9 41.9 ...\n",
      " $ end_lng           : num [1:5674449] -87.6 -87.6 -87.6 -87.6 -87.6 ...\n",
      " $ member_casual     : chr [1:5674449] \"member\" \"member\" \"member\" \"member\" ...\n",
      " $ ride_length       : 'difftime' num [1:5674449] 452 433 480 1789 ...\n",
      "  ..- attr(*, \"units\")= chr \"secs\"\n",
      " $ day_of_week       : chr [1:5674449] \"Friday\" \"Monday\" \"Saturday\" \"Monday\" ...\n"
     ]
    }
   ],
   "source": [
    "all_trips <- all_trips %>% \n",
    "  mutate(ride_length = ended_at - started_at) %>% \n",
    "  mutate(day_of_week = weekdays(started_at))\n",
    "str(all_trips)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "f030bc23",
   "metadata": {
    "papermill": {
     "duration": 0.011276,
     "end_time": "2024-02-22T23:00:55.866509",
     "exception": false,
     "start_time": "2024-02-22T23:00:55.855233",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### We will want to add some additional columns of data -- such as day, month, year -- that provide additional opportunities to aggregate the data."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "id": "67de4b26",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:55.891837Z",
     "iopub.status.busy": "2024-02-22T23:00:55.890594Z",
     "iopub.status.idle": "2024-02-22T23:00:59.703354Z",
     "shell.execute_reply": "2024-02-22T23:00:59.701521Z"
    },
    "papermill": {
     "duration": 3.828423,
     "end_time": "2024-02-22T23:00:59.706138",
     "exception": false,
     "start_time": "2024-02-22T23:00:55.877715",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'ride_id'</li><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li><li>'ride_length'</li><li>'day_of_week'</li><li>'date'</li><li>'month'</li><li>'day'</li><li>'year'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'ride\\_id'\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\item 'ride\\_length'\n",
       "\\item 'day\\_of\\_week'\n",
       "\\item 'date'\n",
       "\\item 'month'\n",
       "\\item 'day'\n",
       "\\item 'year'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'ride_id'\n",
       "2. 'rideable_type'\n",
       "3. 'started_at'\n",
       "4. 'ended_at'\n",
       "5. 'start_station_name'\n",
       "6. 'start_station_id'\n",
       "7. 'end_station_name'\n",
       "8. 'end_station_id'\n",
       "9. 'start_lat'\n",
       "10. 'start_lng'\n",
       "11. 'end_lat'\n",
       "12. 'end_lng'\n",
       "13. 'member_casual'\n",
       "14. 'ride_length'\n",
       "15. 'day_of_week'\n",
       "16. 'date'\n",
       "17. 'month'\n",
       "18. 'day'\n",
       "19. 'year'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"ride_id\"            \"rideable_type\"      \"started_at\"        \n",
       " [4] \"ended_at\"           \"start_station_name\" \"start_station_id\"  \n",
       " [7] \"end_station_name\"   \"end_station_id\"     \"start_lat\"         \n",
       "[10] \"start_lng\"          \"end_lat\"            \"end_lng\"           \n",
       "[13] \"member_casual\"      \"ride_length\"        \"day_of_week\"       \n",
       "[16] \"date\"               \"month\"              \"day\"               \n",
       "[19] \"year\"              "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "all_trips$date <- as.Date(all_trips$started_at)\n",
    "\n",
    "all_trips$month <- format(as.Date(all_trips$date), \"%m\")\n",
    "all_trips$day <- format(as.Date(all_trips$date), \"%d\")\n",
    "all_trips$year <- format(as.Date(all_trips$date), \"%Y\")\n",
    "\n",
    "colnames(all_trips)\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "0679a954",
   "metadata": {
    "papermill": {
     "duration": 0.012524,
     "end_time": "2024-02-22T23:00:59.730499",
     "exception": false,
     "start_time": "2024-02-22T23:00:59.717975",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Convert \"ride_length\" from Factor to numeric so we can run calculations on the data"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "id": "1d90e20d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:00:59.757440Z",
     "iopub.status.busy": "2024-02-22T23:00:59.756159Z",
     "iopub.status.idle": "2024-02-22T23:01:04.593724Z",
     "shell.execute_reply": "2024-02-22T23:01:04.592458Z"
    },
    "papermill": {
     "duration": 4.852886,
     "end_time": "2024-02-22T23:01:04.595385",
     "exception": false,
     "start_time": "2024-02-22T23:00:59.742499",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "TRUE"
      ],
      "text/latex": [
       "TRUE"
      ],
      "text/markdown": [
       "TRUE"
      ],
      "text/plain": [
       "[1] TRUE"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))\n",
    "is.numeric(all_trips$ride_length)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "2cc97ffc",
   "metadata": {
    "papermill": {
     "duration": 0.011744,
     "end_time": "2024-02-22T23:01:04.618814",
     "exception": false,
     "start_time": "2024-02-22T23:01:04.607070",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### The dataframe includes a few hundred entries when bikes were taken out of docks and checked for quality or ride_length was negative"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "id": "7ccea92d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:01:04.644812Z",
     "iopub.status.busy": "2024-02-22T23:01:04.643613Z",
     "iopub.status.idle": "2024-02-22T23:01:05.821686Z",
     "shell.execute_reply": "2024-02-22T23:01:05.820264Z"
    },
    "papermill": {
     "duration": 1.193664,
     "end_time": "2024-02-22T23:01:05.823921",
     "exception": false,
     "start_time": "2024-02-22T23:01:04.630257",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "all_trips_v2 <- all_trips %>% \n",
    "  filter(!(start_station_name == \"HQ QR\" | ride_length < 0))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "7086d366",
   "metadata": {
    "papermill": {
     "duration": 0.011716,
     "end_time": "2024-02-22T23:01:05.847988",
     "exception": false,
     "start_time": "2024-02-22T23:01:05.836272",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# STEP 4: CONDUCT DESCRIPTIVE ANALYSIS\n",
    "\n",
    "#### Descriptive analysis on ride_length (all figures in seconds)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "id": "3477cfe8",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:01:05.873929Z",
     "iopub.status.busy": "2024-02-22T23:01:05.872784Z",
     "iopub.status.idle": "2024-02-22T23:01:06.477564Z",
     "shell.execute_reply": "2024-02-22T23:01:06.476416Z"
    },
    "papermill": {
     "duration": 0.619807,
     "end_time": "2024-02-22T23:01:06.479282",
     "exception": false,
     "start_time": "2024-02-22T23:01:05.859475",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. \n",
       "      0     334     584    1161    1042 5909344 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "summary(all_trips_v2$ride_length)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "68158744",
   "metadata": {
    "papermill": {
     "duration": 0.011944,
     "end_time": "2024-02-22T23:01:06.503623",
     "exception": false,
     "start_time": "2024-02-22T23:01:06.491679",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Compare members and casual users"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "id": "71ddd3cd",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:01:06.530247Z",
     "iopub.status.busy": "2024-02-22T23:01:06.528952Z",
     "iopub.status.idle": "2024-02-22T23:01:17.402858Z",
     "shell.execute_reply": "2024-02-22T23:01:17.400918Z"
    },
    "papermill": {
     "duration": 10.88961,
     "end_time": "2024-02-22T23:01:17.405454",
     "exception": false,
     "start_time": "2024-02-22T23:01:06.515844",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>all_trips_v2$member_casual</th><th scope=col>all_trips_v2$ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>1868.4289</td></tr>\n",
       "\t<tr><td>member</td><td> 767.0757</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " all\\_trips\\_v2\\$member\\_casual & all\\_trips\\_v2\\$ride\\_length\\\\\n",
       " <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & 1868.4289\\\\\n",
       "\t member &  767.0757\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 2\n",
       "\n",
       "| all_trips_v2$member_casual &lt;chr&gt; | all_trips_v2$ride_length &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| casual | 1868.4289 |\n",
       "| member |  767.0757 |\n",
       "\n"
      ],
      "text/plain": [
       "  all_trips_v2$member_casual all_trips_v2$ride_length\n",
       "1 casual                     1868.4289               \n",
       "2 member                      767.0757               "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>all_trips_v2$member_casual</th><th scope=col>all_trips_v2$ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>749</td></tr>\n",
       "\t<tr><td>member</td><td>515</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " all\\_trips\\_v2\\$member\\_casual & all\\_trips\\_v2\\$ride\\_length\\\\\n",
       " <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & 749\\\\\n",
       "\t member & 515\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 2\n",
       "\n",
       "| all_trips_v2$member_casual &lt;chr&gt; | all_trips_v2$ride_length &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| casual | 749 |\n",
       "| member | 515 |\n",
       "\n"
      ],
      "text/plain": [
       "  all_trips_v2$member_casual all_trips_v2$ride_length\n",
       "1 casual                     749                     \n",
       "2 member                     515                     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>all_trips_v2$member_casual</th><th scope=col>all_trips_v2$ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>5909344</td></tr>\n",
       "\t<tr><td>member</td><td>  93580</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " all\\_trips\\_v2\\$member\\_casual & all\\_trips\\_v2\\$ride\\_length\\\\\n",
       " <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & 5909344\\\\\n",
       "\t member &   93580\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 2\n",
       "\n",
       "| all_trips_v2$member_casual &lt;chr&gt; | all_trips_v2$ride_length &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| casual | 5909344 |\n",
       "| member |   93580 |\n",
       "\n"
      ],
      "text/plain": [
       "  all_trips_v2$member_casual all_trips_v2$ride_length\n",
       "1 casual                     5909344                 \n",
       "2 member                       93580                 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>all_trips_v2$member_casual</th><th scope=col>all_trips_v2$ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>0</td></tr>\n",
       "\t<tr><td>member</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " all\\_trips\\_v2\\$member\\_casual & all\\_trips\\_v2\\$ride\\_length\\\\\n",
       " <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & 0\\\\\n",
       "\t member & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 2\n",
       "\n",
       "| all_trips_v2$member_casual &lt;chr&gt; | all_trips_v2$ride_length &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| casual | 0 |\n",
       "| member | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "  all_trips_v2$member_casual all_trips_v2$ride_length\n",
       "1 casual                     0                       \n",
       "2 member                     0                       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)\n",
    "\n",
    "aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)\n",
    "\n",
    "aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = max)\n",
    "\n",
    "aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = min)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "6e83d1e9",
   "metadata": {
    "papermill": {
     "duration": 0.012402,
     "end_time": "2024-02-22T23:01:17.430723",
     "exception": false,
     "start_time": "2024-02-22T23:01:17.418321",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Let's put days of the week in order"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 22,
   "id": "0db8f416",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:01:17.458559Z",
     "iopub.status.busy": "2024-02-22T23:01:17.457350Z",
     "iopub.status.idle": "2024-02-22T23:01:17.526105Z",
     "shell.execute_reply": "2024-02-22T23:01:17.524663Z"
    },
    "papermill": {
     "duration": 0.085303,
     "end_time": "2024-02-22T23:01:17.528521",
     "exception": false,
     "start_time": "2024-02-22T23:01:17.443218",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week, levels = c(\"Sunday\", \"Monday\", \"Tuesday\", \"Wednesday\", \"Thursday\", \"Friday\", \"Saturday\"))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "fd08a72b",
   "metadata": {
    "papermill": {
     "duration": 0.011912,
     "end_time": "2024-02-22T23:01:17.552778",
     "exception": false,
     "start_time": "2024-02-22T23:01:17.540866",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### The average ride time by each day for members vs casual users"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 23,
   "id": "8f04d9e4",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:01:17.579537Z",
     "iopub.status.busy": "2024-02-22T23:01:17.578416Z",
     "iopub.status.idle": "2024-02-22T23:01:21.946906Z",
     "shell.execute_reply": "2024-02-22T23:01:21.945595Z"
    },
    "papermill": {
     "duration": 4.383961,
     "end_time": "2024-02-22T23:01:21.948678",
     "exception": false,
     "start_time": "2024-02-22T23:01:17.564717",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 14 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>member_casual</th><th scope=col>day_of_week</th><th scope=col>ride_length</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;ord&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>Sunday   </td><td>1596.8845</td></tr>\n",
       "\t<tr><td>member</td><td>Sunday   </td><td> 819.6140</td></tr>\n",
       "\t<tr><td>casual</td><td>Monday   </td><td>1357.8931</td></tr>\n",
       "\t<tr><td>member</td><td>Monday   </td><td> 697.2265</td></tr>\n",
       "\t<tr><td>casual</td><td>Tuesday  </td><td>1238.3226</td></tr>\n",
       "\t<tr><td>member</td><td>Tuesday  </td><td> 705.5671</td></tr>\n",
       "\t<tr><td>casual</td><td>Wednesday</td><td>1180.9263</td></tr>\n",
       "\t<tr><td>member</td><td>Wednesday</td><td> 702.0763</td></tr>\n",
       "\t<tr><td>casual</td><td>Thursday </td><td>1202.9748</td></tr>\n",
       "\t<tr><td>member</td><td>Thursday </td><td> 699.1167</td></tr>\n",
       "\t<tr><td>casual</td><td>Friday   </td><td>1343.6715</td></tr>\n",
       "\t<tr><td>member</td><td>Friday   </td><td> 725.2013</td></tr>\n",
       "\t<tr><td>casual</td><td>Saturday </td><td>1558.2246</td></tr>\n",
       "\t<tr><td>member</td><td>Saturday </td><td> 818.5402</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 14 × 3\n",
       "\\begin{tabular}{lll}\n",
       " member\\_casual & day\\_of\\_week & ride\\_length\\\\\n",
       " <chr> & <ord> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & Sunday    & 1596.8845\\\\\n",
       "\t member & Sunday    &  819.6140\\\\\n",
       "\t casual & Monday    & 1357.8931\\\\\n",
       "\t member & Monday    &  697.2265\\\\\n",
       "\t casual & Tuesday   & 1238.3226\\\\\n",
       "\t member & Tuesday   &  705.5671\\\\\n",
       "\t casual & Wednesday & 1180.9263\\\\\n",
       "\t member & Wednesday &  702.0763\\\\\n",
       "\t casual & Thursday  & 1202.9748\\\\\n",
       "\t member & Thursday  &  699.1167\\\\\n",
       "\t casual & Friday    & 1343.6715\\\\\n",
       "\t member & Friday    &  725.2013\\\\\n",
       "\t casual & Saturday  & 1558.2246\\\\\n",
       "\t member & Saturday  &  818.5402\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 14 × 3\n",
       "\n",
       "| member_casual &lt;chr&gt; | day_of_week &lt;ord&gt; | ride_length &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| casual | Sunday    | 1596.8845 |\n",
       "| member | Sunday    |  819.6140 |\n",
       "| casual | Monday    | 1357.8931 |\n",
       "| member | Monday    |  697.2265 |\n",
       "| casual | Tuesday   | 1238.3226 |\n",
       "| member | Tuesday   |  705.5671 |\n",
       "| casual | Wednesday | 1180.9263 |\n",
       "| member | Wednesday |  702.0763 |\n",
       "| casual | Thursday  | 1202.9748 |\n",
       "| member | Thursday  |  699.1167 |\n",
       "| casual | Friday    | 1343.6715 |\n",
       "| member | Friday    |  725.2013 |\n",
       "| casual | Saturday  | 1558.2246 |\n",
       "| member | Saturday  |  818.5402 |\n",
       "\n"
      ],
      "text/plain": [
       "   member_casual day_of_week ride_length\n",
       "1  casual        Sunday      1596.8845  \n",
       "2  member        Sunday       819.6140  \n",
       "3  casual        Monday      1357.8931  \n",
       "4  member        Monday       697.2265  \n",
       "5  casual        Tuesday     1238.3226  \n",
       "6  member        Tuesday      705.5671  \n",
       "7  casual        Wednesday   1180.9263  \n",
       "8  member        Wednesday    702.0763  \n",
       "9  casual        Thursday    1202.9748  \n",
       "10 member        Thursday     699.1167  \n",
       "11 casual        Friday      1343.6715  \n",
       "12 member        Friday       725.2013  \n",
       "13 casual        Saturday    1558.2246  \n",
       "14 member        Saturday     818.5402  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "all_trips_v2 <- na.omit(all_trips_v2)\n",
    "\n",
    "counts <- aggregate(ride_length ~ member_casual + day_of_week, data = all_trips_v2, FUN = mean)\n",
    "\n",
    "counts"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "42cdd153",
   "metadata": {
    "papermill": {
     "duration": 0.012229,
     "end_time": "2024-02-22T23:01:21.973595",
     "exception": false,
     "start_time": "2024-02-22T23:01:21.961366",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Analyze ridership data by type and weekday\n",
    "\n",
    "#### Visualize the number of rides by rider type"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 24,
   "id": "be426b2d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:01:22.001009Z",
     "iopub.status.busy": "2024-02-22T23:01:21.999785Z",
     "iopub.status.idle": "2024-02-22T23:01:26.206766Z",
     "shell.execute_reply": "2024-02-22T23:01:26.205531Z"
    },
    "papermill": {
     "duration": 4.223534,
     "end_time": "2024-02-22T23:01:26.209474",
     "exception": false,
     "start_time": "2024-02-22T23:01:21.985940",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22m`summarise()` has grouped output by 'member_casual'. You can override using the\n",
      "`.groups` argument.\n"
     ]
    },
    {
     "data": {
      "image/png": "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\nlzOXTdAXW9Wt5NO/h/v3758//+zrWlQqlUaTRvvKfqVIs33lyW4tZ7d+BS0no+CXrxRbVnC/\nIls+sfHSbH2uVM+hi/N7pctLDVFhy+eG7P4rslbrfp90qO0kSQ9unpRleWxQq+TDXBNvClFF\nyKZ4g1EIkRhvEELEx8db1qr0LkKISKPZX/f0/Z4HRpPGSyOEUOsCNm7c+O80vrXaj7n4U7t9\nX57p9sU7lkVlypRp1erZvhITE2X52ZdQp0jZH+YmHVWHSPPt0syQ3Vp2bL8iW7as09n7gq3U\nWlbwy1eKLSu4X/EaPLGRhdga7GZPrVt5ZI8TzX+u4uf8EruJufLz8JEL1OUafrasSwnfpwFR\n46qT1K4b1q/677c8q4UQceFrgnqtT1rYtm1by41Zy/oJcSDsidFf9/QK5ItPEj0CPVLcaWU/\n531R4Ul3a9euXbv2s195i4iISDPYuVtfncXFxsY6cO9ubi9zTfQrcmzL7u72fkI5tl/xOrXs\n/rmdvkfdKIRoaO2c4wyXasv2LMK+UmxZwf2K1+BvGVmIrcEucODW3vNzVstftE7Dd/P5ujy3\ndtmyZVa2lc1xn4xdpK/z4bx+tZNnOJdc7wvzb7vCjS2enlQnL584JrrW4KF187j4ddq+vZMQ\nIvFJWOuOz86xE7IxQLd015HwdxvmFUIYY0NPxCS0fs9fCPHw4oLhn52btjAkl+XNPNl04E6c\nZ6XiNjYIAACQ1dka7A6NqTH/QpQQUXt/2PzixRPWg13c3dXn4ow9y7n+ceJE0kKtc7HygVV6\nVfBZOTrYqU/rkgFuf+5ZvuN8xOQxOa3VIWmHty458qvJ+3KNKulp2BYyyzWgXuc8rkKIHIXb\n+cT1HT1lycD2dTykuBM/rT742P2jXgQ7AACQXdga7PrPP+GWr/WeX5e8VcA7vfuIvnBVCPHV\njE+SL/QoPHH1nDeafDTbsHT+hsUzoozagELlhk0fX941jZNyirb7uL9hznezJkbES0XK1woe\n3tuSM1Ua3+AFU1Ys/nbux+PiNTkKFy0zes7Uim4OOJELAAAFeFS5XNqD8JqxKdjJ5sdn4hJr\nLJn+EqlOCJHnvenb30t5laT2aN1vfOt+Ka8VQmicSz77HPbfbep1HV6vawqD9V6BfcdO6/sS\nJQIAgGTsf44sMoRN3yUmSZoCenXUn+FpDwUAAICD2PYlsZJ+Z0jnsLmN5+w4k8Z1pAAAAHAQ\n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\ndfHozhB3tarOmr+tNGUy3Kzu6eRTvu3anb/8sv3bJkVyuKtVlSaftF5wcilOe+dQZ5Xa5WKc\n0TLm5w5F3fMNsv64CCGGX34oy7KXRtXjYqSVya0c5OTbplm/lXliby+SJOnHyHjLyG9q5vGv\nuuy5xut4OlWdc2Zn84IFm+54usgUV8pFO+p8ZC9/t/JjTlgW9Snp5V6g3upte4//8v2IJsU0\nTvmPPDI893RN6j1dx+25Saz0+9enVTROhZOeLS8+qWyfykujqlmvzJTlO8//c8fKU9TGv9N/\nG0/5KFn/E0htF8mfA8mleRBkWZbNhq5FPXwqtN/846EjezcHlfT0Lj38xakAgh2QDikGu4iw\nDkKIk7EJMz+bsf1+nGXhk4gdQojvI59Y7i4s6lVmyHHLbSvDkuTWqUv03JN0t6CTpvGxu1Y2\nj74yTgix7fZjy/LzOzdv33fnuTktWaHZv1lKluWxpb19Ss+JuTlTklQHow1Jy2eV9M5X93tZ\nlq2syq1Tl+z9c9LyEi7aBgduvXjEcuvU1ZeFWW7fOdJIklSnHj9NBsEFPUr3P2qlqavbGqm1\nvqExCU+XP9iuVUmVJp+0UtVzUpzWZHwQoFc323VNlmXZHF/OVddg7T+pDbbcTTHYpTg+tYOc\nfFtb6rcyjyzLjbydq4WclWU50XDTV6vuc/zec41bgl3kuZEa5yIxiWZZliPOjdC6Bsab5aRg\nF31lkhDi65uxlk3MiQ+r5tBXmnpS/u/TNan39B63pEms9/tcpknxSWXjVF4aVck+e5NWpTab\njX+nlsatHCUrfwKp7cLGYJfitBFnB0kq5wMPn/Yee2vpu+++e9tgenE2ZHOcYwe8KkN4lCRJ\neXXqocM+2Ldt42dnL1y9euXkrztTG2/jsBIflE267a159vFZipu75R3a6Y0VrQoWqtWw/jvV\nq9dr2KJpGf8Upx3YIG/S7Y59is36aP3DMDdZNtf00Ccf5pkQJkSjh2E/prZKCFGkV5mkhb4a\nlUj5s1+Rq7qv5YbW00mtz1/W5enLjo9GJZtlK01dW3vR1b9XRTet5a6TT9MGXk63hLBeVXIp\nTqvS+MytmafvmB2i4YDI8xPPJrhva1EgtcFWWBn/4kEWYnDSEtvrT22eyT2K1pmxTAycfXvf\noGhtsZmVc6ZYoVfJ4JKqOaNPRyyo4Hts7MZ8jZbok52ydf/QL1qXEl0DXC13JbXHyKIefddf\nEhMrpDjbSx832/sVaT2p0pyqaLfSac6Wrgfa+lFKrdr0Ppeek+K0N7cfcfKqX9Pj6fUcrnl6\n//JL7/TOjOyAc+yAVxW29G8nr0Ze5luNi+YLCl4brfat0aRTyMbvUhxsMtywZZgQwi2H1vbN\nVRrf1b/dPL1vRbM38p7ft6pehbwNx+xJcdrkf/M6b52kctJ6OKs0nk/i/+Pe+cFCCCurhBB6\n95f4n2EKrzmpNSWpJSH+c/J4Tq0qzarSnFYI8e7MVpHnxl0zmA6NWp+71oKCerXtj0uak4uU\nDnLytTbWb2We0sMHx96adyDasHb4gYItQ9xSO8Ve0s9slH/7iF+E+cmIPbfaf/xm8pWyLD/3\ncKjVkmyy9t09L3fcbO9XpPWkSnOqHN7/uY71xdnS+0BbP0opVpveXbwoxWnNBvNzTyQgRbxj\nB7wSQ9TRHhuulBz2XVTY8N3XDXcu7silVQkh4u5/m+J4G4elJrXN7x2eNX1LwpwvxpSq3miw\nEOcWv11x5Cjx6ckXZ1jw8+06rQtZbq+Zed6j+OcehXPKpu0Lr8cPK+YhhBBCHlG3xv2OK1Z1\nL+ZRuHdqq9JV9ss1VSCoxON1X/71eEp5V60Qwhj7x+YHTwoLYWNVVg61T+D0UvqFww5cOLn3\nVpeT9a0PTlfNFi8e5ORrbT+qqc3j6t+zmfeHo5dv+jMscsbuqlbqfHNahztlhv595tg/qsCP\ninkmX+VXvYYxbtqau3Ht/V2EELIpZubFh/k+LGFltpc7bhn4LHr1qdL7QL/EUXrFv/HUBDQp\nFx+86USssYqbVggRd291kQqjVpy72sBLn+a2yFZ4xw5IH5Ph2uHDhw8fPnzo4L41iz6pWbJO\nhH/D7ydV0vu8IZsTZq47cO3mlSO7VwbVHi2EOPPPPcs3zKolEfP3hbt3H1gflqbUNtf4xcyd\nObbLx18fO3n6+P6t0xdc8CjRJsUZdnSpN+ObHSeO7Zs1oM7k04/Gfd3cybvx7HoBE95pumTd\nD6dOHps5sMbcw7e6tswvhLCyKgOl1lTueovfdHlUt1a3zT8dPrJnS/d3G3i7amyvytqhVjnP\nbpr/hy5N7zjVnFrSK43B6anZlMpBTr6t7UfVyjwTexf/fWQ3tXerwfncrRxbzyITK+jCG3dc\nnr/pF7r/vq/nUWhK92Kefd9ps+6HX08e3jOu9ZvHDLlCRpYRyZ6uz0+XnuOWNMmrP4sycCob\n/05tOUovt4uX5lshpGkuc+O6fXb+8lvo4R/61x8a79asgZf+5KcTRo6d92pzQ1kcfZIfkJXs\nqOCX9LcjSRpv/yL/+yD4QuzTqwF2f9a/eF5fpxz+Vet22n3hYc8qeTU69zOPjbIsn1/YzcdF\nmyN/Z+vDkuTWqTuERSTdreSmS7p4IrXNf5g5sFwhP61a45un0PudRp3995qDJI/vfqnW5d67\naEyVorn0eo/AqrW/2HrRssqUcG9a3+b5vd10rj5lq7de81t40laprcqtU7c69yBpWPUc+gb7\nU754ImnYg3Otks4Ql2V5YVGvUn2PWG8q5truTnUrujtp3X0L9Z79y+53AyxXxVopODkrhzr6\n8idCiIqTQm0ZLFK6eCLF8b9dXpzaQU6+bZr1W3mwng64t1II8eZnp1Js3HLxhOX2vk7FhBCT\n/3566Wiyq2LlhJgzI9rXyZXDWePkXq5Wm/V/PX3KJX+6JvVuYftxSz6JlX6fu24gxSeVjVN5\naVTJ/2pSm83Gv9OkxlM7Slb+BFLbhY0XT6Q2bfz/27ljloSiMADDScMVpBsUgg6RSEM0tbcE\n/gM3x8ApGgXnZqemBseG/kari9jW3hZEgijci3HcHBJnvafn+QGHM76c8/F9jx7arWYtPaqe\n3Xb6k2kWQni9PE3Sm80z+bdKIWwZeAZgX80+n47Pe28/8/U0PcCBGTuAggl59rsc3g1Orh5V\nHfCHsAMoksXXS6XWPUzqz+/3u74LsHd8xQIUSsg/xpPyxXXDcx2wQdgBAETCuhMAgEgIOwCA\nSAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEisAMWiKEIKhL/TAAAAAElFTkSuQmCC"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "all_trips_v2 %>% \n",
    "  mutate(weekday = wday(started_at, label = TRUE)) %>% \n",
    "  group_by(member_casual, weekday) %>% \n",
    "  summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>% \n",
    "  arrange(member_casual, weekday) %>% \n",
    "  ggplot(mapping = aes(x = weekday, y = number_of_rides, fill = member_casual)) + geom_col(position = \"dodge\") +\n",
    "    labs(title = \"Cyclistic Bike Share: Comparison number of rides by weekday\", \n",
    "       subtitle = \"Between casual and member user types\", \n",
    "       caption = \"Data has been made available by MotivateInternational Inc.\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "d77a24c3",
   "metadata": {
    "papermill": {
     "duration": 0.012957,
     "end_time": "2024-02-22T23:01:26.235864",
     "exception": false,
     "start_time": "2024-02-22T23:01:26.222907",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Create a visualization for average duration"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 25,
   "id": "cc721331",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-22T23:01:26.266160Z",
     "iopub.status.busy": "2024-02-22T23:01:26.264816Z",
     "iopub.status.idle": "2024-02-22T23:01:29.789204Z",
     "shell.execute_reply": "2024-02-22T23:01:29.787870Z"
    },
    "papermill": {
     "duration": 3.541676,
     "end_time": "2024-02-22T23:01:29.791227",
     "exception": false,
     "start_time": "2024-02-22T23:01:26.249551",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22m`summarise()` has grouped output by 'member_casual'. You can override using the\n",
      "`.groups` argument.\n"
     ]
    },
    {
     "data": {
      "image/png": "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\nqhvsRIwi4spxiIgtaoBRmehIbnzJJV08Tzsyt7//8e/VW9lLfHF0izkhxqWfPb/r0DdHq/e6\nXkTqjxvomvfgvK3fLz+e2fWRy7QUW456vQhr1FZkzfc/n5A6YZ6F66bf8sbJyOcXDBq+4KuE\nAc/tXzXe89SrBV6bm7Zj85bk6FbtRoyfOmL8VBHZ9tncpgPuu3PWr1uXdBYRkUJfcHF0U/5P\nO+Sk/ui9cC/O5bWx3euJ/Lz8t5PD+tbyLDyydqO2V/tWsVvH7dRfK0Uu8jx0Zu/75GRWWOc+\ntqiWFVRXqZvJyyb+Y0HF99Ttxlmt5t+04s1DuydvOFKr/4fRpvwTfsk73hG5JL/d2fs/OZkV\n3LKn+Bp5DXMVAKquqvt1Jz8suE1EmtzaXERMtgYPNI3a9caYtUcyPCssu23w1VdffaDACKkF\nTn8YLbVm1A3b/drDy49ntJ+UJCJhte+KMhtW3HWjS1WnDq6tpViN9WoUVufuViGWn+6Yujcr\n7+iec+aH0QtfXPVzNUfGdqeqRrXO/5mNjH83PHkoVSSvS+lHl3Tq1OmqR371rFC3/QUi4kh3\niIjdaMg69ann2yiyTv5467pDnjV9Fu7Fubw2puXD1SzGL8bcuSPdcba/v988bbPPF2pUsVvH\nLe3w4ns+3XP2kfPtqYPTnK7Bj3WtkLq8byYvm7gCe6oW3m6Jwx80KsqMmy47nuu87snuBZ9K\nP/LqXR/tPvvItXzakFSnq9e8nuJr5L3PVQCo6gL9Ib9K5755osetk2ecNf2uO4de0lJEgmIv\nPHD24/+p+9+pbTWZ7fWuGnfnow/PHnVRUxFpMfYN97P/rL1ERC6+7+m3luV/fcOWZzu5x3Bj\nat5dmQ/XjxCRoOhLPet4L9bnCsuSot1fm+JR/CPqBe1bOdGsKMHxXSdMnzNv1uR2cXaDKWzJ\njtOqM7NvdJDRUv22B5545aXFsyaNrh4U0bVeqMEUsfDNd9OcLpcjuW9skGKw9R91y+xHHr9/\nxm2tYoKM5ui3DqaqqvrLrAtEpGa3a5967uXHH7irWZjFXssunpsnfBXu7eYJX6/1PgK/Pz1M\nRIJi24+fNGvWpBtbR9rq9RsnXm+eKFJapMlQu98az8OUA/OkwO0OZd063ksLMijWWJtisF42\n6pY5D0y7vGddEUm4ZK5LQ12qqr7SKMpzT0mJvG8m75v43Gsv8T2iqurU2mEiYovoXfC2iyCD\n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"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "all_trips_v2 %>% \n",
    "  mutate(weekday = wday(started_at, label = TRUE)) %>% \n",
    "  group_by(member_casual, weekday) %>% \n",
    "  summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>% \n",
    "  arrange(member_casual, weekday) %>% \n",
    "  ggplot(mapping = aes(x = weekday, y = average_duration, fill = member_casual)) + geom_col(position = \"dodge\") + \n",
    "    labs(title = \"Cyclistic Bike Share: Comparison average duration of ride by weekday\", \n",
    "       subtitle = \"Between casual and member user types\", \n",
    "       caption = \"Data has been made available byMotivateInternational Inc.\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "85e9661c",
   "metadata": {
    "papermill": {
     "duration": 0.013365,
     "end_time": "2024-02-22T23:01:29.818300",
     "exception": false,
     "start_time": "2024-02-22T23:01:29.804935",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Copyright 2024 Ilia Zubov\n",
    "\n",
    "Licensed under the Apache License, Version 2.0 (the \"License\");\n",
    "you may not use this file except in compliance with the License.\n",
    "You may obtain a copy of the License at\n",
    "\n",
    "    http://www.apache.org/licenses/LICENSE-2.0\n",
    "\n",
    "Unless required by applicable law or agreed to in writing, software\n",
    "distributed under the License is distributed on an \"AS IS\" BASIS,\n",
    "WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.\n",
    "See the License for the specific language governing permissions and\n",
    "limitations under the License."
   ]
  }
 ],
 "metadata": {
  "kaggle": {
   "accelerator": "none",
   "dataSources": [
    {
     "datasetId": 4481491,
     "sourceId": 7681309,
     "sourceType": "datasetVersion"
    }
   ],
   "dockerImageVersionId": 30618,
   "isGpuEnabled": false,
   "isInternetEnabled": true,
   "language": "r",
   "sourceType": "notebook"
  },
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 77.868285,
   "end_time": "2024-02-22T23:01:30.453496",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2024-02-22T23:00:12.585211",
   "version": "2.5.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
