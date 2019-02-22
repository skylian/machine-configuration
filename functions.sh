# Define a timestamp function                                                    
timestamp() {                                                                    
  date +"%Y-%m-%d_%H-%M-%S"                                                      
}                                                                                

backup_file() {
  fn=$1
  if [ -f $fn ]; then
    cp $fn $fn.$(timestamp)
  fi
}


