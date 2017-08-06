Function Get-LetterMap
{
    $letterMap = @{}
    1..26 | ForEach-Object {
        $currentNumber = $_
        [string]$letter = [char]($currentNumber + 64)
        $driveValue = [math]::Pow(2, ($currentNumber - 1))
        $letterMap[$letter] = $driveValue
    }
    $letterMap
}
