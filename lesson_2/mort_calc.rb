# Calculate the monthly mortgage payment based on loan amount, duration, and APR

require 'yaml'
MESSAGES = YAML.load_file('mort_messages.yml')

# Format and return messages to display on screen
def prompt(message)
  Kernel.puts("=> #{message}")
end

# Validate loan amount
def validate_amt(amt)
  amt.to_i.to_s == amt && amt.to_i > 0
end

# Validate APR
def validate_apr(apr)
  (apr.to_f.to_s == apr || apr.to_i.to_s == apr) && apr.to_f > 0
end

# Validate loan duration
def validate_duration(dur)
  (dur.to_f.to_s == dur || dur.to_i.to_s == dur) && dur.to_f > 0
end

# Calculate payment
def calculate_payment(amt, apr, dur)
  apr = apr.to_f / 100.0
  monthly_interest = apr / 12.0
  dur_months = dur.to_f * 12.0
  amt.to_i * (monthly_interest * (1 + monthly_interest)**dur_months) /
    ((1 + monthly_interest)**dur_months - 1)
end

# Greet user
prompt(MESSAGES['welcome'])

name = ''
loop do
  name = Kernel.gets().chomp()
  if name.empty?()
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

prompt("Hello, #{name}!")

# Begin calculation loop
loop do
  loan_amt = ''
  apr = ''
  duration = ''

  loop do
    prompt(MESSAGES['loan_amt'])
    loan_amt = Kernel.gets().chomp()
    if validate_amt(loan_amt)
      break
    else
      prompt(MESSAGES['invalid_num'])
    end
  end

  loop do
    prompt(MESSAGES['apr'])
    apr = Kernel.gets().chomp()
    if validate_apr(apr)
      break
    else
      prompt(MESSAGES['invalid_num'])
    end
  end

  loop do
    prompt(MESSAGES['loan_duration'])
    duration = Kernel.gets().chomp()
    if validate_duration(duration)
      break
    else
      prompt(MESSAGES['invalid_num'])
    end
  end

  payment = calculate_payment(loan_amt, apr, duration).round(2)

  prompt(MESSAGES['payment'] + payment.to_s)

  prompt(MESSAGES['continue'])
  continue = Kernel.gets().chomp()
  break unless continue.downcase().start_with?('y')
end

prompt(MESSAGES['goodbye'])
