---
external help file: HideWindowsExplorerDrives-help.xml
online version: 
schema: 2.0.0
---

# Get-DriveStatus

## SYNOPSIS
Gets the current hidden status of the drives.

## SYNTAX

```
Get-DriveStatus [[-DriveLetter] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Gets the current hidden status of the windows drive.

## EXAMPLES

### Example 1
```
PS C:\> Get-DriveStatus

DriveLetter IsHidden
----------- --------
A              False
B              False
C              False
D              False
E              False
F              False
...
```

Returns the hidden status of all the drives.

### Example 2
```
PS C:\> Get-DriveStatus -DriveLetter C

DriveLetter IsHidden
----------- --------
C              False
```

Returns the hidden status of all the drives.

## PARAMETERS

### -DriveLetter
{{Fill DriveLetter Description}}

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

