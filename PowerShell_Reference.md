# Wee PowerShell Reference

*References:*
	>	https://ss64.com/ps/syntax-variables.html
	>	https://ss64.com/ps/if.html
	>	https://technet.microsoft.com/en-us/library/ee692790.aspx
	>	https://stackoverflow.com/questions/7834656/create-log-file-in-powershell
	>	https://stackoverflow.com/questions/17325293/invoke-webrequest-post-with-parameters
	>	https://social.technet.microsoft.com/Forums/ie/en-US/d01408f6-9e61-4d36-8a01-1cb4cde32b51/parsing-results-after-calling-powershell-invokerestmethod?forum=winserverpowershell
	>	https://stackoverflow.com/questions/5095782/find-character-position-and-update-file-name
	>	http://www.tomsitpro.com/articles/powershell-read-xml-files,2-895.html
	>	https://stackoverflow.com/questions/8184167/prompt-for-user-input-in-powershell
	>	https://stackoverflow.com/questions/14061523/do-until-loop-fault
	>	https://stackoverflow.com/questions/2085744/how-to-get-current-username-in-windows-powershell
	>	https://stackoverflow.com/questions/6816450/call-powershell-script-ps1-from-another-ps1-script-inside-powershell-ise
	>	https://stackoverflow.com/questions/2022326/terminating-a-script-in-powershell
	>	https://stackoverflow.com/questions/35722865/how-to-make-a-post-request-using-powershell-if-body-have-a-parameter-type
	>	https://blogs.msdn.microsoft.com/rkramesh/2012/02/01/creating-table-using-powershell/
	>	https://pwrshell.net/ifelse-vs-trycatch/
	>	https://stackoverflow.com/questions/16575419/powershell-retrieve-json-object-by-field-value
	>	https://stackoverflow.com/questions/41829733/how-to-do-a-webrequest-with-json-body-containing-arrays-or-lists
	>	https://gallery.technet.microsoft.com/scriptcenter/Query-CSV-with-SQL-c6c3c7e5
	>	https://stackoverflow.com/questions/37551366/update-json-file-using-powershell
	>	https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-clipboard
	>	https://blogs.technet.microsoft.com/heyscriptingguy/2016/06/27/use-windows-powershell-to-search-for-files/
	>	http://jeffwouters.nl/index.php/2012/03/powershell-howto-calculate-the-number-of-characters-in-a-string/
	>	https://stackoverflow.com/questions/35865272/how-do-i-update-json-file-using-powershell


*Test Automation with Powershell:*
	>	https://gallery.technet.microsoft.com/scriptcenter/Getting-Cookies-using-3c373c7e#content
	>	http://www.westerndevs.com/simple-powershell-automation-browser-based-tasks/
	>	http://ilovepowershell.com/2010/12/27/oneliner-how-to-kill-all-internet-explorer-processes/




Uncomment a line: Use "# "
{code}
	# This line won't be executed
	<#
	The content in between won't be executed either
	#>
{code}

---------------------------------------------------------------------------------------------------

Assign a variable: Use $ to define a varibale and "" to assert the value except numbers
{code}
	$FirstName = "John"
	$Number = 1 + 1
{code}

---------------------------------------------------------------------------------------------------

Print: Use "Write-Host" command
{code}
	Write-Host $FirstName
	Write-Host $Number
	Write-Host "Hello World"
{code}

---------------------------------------------------------------------------------------------------

Wait for a while (here: 5 seconds; denoted by "-s"):
{code}
	Start-Sleep -s 5
{code}

---------------------------------------------------------------------------------------------------

