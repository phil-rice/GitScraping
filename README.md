# Project to scrape git repos for committers/merges

# Setup

* clone the git repo
* cd 
* source scripts/installGithubScrapping.sh

This last command makes symbolic links in the 'bin' subdirectory and adds it to the path. It also sorts out the 
permissions on the files so that they are executable

# Running

* Create a file that holds the git urls. It shouldn't matter if they are azure devops/github/gitlab
* Ensure that you can actually download the repos
* Run your report

## The file that holds the git urls

An example would be
```
git@github.com:phil-rice/fizzbuzz3.git
git@github.com:phil-rice/Anagram.git
```

## Ensure you can actually download the repos

There is a helper script `checkGitsCanLoad.sh filename` that will read a file and produce a report.
After the command finishes it prints the results


## Run your report

There is a helper script `gitReports.sh filename (fromDate) (toDate)` that reads the file of gitlab urls and produces a report
in the logfilename (which defaults to git-report)

A good command to run is probably `gitReports.sh filename yesterday yesterday` which will find all the commits and merge from yesterday

The report is a human readable list of commiters and mergers for each repo

At the end of the command it prints the report

# Example commands
```
 gitReports.sh scripts/sample/sample.txt '2 years ago' 'today'  
```





