if (Get-Command -Name Get-Partition)
{
    $type = 'Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/Storage/MSFT_Partition'
    
    $TypeData = @{
        TypeName   = $type
        MemberType = 'ScriptProperty'
        MemberName = 'IsHidden'
        Value      = {
            (Get-DriveStatus -DriveLetter $this.DriveLetter).IsHidden
        }
    }
    Update-TypeData @TypeData -Force
    
    $TypeData = @{
        TypeName   = $type
        MemberType = 'ScriptMethod'
        MemberName = 'HidePartition'
        Value      = {
            Hide-DriveLetter -DriveLetter $this.DriveLetter
        }
    }
    Update-TypeData @TypeData -Force
    
    $TypeData = @{
        TypeName   = $type
        MemberType = 'ScriptMethod'
        MemberName = 'ShowPartition'
        Value      = {
            Show-DriveLetter -DriveLetter $this.DriveLetter
        }
    }
    Update-TypeData @TypeData -Force
    
}
