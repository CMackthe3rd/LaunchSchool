# rpsls
VALID_CHOICES = %w(rock paper scissors lizard spock)
FINAL_SCORE = 3

def prompt(message)
  Kernel.puts("=> #{message}")
end

def choice(input)
  case input
  when 'r' then 'rock'
  when 's' then 'scissors'
  when 'p' then 'paper'
  when 'l' then 'lizard'
  when 'k' then 'spock'
  end
end

def win?(first, second)
  (first == 'rock') && (second == 'scissors' || second == 'lizard') ||
    (first == 'paper') && (second == 'rock' || second == 'spock') ||
    (first == 'scissors') && (second == 'paper' || second == 'lizard') ||
    (first == 'lizard') && (second == 'spock' || second == 'paper') ||
    (first == 'spock') && (second == 'rock' || second == 'scissors')
end

def display_result(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

def keep_score(player, computer, tally)
  if win?(player, computer)
    tally[:user] += 1
  elsif win?(computer, player)
    tally[:pc] += 1
  else
    tally[:pc] += 0
    tally[:user] += 0
  end
end

def final_winner(tally)
  if tally[:user] == FINAL_SCORE
    prompt("You are victorious!")
  elsif tally[:pc] == FINAL_SCORE
    prompt("The Computer has defeated you...")
  end
end

rules_prompt = <<-MSG
The rules are simple:
  Scissors cut Paper.
  Paper covers Rock.
  Rock crushes Lizard.
  Lizard poisons Spock.
  Spock smashes Scissors.
  Scissors decapitate Lizard.
  Lizard eats Paper.
  Paper disproves Spock.
  Spock vaporizes Rock.
  And, as it has always done, Rock crushes Scissors.
MSG

choice_prompt = <<-MSG
Type the letter for your choice:
    R) Rock
    P) Paper
    S) Scissors
    L) Lizard
    K) Spock
MSG

prompt("Welcome to Rock, Paper, Scissors, Lizard, Spock!!")
puts "\n"
prompt(rules_prompt)
puts "\n"
prompt("First to three wins is the final victor!")
puts "\n"

tally = {
  user: 0,
  pc: 0
}

loop do
  pick = nil
  loop do
    prompt(choice_prompt)

    pick = Kernel.gets().chomp().downcase
    pick = choice(pick)

    if VALID_CHOICES.include?(pick)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{pick}.")
  prompt("The Computer chose: #{computer_choice}.")

  display_result(pick, computer_choice)
  keep_score(pick, computer_choice, tally)
  puts "\n"

  prompt("Your score is = #{tally[:user]}.")
  puts "\n"
  prompt("The Computer's score is = #{tally[:pc]}.")
  puts "\n"

  answer = ''

  final_winner(tally)

  if tally[:pc] == FINAL_SCORE || tally[:user] == FINAL_SCORE

    loop do
      puts "\n"
      prompt("Do you want to play again? ('Y' to continue - 'Q' to quit)")

      answer = Kernel.gets().chomp()
      if answer.downcase.start_with?('q')
        prompt("Thank you for playing!")
        prompt("Good-bye!")
        break
      elsif answer.downcase.start_with?('y')
        break
      else
        prompt("Invalid answer.")
      end
    end
    if answer.downcase.start_with?('q')
      break
    elsif answer.downcase.start_with?('y')
      system "clear"
      prompt("Next round begins!")
      puts "\n"
      tally = {
        user: 0,
        pc: 0
      }
    end
    break if answer.downcase.start_with?('q')
  end
end