IF THEN ELSE: There is no explicit "Then" written. See https://ss64.com/ps/if.html for the model. To check conditions, use "-eq" instead of "=", which assigns values.
{code}
	IF (condition1)
	{Then part1}
	ELSEIF (condition2)
	{Then part2}
	ELSE
	{Else part}

	$FirstName = "John"
	IF ($FirstName -eq "John"){
		Write-Host "Hallo John"}
	ELSEIF ($FirstName -eq "Jane") {
		Write-Host "Hallo Jane"}
	ELSEIF ($env_input -eq "INT" -or $env_input -eq "Integration" -or $env_input -eq 1)
	ELSE {
		Write-Host "No Smiths here"}

	$name = "Jane"
	IF (-not ($name -eq "John"))
	{Write-Host "Your name is not John"}
	
	ELSE {Write-Host "You must be John"}
{code}

---------------------------------------------------------------------------------------------------

Create Logfile: Log File doesn't have to exist previously. Running the write command again adds a line within the logfile.
{code}
	$Name = "John"
	$Logfile = "C:\git\Powershell_Project\log.txt"

	Function LogWrite {
		Add-content $Logfile -value $Name
	}
	LogWrite
{code}
For relative paths _in same folder_, use $Logfile = "autolog.txt"
For relative paths _downwards_, use $Logfile = ".\logs\autolog.txt"
For relative paths _upwards_, use $Logfile = ".\..\log.txt"

---------------------------------------------------------------------------------------------------

Create and plot a timestamp:
{code}
	$Timestamp = (Get-Date).toString("yyyy-MM-dd HH:mm:ss")
	Write-Host $Timestamp
{code}

---------------------------------------------------------------------------------------------------

Post a Rest API call: See https://stackoverflow.com/questions/17325293/invoke-webrequest-post-with-parameters for the model. Can be expanded to accommodate variables.
{code}
	$postParams = @{username='me';moredata='qwerty'}
	Invoke-WebRequest -Uri http://example.com/foobar -Method POST -Body $postParams

	$username = "jtrautma"
	$postParams = @{
		username=$username;
		moredata='qwerty'}
	Invoke-WebRequest -Uri http://example.com/foobar -Method POST -Body $postParams
{code}

Can be extended to post a JSON body as well. See https://stackoverflow.com/questions/41829733/how-to-do-a-webrequest-with-json-body-containing-arrays-or-lists
{code}
$jsonBody = @{
	username='me';
	password='123'} | ConvertTo-Json
Invoke-RestMethod -Method Post -ContentType 'application/json' -Uri http://example.com/foobar -Body $jsonBody
{code}


---------------------------------------------------------------------------------------------------

Save contents of JSON file into a variable (the variable in the example is called $json)
1) To display a raw data view
	{code}
		Get-Content -Raw -Path <jsonFile>.json | ConvertFrom-Json
	{code}
2) Save the original JSON in the variable, keeping it JSON formatted
	{code}
		$json = Get-Content -Path <jsonFile>.json
		Write-Host $json
	{code}

---------------------------------------------------------------------------------------------------

