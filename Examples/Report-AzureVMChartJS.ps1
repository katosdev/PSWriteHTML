cls
Remove-Module ReportHTML
Import-Module C:\Users\matt.quickenden\Documents\GitHub\AzureFieldNotes\ReportHTML\ReportHTML\ReportHTML.psd1
Get-Module reportHTML



#
#
##Login-AzureRmAccount;$VMs = get-azurermvm
#$VMBreakdowns = @()
#foreach ($vm in $vms) {
#	$VMBreakdown = '' | select ResourceGroup, ID, VMName, Size, location, StorageAccount
#	$VMBreakdown.ResourceGroup = $vm.ResourceGroupName
#	$VMBreakdown.ID = $vm.Id
#	$VMBreakdown.VMName = $vm.Name
#	$VMBreakdown.location = $vm.location 
#	$VMBreakdown.Size = $vm.HardwareProfile.VmSize
#	$VMBreakdown.StorageAccount = ($vm.StorageProfile.OsDisk.Vhd.Uri.Split('.')[0]).split('//')[2]
#	$VMBreakdowns += $VMBreakdown
#}
#
#$VMSize = $VMBreakdowns | group size
#



$rpt = @()
$rpt += Get-HtmlOpenpage -TitleText "Azure VM Sizing"
$rpt += Get-HtmlContentOpen -HeaderText "Azure VM Report"
$rpt += Get-HTMLColumn1of2
$PieObject = Get-HTMLPieChartobject -charttype doughnut
$PieObject.ChartStyle.ColorSchemeName= 'ColorScheme3'
$rpt += Get-HTMLPieChart -DataSet $VMSize -chartobject $PieObject
$rpt += Get-HTMLColumnClose
$rpt += Get-HTMLColumn2of2
$rpt += Get-HTMLBarChart -DataSet $VMSize -chartobject (Get-HTMLBarChartobject)
$rpt += Get-HTMLColumnClose
$rpt += get-htmlcontenttable ($VMSize | select Name, count)
$rpt += Get-HtmlContentClose
$rpt += Get-HtmlClosePage


new-htmlreport -ReportContent $rpt -ReportName "testit" -ReportPath c:\temp


