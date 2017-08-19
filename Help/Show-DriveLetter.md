---
external help file: HideWindowsExplorerDrives-help.xml
online version: 
schema: 2.0.0
---

# Show-DriveLetter

## SYNOPSIS
Sets the drive letter to be visible to Windows Explorer.

## SYNTAX

```
Show-DriveLetter [[-DriveLetter] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Makes sure a drive letter is visible to Windows Explorer.
Windows Explorer must be restarted for all changes to take effect.

## EXAMPLES

### Example 1
```
C:\> Show-DriveLetter -DriveLetter C -Verbose
VERBOSE: Showing Drive Letter [C]
VERBOSE: Please restart explorer for changes to take effect
PS C:\> Stop-Process -Name explorer -Verbose -Force
VERBOSE: Performing the operation "Stop-Process" on target "explorer (xxxx)".
```

This example enables the "C" drive to be visible to Explorer and then restarts explorer to show the changes immediately.

## PARAMETERS

### -DriveLetter
The drive letter to show.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Github](https://github.com/dchristian3188/HideWindowsExplorerDrives)