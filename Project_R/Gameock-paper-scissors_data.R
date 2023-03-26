play_game <- function () {
  print ("Let's play")
# score variable
win   <- 0
lose  <- 0
tie <- 0
  
  
  while (TRUE) {
  options <- c("hammer", "scissor", "paper")
  print("Choose : hammer , scissor , paper")
  print("exit")
  
  user_select <- readline("Choose : ")
  computer_select <- sample(options, 1)
  
  if (user_select == computer_select) {
    print("tie!")
    tie <- tie+1
    
  } else if (user_select == "hammer"& computer_select == "scissor"){
    print("You win!")
    win <- win+1
  } else if (user_select == "scissor"& computer_select == "paper"){
    print("You win!")
    win <- win+1
  } else if (user_select == "paper"& computer_select == "hammer"){
    print("You win!")
    win <- win+1
  } else if (user_select == "hammer"& computer_select == "paper"){
    print("You lose!")
    lose <- lose+1
  } else if (user_select == "scissor"& computer_select == "hammer"){
    print("lose!")
    lose <- lose+1
  } else if (user_select == "paper"& computer_select == "scissor"){
    print("lose!")
    lose <- lose+1
  } else if (user_select == "exit"){
    total <- win+lose+tie
    print(paste("Total Games : ", total))
    print(paste("Win   : ", win))
    print(paste("Lose  : ", lose))
    print(paste("Tie   : ", tie))
    print("Thank for playing!")
    break
  } else {
    print("Try again?")
  }}}
  
play_game()
