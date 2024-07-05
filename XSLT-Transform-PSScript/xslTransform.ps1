param(
    [parameter(Mandatory = $true)]
    [Alias("s")]
    [string]$source,

    [parameter(Mandatory = $true)]
    [Alias("x")]
    [string]$xslt,

    [parameter(Mandatory = $true)]
    [Alias("o")]
    [string]$dest
)
#Initialize XML Reader
$xmlReader = [System.Xml.XmlReader]::create("$(Get-Location)\$source")

$xmlsettings = New-Object System.Xml.XmlWriterSettings
$xmlsettings.Indent = $true                         # Set as $false to prevent indentation in destination or decrease file size
$xmlsettings.OmitXmlDeclaration = $false            # Set as $true to remove XML declaration in output
$xmlWriter = [System.XML.XmlWriter]::Create("$(Get-Location)\$dest", $xmlsettings)

$xsltransform = New-Object System.Xml.Xsl.XslCompiledTransform
$xsltransform.Load("$(Get-Location)\$($xslt)")

$arglist = new-object System.Xml.Xsl.XsltArgumentList
$xsltransform.Transform($xmlReader, $arglist, $xmlWriter)