CHOICES = %w(rock paper scissors lizard spock)

VALID_CHOICES = { "r" => "rock", "p" => "paper", "s" => "scissors",
                  "l" => "lizard", "v" => "spock" }

WIN = [%w(rock scissors), %w(rock lizard), %w(paper rock), %w(paper spock),
       %w(scissors paper), %w(scissors lizard), %w(lizard spock),
       %w(lizard paper), %w(spock scissors), %w(spock rock)]

def prompt(message)
  Kernel.puts("=> #{message}")
end

def calculate_results(player, computer)
  if WIN.include?([player, computer])
    'player'
  elsif WIN.include?([computer, player])
    'computer'
  else
    'tie'
  end
end

choice_prompt = <<-MSG
  Choose one:
    'r' for rock
    'p' for paper
    's' for scissors
    'l' for lizard
    'v' for spock
  MSG

loop do
  player_count = 0
  computer_count = 0
  prompt("Get ready for a match of rock, paper, scissors, lizard, spock!")

  loop do
    choice = ''

    loop do
      prompt(choice_prompt)
      choice = Kernel.gets().chomp()

      if VALID_CHOICES.key?(choice)
        break
      else
        prompt("That's not a valid choice.")\
      end
    end

    choice = VALID_CHOICES.fetch(choice)

    computer_choice = CHOICES.sample

    prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

    who_won = calculate_results(choice, computer_choice)

    if who_won == 'player'
      prompt("You won!")
      player_count += 1
    elsif who_won == 'computer'
      prompt("Computer won!")
      computer_count += 1
    else
      prompt("It's a tie!")
    end

    prompt("The score is computer: #{computer_count}, you: #{player_count}")

    if player_count == 5
      prompt("You won the match!")
    elsif computer_count == 5
      prompt("The computer won the match!")
    end

    break unless player_count < 5 && computer_count < 5

    prompt("Do you want to keep playing? The first one to reach 5 points wins!")
    answer = Kernel.gets().chomp()
    break unless answer.downcase().start_with?('y')
  end

  prompt("Do you want to play another match?")
  match_answer = Kernel.gets().chomp()
  break unless match_answer.downcase().start_with?('y')
end

prompt("Thank you for playing. Good bye!")
