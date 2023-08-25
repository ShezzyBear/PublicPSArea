## DevOps Code Challenge 1 ##
# Use the provided input text and create a script that is able to convert to a specified output

# Create ordered dictionary for use later
$outputTT = [Ordered]@{}

# Input text provided in Code Challenge
$inputText = @"
[ 
  { 
    "name": "appsettingsname1", 
    "value": "value1", 
    "slotSetting": false 
  }, 
  { 
    "name": " appsettingsname2", 
    "value": " value2", 
    "slotSetting": false 
  }, 
  { 
    "name": " appsettingsname3", 
    "value": "value3", 
    "slotSetting": false 
  }, 
  { 
    "name": " appsettingsname4", 
    "value": "value4", 
    "slotSetting": false 
  }, 
] 
"@

# Convert the input text (JSON) to a PowerShell array of objects
$inputTT = $inputText | ConvertFrom-Json

# Populate dictionary after trimming whitespaces from name and value to achieve specified output
foreach ($item in $inputTT)
    {
        $outputTT[$item.name.Trim()] = $item.value.Trim()
    }

# Convert ordered dictionary back to JSON and print output
$outputText = $OutputTT | ConvertTo-Json

Write-Output $outputText

<# 

1. The input text that was provided is written in JSON. While working in PowerShell, we'll need to 
convert this text from JSON to an array in order to manipulate the data how we would like. We must
create a variable to store this converted text.

2. After we have updated our variable, we can take this new array and trim the whitespaces from the
provided input text. "AppSettings 2-4" and "Value 2" all had leading whitespaces. Utilizing a foreach
loop allowed all the objects to be formatted correctly. This also allowed for me to specify that only
the name and value were required, omitting the "Slot Setting"

3. Once the format was achieved, items are placed back inside an Ordered Dictionary. I had issues
with this part initially as I was able to achieve the correct format but wrong order of items while
using a hashtable. A quick Google/Stack Overflow search indicated that items in a hashtable can't
be sorted by free will. Using Sort-Object in any section of the code would not change the output of
the final text or any of the variables created throughout the script.

4. Converting the OD back to JSON provided the output text that was desired in the initial documentation

Thoughts/Takeaways

 - The exercise was very fun and challenging! For such a simple task, it really about 6-7 iterations
 of code changes to get things working right

 -This challenge is a great reminder that as developers, we need to maintain our patience. I had to
 step away for 15 minutes before I could come back and arrive at the appropriate solution. Breaks
 definitely help!

#>