Post Rest API call with JSON Body (alternatively, replace "Invoke-RestMethod" with "Invoke-WebRequest":
{code}
	$JSON = @'
	{"@type":"login",
	"username":"xxx@gmail.com",
	"password":"yyy"
	}
	'@

	Invoke-RestMethod -Uri "http://somesite.com/oneendpoint" -Method Post -Body $JSON -ContentType "application/json"
{code}

---------------------------------------------------------------------------------------------------

Put the response of a Rest API call into a log file: First create a variable that equals the "invoke web request" call, then transfer that variable's value into the log file.
	{code}
		$username = "jtrautma"
			$postParams = @{
				username=$username;
				moredata='qwerty'}
			$Response = Invoke-WebRequest -Uri http://example.com/foobar -Method POST -Body $postParams

		$Logfile = "C:\git\Powershell_Project\log.txt"
		Function LogWrite {
			Add-content $Logfile -value $Response
		}
		LogWrite
	{code}

---------------------------------------------------------------------------------------------------
Find character position in a variable (we wanna find the PC name):
	{code}
		$myString = "237801_201011221155.xml"
		$startPos = $myString.LastIndexOf("_") + 1 # Do not include the "_" character
		$subString = $myString.Substring($startPos,$myString.Length - $startPos)
		Write-Host $subString
	{code}

---------------------------------------------------------------------------------------------------

Extract information (here: user ID) from an XML file by using "dot notation" to navigate through the XML structure:
	{code}
		[xml]$XmlDocument = Get-Content -Path C:\git\CreateUser\new_log.xml
		$XmlDocument.rsp.api_data.user_id
	{code}
	Output is the user ID

---------------------------------------------------------------------------------------------------

Extract information (here: user ID) from a Rest API response that is being delivered as XML by using "dot notation" to navigate through the XML structure:
	{code}
		[xml]$Response = Invoke-WebRequest -Uri http://example.com/foobar -Method POST -Body $postParams
		$user_id = $Response.rsp.api_data.user_id
		Write-Host $user_id
	{code}
	Output is the user ID, which is also saved in a variable

---------------------------------------------------------------------------------------------------

Retrieve JSON object by field (from: https://stackoverflow.com/questions/16575419/powershell-retrieve-json-object-by-field-value)
1) Let our JSON file look like this
	{code}
		$json = @"
		{
		"Stuffs": 
			[
				{
					"Name": "Darts",
					"Type": "Fun Stuff"
				},

				{
					"Name": "Clean Toilet",
					"Type": "Boring Stuff"
				}
			]
		}
		"@
	{code}
2a) Let's drill down to the data (entire content)
	{code}
		$x = $json | ConvertFrom-Json
		$x.Stuffs[0] # access to Darts
		$x.Stuffs[1] # access to Clean Toilet
		$darts = $x.Stuffs | where { $_.Name -eq "Darts" } #Darts
	{code}
2b) Let's drill down to the data (selected content)
	{code}
		$x = $json | ConvertFrom-Json
		Write-Host $x.Stuffs[0].Name, $x.Stuffs[0].Type # access to Darts
		Write-Host $x.Stuffs[1].Name, $x.Stuffs[1].Type # access to Clean Toilet
		$darts = $x.Stuffs | where { $_.Name -eq "Darts" } #Darts
	{code}
Output is @{Name=Darts; Type=Fun Stuff}
2c) Let's drill down to the data (selected content as quasi table)
	{code}
		$x = $json | ConvertFrom-Json
		ForEach ($Stuffs in $x.Stuffs) {
			Write-Host $Stuffs.Name"	|	"$Stuffs.Type
		}
	{code}

---------------------------------------------------------------------------------------------------

Writing a very comprehensive log:
	{code}
		$email = "testmail@gmail.com"
		$user_id = 21864843
		$timestamp = (Get-Date).toString("yyyy-MM-dd HH:mm:ss")
		$combo = "$timestamp			$email							$user_id"

		Write-Host "Account created"
		Write-Host "	Timestamp:"$user_id
		Write-Host "	E-Mail address:"$email
		Write-Host "	SSO User ID:"$timestamp
		Write-Host "Combo output"
		Write-Host $combo

		$Logfile = "C:\git\Powershell_Project\log.txt"
		Function LogWrite {
			Add-content $Logfile -value $combo
		}
		LogWrite
	{code}

---------------------------------------------------------------------------------------------------

Constructing a variable of different parts:
	{code}
		$email_front = "testmail"
		$email_back = "@gmail.com"
		$email = $email_front+$email_back
		Write-Host $email
	{code}

---------------------------------------------------------------------------------------------------

Promt user input and record the response in a variable:
	{code}
		$name = Read-Host 'What is your username?'
		Write-Host $name
	{code}

---------------------------------------------------------------------------------------------------

