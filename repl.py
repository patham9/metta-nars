#Author: Douglas Miles
from hyperon.runner import MeTTa
import sys
import readline
import os

runner = MeTTa()
class REPL:
    def __init__(self):
        self.history = []

    def main_loop(self):
        while True:
            try:
                # Use the input function to get user input                
                line = input("metta> ")
                # If the line isn't empty, evaluate it
                if line:
                    self.history.append(line)
                    result = runner.run(line)
                    if result is not None:
                        print(result)
            # Handle Ctrl+C to exit
            except KeyboardInterrupt:
                print("\nCtrl-C Exiting...")
                sys.exit(3)
            # Handle Ctrl+D to exit
            except EOFError:
                print("\n Ctrl-D EOF...")
                sys.exit(0)
            # If there's an error, print it
            except Exception as e:
                print(f"Error: {e}")

if __name__ == "__main__":
    repl = REPL()
    readline.add_history("!(AddBeliefEvent ((({ garfield }) --> cat) (1.0 0.9)))")
    readline.add_history("!(AddBeliefEvent (((cat * sky) --> like) (1.0 0.9)))")
    readline.add_history("!(AddBeliefEvent ((sky --> ([ blue ])) (1.0 0.9)))")
    readline.add_history("!(EternalQuestion ((({ garfield }) * ([ blue ])) --> like))")
    os.chdir("./src/")
    os.system("sh build.sh")
    with open("NARS.metta") as f:
        runner.run(f.read())
    repl.main_loop()

