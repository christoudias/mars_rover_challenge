# README
 This challenge is a solution to the problem found at https://code.google.com/archive/p/marsrovertechchallenge/ and presented to Weddington Way. This challenge takes an input as a transmission that is then sent to rovers on Mars. The application then processes the transmission as instructions to the rover. The rover will then return it's final position and orientation as an output.

### Installation
    I built this as a simple rails application. To install this application:
     1. Download this repo as a zip and unzip it
     2. Open terminal and browse to the folder where you unzipped it.
     3. At the root directory, run "bundle install"
     4. Start the server by running "rails server"
     5. Navigate your browser to http://localhost:3000


### Overview
  The module and classes used for this solution can be found in /lib/mars folder. The main classes are the Communication class which parses and validates the transmission and the Rover class which accepts a transmission and returns it's final position and bearing.

### Thoughts

1. *Boundaries* - Something that was not clearly defined in the challenge was what a rover would do when it was instructed to go over a boundary. It could have either aborted the entire transmission, gone over the edge, or ignored commands that sent it over the edge. I chose to simply continue with the rest of the transmission and ignore commands that would have destroyed the rover.

2. *Transmission Errors* - If there are 5 transmissions and one of them is invalid, it was assumed that the entire transmission is invalid. The other option is that the other 4 transmissions could have been sent to their respective rovers, but it was assumed that an error on one line could have meant lines were in the wrong place.

3. *Test Cases* - I have embedded test cases as a listing on the root of http://localhost:3000 that can be run along with their expected outputs.