Do Until Loop (here: Repeat the question until user keys in D or E; doesn't have to be capitalized)
	{code}
		do{
		$ActionVariable = Read-Host "Do you want to delete a folder or empty a folder ? [D/E]"
		}
		until($ActionVariable -in 'E', 'D')
	{code}

---------------------------------------------------------------------------------------------------

Get my Windows user name and the domain I am using:
	{code}
		[System.Security.Principal.WindowsIdentity]::GetCurrent().Name
	{code}

---------------------------------------------------------------------------------------------------

Make one Powershell script execute another one (In this case it will launch "file2.ps1" which is assumed to be in the same folder). Script 2 inherits variables from script 1. Afterwards it will return to original script (variable modifications are not passed back):
{code}
	& ".\file2.ps1"
{code}

---------------------------------------------------------------------------------------------------

Make Powershell squeeze a file in between the current file (e.g. a lookup table) by using a period to indicate the other file:
	{code}
		Write-Host "Select your destination"
		. D:\tables\holidayDestinations.ps1
		Write-Host "Where would you like to go?"
	{code}

---------------------------------------------------------------------------------------------------

Skipping the rest of the code and terminating the script:
	{code}
		exit
	{code}

---------------------------------------------------------------------------------------------------

Determine the MD5 hash of a variable "userId"
{code}
	$userId = 21864843
	$md5 = new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
	$utf8 = new-object -TypeName System.Text.UTF8Encoding
	$hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes($userId))) -replace '-',''
	$hash = $hash.ToLower()
	Write-Host "Your hashed MD5 UserId:"$hash
{code}

---------------------------------------------------------------------------------------------------

Create a full scale table
{code}
	$tabName = "SampleTable"

	#Create Table object
	$table = New-Object system.Data.DataTable "$tabName"

	#Define Columns
	$col1 = New-Object system.Data.DataColumn Product_Key,([string])
	$col2 = New-Object system.Data.DataColumn Product_Name,([string])
	$col3 = New-Object system.Data.DataColumn Product_Owner,([string])

	#Add the Columns
	$table.columns.add($col1)
	$table.columns.add($col2)
	$table.columns.add($col3)

	#Create a row
	$row1 = $table.NewRow()
	$row2 = $table.NewRow()

	#Enter data in the row
	$row1.Product_Key = "HR"
	$row1.Product_Name = "Hausratversicherung"
	$row1.Product_Owner = "Keith Urban"
	$row2.Product_Key = "RS"
	$row2.Product_Name = "Rechtsschutzversicherung"
	$row2.Product_Owner = "Till Lindemann"

	#Add the row to the table
	$table.Rows.Add($row1)
	$table.Rows.Add($row2)

	#Display the table
	$table | format-table -AutoSize
{code}

---------------------------------------------------------------------------------------------------

Convert upper case letters to lower case and vice versa
{code}
	$name1 = "JAN"
	$name1 = $name1.ToLower()
	Write-Host "Name1 is"$name1

	$name2 = "jan"
	$name2 = $name2.ToUpper()
	Write-Host "Name2 is"$name2
{code}

---------------------------------------------------------------------------------------------------

Omit special characters from a text
{code}
	$text1 = "1A-2B-3C-4D-5E"
	$text2 = $text1 -replace '-',''
	Write-Host $text2
{code}

---------------------------------------------------------------------------------------------------

Determine the type of value inside a variable
{code}
	$number = 123
	$name = "Jan"
	$number.GetType() #All information regarding $number
	$name.GetType() #All information regarding $name
	$number.GetType().Name #Only the type name of $number
	$name.GetType().Name #Only the type name of $name
{code}

---------------------------------------------------------------------------------------------------

Catch error before it terminates script execution
For that we use the "Try"/"Catch"/"Finally" methods ("Finally" is optional)
{code}
	TRY {
		Test-Path Z:
	}
	CATCH {
		"Drive NOT exists"
	}
	FINALLY {
		"Hello World"
	}
{code}

---------------------------------------------------------------------------------------------------

Importing a comma separated CSV table "offices.csv" into a variable "$table"
{CSV}
id,city,state
123,Dallas,Texas
456,Nashville,Tennessee
789,Atlanta,Georgia
{CSV}

{code}
	$table = Import-Csv .\offices.csv -Delimiter ","
{code}

Counting all its rows
{code}
	$table.Count
{code}

Query for Dallas office
{code}
	$table | where {$_.city -eq "Dallas"}
{code}

