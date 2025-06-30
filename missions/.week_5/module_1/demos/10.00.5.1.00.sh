#!/bin/bash

echo "Demonstrate running a simple shell script."

echo "Creating a shell script to print 'Hello, Drone Technicians!'"
echo -e '#!/bin/bash\n\necho "Hello, Drone Technicians!"' > hello_drone_technicians.sh

echo "Making the script executable."
chmod +x hello_drone_technicians.sh

echo "Running the script."
./hello_drone_technicians.sh

exec bash --rcfile $RCFILE
