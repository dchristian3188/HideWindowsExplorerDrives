---
external help file: HideWindowsExplorerDrives-help.xml
online version: 
schema: 2.0.0
---

# Hide-DriveLetter

## SYNOPSIS
Hides a drive letter from Windows Explorer.

## SYNTAX

```
Hide-DriveLetter [[-DriveLetter] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Hides a drive letter from Windows Explorer.
Windows Explorer must be reset for all changes to take effect.

## EXAMPLES

### Example 1
```
PS C:\> Hide-DriveLetter -DriveLetter C -Verbose
VERBOSE: Hidding Drive Letter [C]
VERBOSE: Please restart explorer for changes to take effect
PS C:\> Stop-Process -Name explorer -Verbose -Force
VERBOSE: Performing the operation "Stop-Process" on target "explorer (xxxx)".
```

This example hides the "C" drive and then restarts explorer to show the changes immediately.

## PARAMETERS

### -DriveLetter
The drive letter to hide.

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