Find out which ID the Atlanta office has
{code}
	Write-Output $table | where {$_.city -eq "Atlanta"} | select {$_.id}
{code}

Display entire table
{code}
	$table | where {$_}
{code}

Hide table headers to save content into a variable
{code}
	$product_name = $productTable | where {$_.productKey -eq "un"} | select {$_.longName} | ft -HideTableHeaders
{code}

This, however, saves it with a few empty lines
{code}
	$product_name | Measure-Object -Line
{code}


---------------------------------------------------------------------------------------------------

Query JSON content: What is the value in field "connectionString"?
Let the JSON file "practice.json" be
{JSON}
{
    "policies": {
        "Framework.DataContext": {
            "connectionString": "Server1.intern"
        }
    }
}
{JSON}

{code}
	$json = Get-Content -Path ".\practice.json" | ConvertFrom-Json
	$connectionString = $json | select -expand policies | select -expand Framework.DataContext | select -expand connectionString
	Write-Host $connectionString
{code}

---------------------------------------------------------------------------------------------------

Edit JSON content in a JSON file through powershell script
Let the JSON file "practice.json" be as above and update the value for "connectionString" to "HelloWorld", then save it.
{code}
	$pathToJson = ".\practice.json"
	$json = Get-Content $pathToJson -Raw | ConvertFrom-Json
	$json.policies.'Framework.DataContext'.connectionString = "Hello World, test successful"
	$json | ConvertTo-Json | set-content $pathToJson
{code}

---------------------------------------------------------------------------------------------------

Conditional JSON updating
(Source: https://stackoverflow.com/questions/35865272/how-do-i-update-json-file-using-powershell)
Let JSON file "update.json" be
{
    "update": [
        {
            "Name": "test1",        
            "Version": "2.1"
        },
        {
            "Name": "test2",        
            "Version": "2.1"
        }   
    ]
}
Goal: Update version number if name is test1
{code}
$a = Get-Content 'D:\temp\mytest.json' -raw | ConvertFrom-Json
$a.update | % {if($_.name -eq 'test1'){$_.version=3.0}}
$a | ConvertTo-Json | set-content 'D:\temp\mytestBis.json'
{code}

---------------------------------------------------------------------------------------------------





Natively Query CSV with SQL Syntax and PowerShell
	See http://www.powershellmagazine.com/2015/05/12/natively-query-csv-files-using-sql-syntax-in-powershell/

---------------------------------------------------------------------------------------------------

Add content to the Windows clipboard to be pasted somewhere else
{code}
Set-Clipboard -Value "This is a test string"
{code}

---------------------------------------------------------------------------------------------------

Wait for user to press any key (Source: https://blogs.technet.microsoft.com/heyscriptingguy/2013/09/14/powertip-use-powershell-to-wait-for-a-key-press/)
{code}
	$HOST.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | OUT-NULL
	$HOST.UI.RawUI.Flushinputbuffer()
{code}

---------------------------------------------------------------------------------------------------

Count the number of characters in a string (will return 3)
{code}
$string = "Jan"
$string | measure-object -character | select -expandproperty characters
{code}

---------------------------------------------------------------------------------------------------

Retrieving all input fields from a website for test automation
(Source: http://www.westerndevs.com/simple-powershell-automation-browser-based-tasks/)
{code}
$processName = "chrome"
$site = "https://kundenbereich.check24.de/user/login.html"
$site = "https://login.bo.v.check24-test.de/ad-login/login/"
sleep -s 10
$wnd = Start-Process $processName $site -PassThru
sleep -s 20
$Test = Invoke-WebRequest -URI $Site
# $Test.InputFields # produces long output but with details
$Test.Forms.
{code}

---------------------------------------------------------------------------------------------------

Quite Internet Explorer isnatnces
(Source: http://ilovepowershell.com/2010/12/27/oneliner-how-to-kill-all-internet-explorer-processes/)
{code}
get-process iexplore | stop-process
{code}


