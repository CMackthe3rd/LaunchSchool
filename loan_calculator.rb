# Loan calculator

def prompt(message)
  Kernel.puts("=> #{message}")
end

def integer?(num)
  num.to_i.to_s() == num
end

def float?(input)
  input.to_f.to_s == input
end

def number?(input)
  integer?(input) || float?(input)
end

def months_length(input)
  input.to_f * 12
end

def monthly_interest(input)
  input.to_f / 12
end

prompt("Welcome to Loan Calculator!")

prompt("Please enter your name:")
name = ''
loop do
  name = Kernel.gets().chomp()
  break unless name.empty?()
  prompt("Make sure to use a valid name.")
end

prompt("Hello #{name}!")

loop do # main loop
  loan_amount = nil

  loop do
    prompt("Please provide the loan amount:")
    loan_amount = Kernel.gets().chomp()

    if number?(loan_amount)
      loan_amount = loan_amount.to_f
      break
    else
      prompt("Please enter a valid input.")
    end
  end

  loan_duration = nil

  loop do
    prompt("Please provide the loan duration in years:")
    loan_duration = Kernel.gets().chomp()

    if number?(loan_duration)
      loan_duration = loan_duration.to_f
      loan_duration = loan_duration.round(4)
      break
    else
      prompt("Please enter a valid input.")
    end
  end

  apr = nil
  loop do
    prompt("Please provide the APR:")
    apr = Kernel.gets().chomp()

    if number?(apr)
      apr = apr.to_f / 100
      apr = apr.round(4)
      break
    else
      prompt("Please enter a valid APR.")
    end
    break
  end

  monthly = loan_amount * monthly_interest(apr) / (1 - (1 + monthly_interest(apr))**(-months_length(loan_duration)))
  monthly = monthly.round(4)

  prompt("Please wait while we process your queary...")

  prompt("Your monthly interest rate is #{apr}.")
  prompt("the monthly payment is #{monthly}.")
  prompt("The payments will end in #{months_length(loan_duration)} months.")

  prompt("Would you like to calculate a new loan? ('Y' to continue):")
  answer = Kernel.gets().chomp().downcase

  break unless answer == 'y'
end

prompt("Thank you for using our services!")
prompt("Have a wonderful day!")
