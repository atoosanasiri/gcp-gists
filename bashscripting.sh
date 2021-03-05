workiong with variables and functions in bash

working with functions:
1. createa a .sh file and put the funstion inside: ses sys_info
2. use this command to run the script and function
bash sys_info.sh system_info
OR
source sys_info.sh; system_info

3. The last line musr be "$@" but I do not really know why

https://stackoverflow.com/questions/8818119/how-can-i-run-a-function-from-a-script-in-command-line

difference between ${} and $() in shell script
https://superuser.com/questions/935374/difference-between-and-in-shell-script

#$(command) is “command substitution”. 
#${parameter} is “parameter substitution”.  
#$ animal=cat
#$ echo $animals
#                                # No such variable as “animals”.
#$ echo ${animal}s
#cats
#$ echo $animal_food
#                                # No such variable as “animal_food”.
#$ echo ${animal}_food
#cat_food

OR 
#$ echo "$animal"s
#cats

Another interesting example
#$animal=cat
#$echo $animal
#cat
#cat=tabby
#$ echo $cat
#tabby
#$ echo ${!animal}
#tabby                           # If $animal is “cat”, then ${!animal} is $cat, i.e., “tabby”

#$ animal=cat
#$ echo ${#animal}
#3                               # String length
#$ echo ${animal/at/ow}
#cow  

THEMONTH="This is the dat: `date +%B`"
echo $THEMONTH


# gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/pdf-converter

how to find what does into prompt in bash
export | grep PS1

declare -x PS1="\\[\\e]0;\${DEVSHELL_PROJECT_ID:-Cloud Shell}\\a\\]\\u@cloudshell:\\[\\033[1;34m\\]\\w\$([[ -n \$DEVSHELL_PROJECT_ID ]] && printf \" \\[\\033[1;33m\\](%s)\" \${DEVSHELL_PROJECT_ID} )\\[\\033[00m\\]\$ \\[\\033k\$([[ -n \$DEVSHELL_PROJECT_ID ]] && printf \"(%s)\" \${DEVSHELL_PROJECT_ID} || printf \"cloudshell\")\\033\\\\\\]"
student_04_4c8265b8223d@cloudshell:~ (qwiklabs-gcp-04-15d212efc9dd)$

From Qwiklabs
Interesting file editing with sed
Ingesting Data Into The Cloud Using Google Cloud Functions
#TOKEN=$(openssl rand -base64 48 | tr -d /=+ | cut -c -32)
#sed -i "s/DI8TWPzTedNF0b3B8meFPxXSWw6m3bKG/$TOKEN/" main.py
