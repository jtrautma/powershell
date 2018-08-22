$bingUrl = "https://www.bing.com/search?q="
$ie = new-object -ComObject "InternetExplorer.Application"
$ie.visible = $true
$ie.silent = $true
$counter = 0

$array = @(
	"Denver+Broncos",
	"NYC+Subway",
	"Burger+King"
	)

foreach ($i in $array){
	$current_url = "$bingUrl$i"
	Write-Host "Will test URL" $current_url
	$ie.navigate($current_url)
	while($ie.Busy) { Start-Sleep -Milliseconds 100 }
	Start-Sleep -s 5
	###
	## $ie.navigate("https://www.cnbc.com")
	## while($ie.Busy) { Start-Sleep -Milliseconds 100 }
	## Start-Sleep -s 5
	###
	$counter = $counter+1
}
Write-Host "--------------------------------------------"
Write-Host "FINISHED"
Write-Host $counter "Bing visits"

$ie.quit()
