# Define file path
$data_file_path = "$env:USERPROFILE\rpsls_data.txt"

# Create file if it doesn't exist
if (!(Test-Path -Path $data_file_path)) {
    New-Item -Path $data_file_path -ItemType file
}



# Initialize variables
$user_choice_history = @()
$rock_weight = 1
$paper_weight = 1
$scissors_weight = 1
$lizard_weight = 1
$spock_weight = 1
$compy_choice = ''

# Load learned data from file (if it exists)
if (Test-Path -Path $data_file_path) {
    $data = Get-Content -Path $data_file_path -Raw

   

    # Check if $data is not null or empty
    if ($null -ne $data -and $data -ne '') {
        $user_choice_history = $data.Split(",")[0]
        $rock_weight = $data.Split(",")[1]
        $paper_weight = $data.Split(",")[2]
        $scissors_weight = $data.Split(",")[3]
        $lizard_weight = $data.Split(",")[4]
        $spock_weight = $data.Split(",")[5]
        $compy_choice = $data.Split(",")[6]
    }
}

$i = 0

$compy_wins = 0
$user_wins = 0
do {
    Write-Host "Let's play rock, paper, scissors, lizard, Spock.  Do you know how to play?" -ForegroundColor Blue
    $rules = Read-Host

    if ($rules -eq 'no' -or $rules -eq 'n') {
        Write-Host 'We each decide if we are going to pick rock, paper, scissors, lizard or spock secretly, then we reveal what we picked.' -ForegroundColor Blue
        Start-Sleep 1
        Write-Host 'Rock crushes scissors and lizard.' -ForegroundColor Blue
        Start-Sleep 1
        Write-Host 'Paper disproves Spock and covers rock.' -ForegroundColor Blue
        Start-Sleep 1
        Write-Host 'Scissors decapitates lizard and cuts paper.' -ForegroundColor Blue
        Start-Sleep 1
        Write-Host 'Lizard eats paper and poisons Spock.' -ForegroundColor Blue
        Start-Sleep 1
        Write-Host 'Spock smashes scissors and vaporizes rock.' -ForegroundColor Blue
        Start-Sleep 1
        Write-Host 'Best 2 out of 3 wins.' -ForegroundColor Blue
        Start-Sleep 1
    }
    elseif ($rules -eq 'yes' -or $rules -eq 'y') {
        Write-Host "Let's play!" -ForegroundColor Blue
    }
    else {
        $random = Get-Random -Minimum 0 -Maximum 9 
        $result = switch ($random) {
            0 { 'A simple yes or no would have been fine' }
            1 { 'Que?  No entiendes ingles?' }
            2 { 'You have seen much, but do you understand?  Obviously not.' }
            3 { 'You donut!' }
            4 { 'per aspera ad astra' }
            5 { 'mors mortem parit' }
            6 { 'lux e tenebris' }
            7 { '6c6762' }
            8 { '死者を思い出す' }
            9 { '鬼滅の刃' }
            Default { 'chi non fa, non falla' }
        }
        
        Write-Host $result
        Start-Sleep 2
        exit
    }

    $game_count = 0
    $compy_game_wins = 0
    $user_game_wins = 0
    # $last_user_choice = ''
    # $last_compy_choice = ''


    do {
       

        Write-Host 'I am choosing' -ForegroundColor Red

        

        # Load learned data from file (if it exists)
        if (Test-Path -Path $data_file_path) {
            $data = Get-Content -Path $data_file_path -Raw

            # ********Write-Host 'Data 2: ' $data

            # Check if $data is not null or empty
            if ($null -ne $data -and $data -ne '') {
                $user_choice_history = $data.Split(",")[0]
                $rock_weight = $data.Split(",")[1]
                $paper_weight = $data.Split(",")[2]
                $scissors_weight = $data.Split(",")[3]
                $lizard_weight = $data.Split(",")[4]
                $spock_weight = $data.Split(",")[5]
            }
        }

        # *******Write-Host 'after data load'
    
        # Save learned data to file
        $data = ($user_choice_history | ConvertTo-Csv -NoTypeInformation) + "," + $rock_weight + "," + $paper_weight + "," + $scissors_weight + "," + $lizard_weight + "," + $spock_weight
        # *******Write-Host 'Data 3: ' $data
    
        Set-Content -Path $data_file_path -Value $data -Force

        
        # do {
        # Analyze user choice history
        foreach ($choice in $user_choice_history) {
            # ***** Write-Host 'Choice 1 ****: ' $choice
            # ***** Write-Host 'user choice history:  '   $user_choice_history
            # ****  Start-sleep 1
            switch ($choice) {
                "rock" { $rock_weight += 5 }
                "paper" { $paper_weight += 5 }
                "scissors" { $scissors_weight += 5 }
                "lizard" { $lizard_weight += 5 }
                "spock" { $spock_weight += 5 }
            }
        }

        # ****  Write-Host 'Out of foreach loop'

        # Adjust weights based on past results
        if ($compy_choice -eq 'rock' -and $user_choice -eq 'paper') {
            $rock_weight -= 3
        }
        elseif ($compy_choice -eq 'paper' -and $user_choice -eq 'scissors') {
            $paper_weight -= 3
        }

        # Select computer choice based on weighted random selection
        if ($compy_choice -lt $rock_weight) {
            $compy_choice = 'rock'
        }
        elseif ($compy_choice -lt ($rock_weight + $paper_weight)) {
            $compy_choice = 'paper'
        }
        elseif ($compy_choice -lt ($rock_weight + $paper_weight + $scissors_weight)) {
            $compy_choice = 'scissors'
        }
        elseif ($compy_choice -lt ($rock_weight + $paper_weight + $scissors_weight + $lizard_weight)) {
            $compy_choice = 'lizard'
        }
        else {
            $compy_choice = 'spock'
        }

        # Add chosen option to history
        $user_choice_history += $user_choice

        # Analyze user choice history
        foreach ($choice in $user_choice_history) {
            # ****** Write-Host 'Choice 2: ' $choice
            #  ****** Start-Sleep 1
            switch ($choice) {
                "rock" { $rock_weight += 5 }
                "paper" { $paper_weight += 5 }
                "scissors" { $scissors_weight += 5 }
                "lizard" { $lizard_weight += 5 }
                "spock" { $spock_weight += 5 }
            }
        }
            
        # *** Write-Host 'Out of foreach loop 2'

        # Adjust weights based on past results
        if ($compy_choice -eq 'rock' -and $user_choice -eq 'paper') {
            $rock_weight -= 3
        }
        elseif ($compy_choice -eq 'paper' -and $user_choice -eq 'scissors') {
            $paper_weight -= 3
        }

        # Select computer choice based on weighted random selection
        # Convert weights to integers
        $rock_weight = [int]$rock_weight
        $paper_weight = [int]$paper_weight
        $scissors_weight = [int]$scissors_weight
        $lizard_weight = [int]$lizard_weight
        $spock_weight = [int]$spock_weight

        # Select computer choice based on weighted random selection
        $random = Get-Random -Minimum 0 -Maximum ($rock_weight + $paper_weight + $scissors_weight + $lizard_weight + $spock_weight)

        if ($random -lt $rock_weight) {
            $compy_choice = 'rock'
        }
        elseif ($random -lt ($rock_weight + $paper_weight)) {
            $compy_choice = 'paper'
        }
        elseif ($random -lt ($rock_weight + $paper_weight + $scissors_weight)) {
            $compy_choice = 'scissors'
        }
        elseif ($random -lt ($rock_weight + $paper_weight + $scissors_weight + $lizard_weight)) {
            $compy_choice = 'lizard'
        }
        else {
            $compy_choice = 'spock'
        }
        # ****** Write-Host 'Done with Adjust weights'

        # Add chosen option to history
        $user_choice_history += $user_choice

        # } while ($game_count -lt 3)  

        Write-Host 'I am choosing' -ForegroundColor Blue
        Start-sleep 2
        Write-Host "I have my choice"
        Start-Sleep 1
        Write-Host 'What will you choose?  You can enter "r" for rock, "p" for paper, "sc" for scissors, "l" for lizard or "sp" for spock.' -ForegroundColor Blue
        $user_choice = Read-Host
        
        switch -Wildcard ($user_choice) {
            { $_ -like 'r*' } { $user_choice = 'rock' }
            { $_ -like 'p*' } { $user_choice = 'paper' }
            { $_ -like 'sc*' } { $user_choice = 'scissors' }
            { $_ -like 'l*' } { $user_choice = 'lizard' }
            { $_ -like 'sp*' } { $user_choice = 'spock' }
            Default { $user_choice = 'invalid' }
        }

        #$last_user_choice = $user_choice

        Write-Host 'Ready?' -ForegroundColor Blue
        Start-Sleep 2
        Write-Host 'Rock, paper scissors, shoot!' -ForegroundColor Blue
        Start-Sleep 1
        if ($compy_choice -eq 'rock' -and $user_choice -eq 'rock') {
            Write-Host "It is a tie!  I chose $compy_choice and you chose $user_choice." 
        }
        elseif ($compy_choice -eq 'rock' -and $user_choice -eq 'paper') {
            Write-Host "You win!  I chose $compy_choice and you chose $user_choice." -ForegroundColor Green
            $user_game_wins += 1 
        }
        elseif ($compy_choice -eq 'rock' -and $user_choice -eq 'spock' ) {
            Write-Host "You win!  I chose $compy_choice and you chose $user_choice." -ForegroundColor Green
            $user_game_wins += 1 
        }
        elseif ($compy_choice -eq 'rock' -and $user_choice -eq 'lizard') {
            Write-Host "I win!  I chose $compy_choice and you chose $user_choice." -ForegroundColor Red
            $compy_game_wins += 1
        }
        elseif ($compy_choice -eq 'rock' -and $user_choice -eq 'scissors' ) {
            Write-Host "I win!  I chose $compy_choice and you chose $user_choice." -ForegroundColor Red
            $compy_game_wins += 1
        }
        elseif ($compy_choice -eq 'paper' -and $user_choice -eq 'paper') {
            Write-Host "It is a tie!  I chose $compy_choice and you chose $user_choice."
        }
        elseif ($compy_choice -eq 'paper' -and $user_choice -eq 'scissors') {
            Write-Host "You win!  I chose $compy_choice and you chose $user_choice." -ForegroundColor Green
            $user_game_wins += 1
        }
        elseif ($compy_choice -eq 'paper' -and $user_choice -eq 'lizard' ) {
            Write-Host "You win!  I chose $compy_choice and you chose $user_choice." -ForegroundColor Green
            $user_game_wins += 1
        }
        elseif ($compy_choice -eq 'paper' -and $user_choice -eq 'rock') {
            Write-Host "I win!  I chose $compy_choice and you chose $user_choice." -ForegroundColor Red
            $compy_game_wins += 1
        }
        elseif ($compy_choice -eq 'paper' -and $user_choice -eq 'spock') {
            Write-Host "I win!  I chose $compy_choice and you chose $user_choice." -ForegroundColor Red
            $compy_game_wins += 1
        }
        elseif ($compy_choice -eq 'scissors' -and $user_choice -eq 'scissors' ) {
            Write-Host "It is a tie!  I chose $compy_choice and you chose $user_choice."
        }
        elseif ($compy_choice -eq 'scissors' -and $user_choice -eq 'rock') {
            Write-Host "You win!  I chose $compy_choice and you chose $user_choice." -ForegroundColor Green
            $user_game_wins += 1 
        }
        elseif ($compy_choice -eq 'scissors' -and $user_choice -eq 'spock' ) {
            Write-Host "You win!  I chose $compy_choice and you chose $user_choice." -ForegroundColor Green
            $user_game_wins += 1 
        }
        elseif ($compy_choice -eq 'scissors' -and $user_choice -eq 'paper') {
            Write-Host "I win!  I chose $compy_choice and you chose $user_choice." -ForegroundColor Red
            $compy_game_wins += 1
        }
        elseif ($compy_choice -eq 'scissors' -and $user_choice -eq 'lizard') {
            Write-Host "I win!  I chose $compy_choice and you chose $user_choice." -ForegroundColor Red
            $compy_game_wins += 1
        }
        elseif ($compy_choice -eq 'lizard' -and $user_choice -eq 'lizard') {
            Write-Host "It is a tie!  I chose $compy_choice and you chose $user_choice."
        }
        elseif ($compy_choice -eq 'lizard' -and $user_choice -eq 'rock') {
            Write-Host "You win! I chose $compy_choice and you chose $user_choice." -ForegroundColor Green
            $user_game_wins += 1 
        }
        elseif ($compy_choice -eq 'lizard' -and $user_choice -eq 'scissors') {
            Write-Host "You win! I chose $compy_choice and you chose $user_choice." -ForegroundColor Green
            $user_game_wins += 1 
        }
        elseif ($compy_choice -eq 'lizard' -and $user_choice -eq 'paper') {
            Write-Host "I win!  I chose $compy_choice and you chose $user_choice." -ForegroundColor Red
            $compy_game_wins += 1
        }
        elseif ($compy_choice -eq 'lizard' -and $user_choice -eq 'spock') {
            Write-Host "I win!  I chose $compy_choice and you chose $user_choice." -ForegroundColor Red
            $compy_game_wins += 1
        }
        elseif ($compy_choice -eq 'spock' -and $user_choice -eq 'spock') {
            Write-Host "It is a tie!  I chose $compy_choice and you chose $user_choice."
        }
        elseif ($compy_choice -eq 'spock' -and $user_choice -eq 'paper') {
            Write-Host "You win! I chose $compy_choice and you chose $user_choice." -ForegroundColor Green
            $user_game_wins += 1
        }
        elseif ($compy_choice -eq 'spock' -and $user_choice -eq 'lizard') {
            Write-Host "You win! I chose $compy_choice and you chose $user_choice." -ForegroundColor Green
            $user_game_wins += 1
        }
        elseif ($compy_choice -eq 'spock' -and $user_choice -eq 'rock') {
            Write-Host "I win!  I chose $compy_choice and you chose $user_choice." -ForegroundColor Red
            $compy_game_wins += 1
        }
        elseif ($compy_choice -eq 'spock' -and $user_choice -eq 'scissors') {
            Write-Host "I win!  I chose $compy_choice and you chose $user_choice." -ForegroundColor Red
            $compy_game_wins += 1
        }
        else {
            Write-Host "You lose. Your entry was $user_choice"
            $compy_game_wins += 1
        }
    
        $game_count += 1

        if ($game_count -lt 3) {
            Write-Host 'Again!' -ForegroundColor Blue
        }

    } while ( $game_count -lt 3 )

    Write-Host 'Lets see who won...' -ForegroundColor Blue
    Start-Sleep 2
    Write-Host "You won $user_game_wins times, and I won $compy_game_wins times" -ForegroundColor Blue
    Start-Sleep 1 
    if ($compy_game_wins -gt $user_game_wins) {
        Write-Host 'I win!' -ForegroundColor Red
        $compy_wins += 1
    }
    elseif ($user_game_wins -gt $compy_game_wins) {
        Write-Host 'You win!' -ForegroundColor Green
        $user_wins += 1
    }
    else {
        Write-Host 'We tied.'
    }


    Start-Sleep 1
    Write-Host "I have won $compy_wins games."-ForegroundColor Blue
    Start-Sleep 1
    Write-Host "You have won $user_wins games" -ForegroundColor Blue
    Start-Sleep 1                   
    Write-Host 'Would you like to play again?' -ForegroundColor Blue
    $play_again = Read-Host

    if ($play_again -eq 'y' -or $play_again -eq 'yes') {
        Write-Host "Let's play again!" -ForegroundColor Blue
        Start-Sleep 1
    }
    elseif ($play_again -eq 'n' -or $play_again -eq 'no') {

        $i = 1
        if ($compy_wins -gt $user_wins) {
            Write-Host 'I win!' -ForegroundColor Red
            Start-Sleep 1
            Write-Host 'Goodbye!' -ForegroundColor Blue
        }
        elseif ($compy_wins -eq $user_wins) {
            Write-Host 'We tied for wins'
            Start-Sleep 1
            Write-Host 'Goodbye!' -ForegroundColor Blue
        }
        else {
            Write-Host 'You win!' -ForegroundColor Green
            Start-Sleep 1
            Write-Host 'Goodbye!' -ForegroundColor Blue
        }
    }
    else {
        exit
    }

} while (
    $i -lt 1
)

