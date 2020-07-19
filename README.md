# Project to scrape git repos for committers/merges

# Setup
This requires Linux to run

```
git clone git@github.com:phil-rice/GitScraping.git`
cd GitScraping
source scripts/installGithubScrapping.sh
```
This last command makes symbolic links in the 'bin' subdirectory and adds it to the path. It also sorts out the 
permissions on the files so that they are executable

Please note that the installGithubScrappings uses `sudo`. It may ask you for your password. To avoid being
asked you can do any `sudo` command earlier: for examples `sudo ls`, and `sudo` remembers you
have given your password for a while.



# Running

* Create a file that holds the git urls. It shouldn't matter if they are azure devops/github/gitlab
* Ensure that you can actually download the repos
* Run your report
* Filter by an email list if you want

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

Example commands
* `gitReports.sh filename yesterday today` which will find all the commits and merge from yesterday.
* `gitReports.sh filename '1 year ago' today` which will list the details over the last year. 
* `gitReports.sh filename '1 month ago' today` which will list the details over the last month. 

The report is a human readable list of commiters and mergers for each repo

At the end of the command it prints the report. 

The results are found in the (hardcoded) file 'gitReports'


## Filter by an email list if you want
You can create a file that has a list of emails, an email on each line (see `scripts/samples/emails.txt` as an example).
You can then use linux pipes to pipe the results through `filterByEmails.sh` (which takes a single parameter: the filename
of the emails.

```
   filterByEmails.sh scripts/samples/emails.txt < gitReports > filteredGitReports
```

# Example commands
```
gitReports.sh scripts/sample/sample.txt '1 year ago' today  
filterByEmails.sh scripts/samples/emails.txt < gitReports > filteredGitReports

```

# Pipelines








