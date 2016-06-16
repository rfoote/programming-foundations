# Ask the user for two numbers
# Ask the user for an operation to perform
# Perform the operation on the two numbers
# Output the result

require 'yaml'
MESSAGES = YAML.load_file('calc_messages.yml')

def prompt(message)
  Kernel.puts("=> #{message}")
end

# def valid_number?(num)
#   is_valid = ''
#   if num == '0'|| (num.to_i > 0 || num.to_i < 0)
#     is_valid = true
#   else
#     is_valid = false
#   end
#   return is_valid
# end

def number?(num)
  if num.to_i.to_s == num || num.to_f.to_s == num
    true
  else
    false
  end
end

def operation_to_message(op)
  word = case op
         when '1'
           'Adding'
         when '2'
           'Subtracting'
         when '3'
           'Multiplying'
         when '4'
           'Dividing'
         end
  return word
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = Kernel.gets().chomp()
  if name.empty?()
    prompt("Make sure to use a valid name.")
  else
    break
  end
end

prompt("Hi #{name}!")

loop do # main loop
  number1 = ''
  loop do
    prompt(MESSAGES['first_num'])
    number1 = Kernel.gets().chomp()
    if number?(number1)
      break
    else
      prompt(MESSAGES['invalid_num'])
    end
  end

  number2 = ''
  loop do
    prompt(MESSAGES['sec_num'])
    number2 = Kernel.gets().chomp()
    if number?(number2)
      break
    else
      prompt(MESSAGES['invalid_num'])
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG
  prompt(operator_prompt)

  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt("Must choose 1, 2, 3, or 4")
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  result = case operator
           when '1'
             number1.to_i() + number2.to_i()
           when '2'
             number1.to_i() - number2.to_i()
           when '3'
             number1.to_i() * number2.to_i()
           when '4'
             number1.to_f() / number2.to_f()
           end

  prompt("The result is #{result}")

  prompt("Do you want to perform another calculation? (Y to calculate again)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for using the calculator. Good bye!")
