---
external help file: HideWindowsExplorerDrives-help.xml
online version: 
schema: 2.0.0
---

# Get-DriveStatus

## SYNOPSIS
Gets drive letters and their visibility status to Windows Explorer.

## SYNTAX

```
Get-DriveStatus [[-DriveLetter] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Windows explorer has the ability to hide drives from the user.
This cmdlet returns drive letters and their visibility status.

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

Returns the hidden status of the C drive.

## PARAMETERS

### -DriveLetter
Drive letter to display. If drive letter not present, all drives returned.

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
