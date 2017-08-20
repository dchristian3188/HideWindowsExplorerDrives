InModuleScope HideWindowsExplorerDrives {
    Describe 'Hide-DriveLetter' {
        Mock Test-ISadmin {$true}
        Context 'Drive Not Hidden' {
            Mock Set-HiddenDriveValue {}
            Mock Get-HiddenDriveValue { return 0}
            Mock Get-DriveStatus {
                [PSCustomObject]@{
                    DriveLetter = 'C'
                    IsHidden    = $false
                }
            }

            It 'Should hide the drive letter' {
                Hide-DriveLetter -DriveLetter C
                Assert-MockCalled -CommandName Set-HiddenDriveValue -Times 1
            }
        }
        Context 'Drive Already Hidden' {
            Mock Set-HiddenDriveValue {}
            Mock Get-HiddenDriveValue { return 0}
            Mock Get-DriveStatus {
                [PSCustomObject]@{
                    DriveLetter = 'C'
                    IsHidden    = $true
                }
            }

            It 'Should not try to hide the drive letter' {
                Hide-DriveLetter -DriveLetter C
                Assert-MockCalled -CommandName Set-HiddenDriveValue -Times 0
            }
        }
    }
}