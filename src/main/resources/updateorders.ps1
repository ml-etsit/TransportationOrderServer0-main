# Read the content of the JSON file line by line and convert each line to a JSON object
$jsonArray = Get-Content -Path "orders.json" | ForEach-Object { $_ | ConvertFrom-Json }

# Define the base URI
$baseUri = "http://localhost:8080/transportationorders"
$headers = @{ "Content-Type" = "application/json" }

# Iterate through each JSON object and send a separate request
foreach ($jsonObject in $jsonArray) {
  $uri = $baseUri
  $body = $jsonObject | ConvertTo-Json
  Invoke-RestMethod -Uri $uri -Method Put -Body $body -Headers $headers
}