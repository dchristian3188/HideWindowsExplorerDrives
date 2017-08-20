task . Clean, Build, Tests, ExportHelp, GenerateGraph, WriteStats
task Tests ImportCompipledModule, Pester
task CreateManifest copyPSD, UpdatPublicFunctionsToExport, UpdateDSCResourceToExport
task Build Compile, CreateManifest
task Stats RemoveStats, WriteStats

$script:ModuleName = Split-Path -Path $PSScriptRoot -Leaf
$script:ModuleRoot = $PSScriptRoot
$script:OutPutFolder = "$PSScriptRoot\Output"
$script:ImportFolders = @('Public', 'Internal', 'Classes', 'DSCResources', 'TypeExtensions')
$script:PsmPath = Join-Path -Path $PSScriptRoot -ChildPath "Output\$($script:ModuleName)\$($script:ModuleName).psm1"
$script:PsdPath = Join-Path -Path $PSScriptRoot -ChildPath "Output\$($script:ModuleName)\$($script:ModuleName).psd1"
$script:HelpPath = Join-Path -Path $PSScriptRoot -ChildPath "Output\$($script:ModuleName)\en-US"
$script:PublicFolder = 'Public'
$script:DSCResourceFolder = 'DSCResources'


task "Clean" {
    if (-not(Test-Path $script:OutPutFolder))
    {
        New-Item -ItemType Directory -Path $script:OutPutFolder > $null
    }

    Remove-Item -Path "$($script:OutPutFolder)\*" -Force -Recurse
}

$compileParams = @{
    Inputs = {
        foreach ($folder in $script:ImportFolders)
        {
            Get-ChildItem -Path $folder -Recurse -File -Filter '*.ps1'
        }
    }

    Output = {
        $script:PsmPath
    }
}

task Compile @compileParams {
    if (Test-Path -Path $script:PsmPath)
    {
        Remove-Item -Path $script:PsmPath -Recurse -Force
    }
    New-Item -Path $script:PsmPath -Force > $null

    foreach ($folder in $script:ImportFolders)
    {
        $currentFolder = Join-Path -Path $script:ModuleRoot -ChildPath $folder
        Write-Verbose -Message "Checking folder [$currentFolder]"

        if (Test-Path -Path $currentFolder)
        {
            $files = Get-ChildItem -Path $currentFolder -File -Filter '*.ps1'
            foreach ($file in $files)
            {
                Write-Verbose -Message "Adding $($file.FullName)"
                Get-Content -Path $file.FullName >> $script:PsmPath
            }
        }
    }
}

task CopyPSD {
    $copy = @{
        Path        = "$($script:ModuleName).psd1"
        Destination = $script:PsdPath
        Force       = $true
    }
    Copy-Item @copy
}

task UpdatPublicFunctionsToExport -if (Test-Path -Path $script:PublicFolder) {
    $publicFunctions = (Get-ChildItem -Path $script:PublicFolder |
            Select-Object -ExpandProperty BaseName) -join "', '"

    $publicFunctions = "FunctionsToExport = @('{0}')" -f $publicFunctions

    (Get-Content -Path $script:PsdPath) -replace "FunctionsToExport = '\*'", $publicFunctions |
        Set-Content -Path $script:PsdPath
}

task UpdateDSCResourceToExport -if (Test-Path -Path $script:DSCResourceFolder) {
    $resources = (Get-ChildItem -Path $script:DSCResourceFolder |
            Select-Object -ExpandProperty BaseName) -join "', '"

    $resources = "'{0}'" -f $resources

    (Get-Content -Path $script:PsdPath) -replace "'_ResourcesToExport_'", $resources |
        Set-Content -Path $script:PsdPath
}

task ImportCompipledModule {
    Get-Module -Name $script:ModuleName |
        Remove-Module -Force
    Import-Module -Name $script:PsdPath -Force
}

task Pester {
    $resultFile = "{0}\testResults{1}.xml" -f $script:OutPutFolder, (Get-date -Format 'yyyyMMdd_hhmmss')
    $testFolder = Join-Path -Path $PSScriptRoot -ChildPath 'Tests\*'
    Invoke-Pester -Path $testFolder -OutputFile $resultFile -OutputFormat NUnitxml
}

task GenerateGraph -if (Test-Path -Path 'Graphs') {
    $Graphs = Get-ChildItem -Path "Graphs\*"
   
    Foreach ($graph in $Graphs)
    {
        $graphLocation = [IO.Path]::Combine($script:OutPutFolder, $script:ModuleName, "$($graph.BaseName).png")
        . $graph.FullName -DestinationPath $graphLocation -Hide
    }
}

task RemoveStats -if (Test-Path -Path "$($script:OutPutFolder)\stats.json") {
    Remove-Item -Force -Verbose -Path "$($script:OutPutFolder)\stats.json" 
}

task WriteStats {
    $folders = Get-ChildItem -Directory | 
        Where-Object {$PSItem.Name -ne 'Output'}
    
    $stats = foreach ($folder in $folders)
    {
        Get-Content -Path "$folder\*" | 
            Measure-Object -Word -Line -Character | 
            Select-Object -Property @{N = "FolderName"; E = {$folder.Name}}, Words, Lines, Characters
    }
    $stats | ConvertTo-Json > "$script:OutPutFolder\stats.json"

}

task ExportHelp -if (Test-Path -Path "$script:ModuleRoot\Help") {
    New-ExternalHelp -Path "$script:ModuleRoot\Help" -OutputPath $script:HelpPath
}