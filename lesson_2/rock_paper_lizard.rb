CHOICES = %w(rock paper scissors lizard spock)

VALID_CHOICES = { "r" => "rock", "p" => "paper", "s" => "scissors",
                  "l" => "lizard", "v" => "spock" }

WIN = [%w(rock scissors), %w(rock lizard), %w(paper rock), %w(paper spock),
       %w(scissors paper), %w(scissors lizard), %w(lizard, spock),
       %w(lizard paper), %w(spock scissors), %w(spock rock)]

def prompt(message)
  Kernel.puts("=> #{message}")
end

def display_results(player, computer)
  if WIN.include?([player, computer])
    prompt("You won!")
  elsif WIN.include?([computer, player])
    prompt("Computer won!")
  else
    prompt("It's a tie!")
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

  display_results(choice, computer_choice)

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for playing. Good bye!")
