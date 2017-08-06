Describe 'Get-LetterMap' {
    BeforeAll {
        $staticLetters = @{
            A = 1
            B = 2
            C = 4
            D = 8
            E = 16
            F = 32
            G = 64
            H = 128
            I = 256
            J = 512
            K = 1024
            L = 2048
            M = 4096
            N = 8192
            O = 16384
            P = 32768
            Q = 65536
            R = 131072
            S = 262144
            T = 524288
            U = 1048576
            V = 2097152
            W = 4194304
            X = 8388608
            Y = 16777216
            Z = 33554432
        }
        $map = Get-LetterMap
    }

    It 'Has 26 drive letters' {
        $map.Count -eq 26 | Should be $true
    }
    
    foreach($letter in $staticLetters.Keys | Sort-Object)
    {
        It "Has the correct value for $letter" {
            $map[$Letter] -eq $staticLetters[$letter] | Should be $true
        }
    }
}