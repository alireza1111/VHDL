# VHDL
VHDL project:
The project setup uses two sensors which are connected to FPGA board. D is the maximum distance that can be read by the sensors which 
is equal to 400 cm according to datasheet. "d" is the distance of the object from the midpoint of the sensors and B is the baseline 
separation between sensors.
#Overall aim
The aim of the project is to design a setup which runs with FPGA Nexys2 board that can measure the distance of the object using two
range sensors. The values measured by the sensors should be converted to cm using some calculations available on SRF05 datasheet. Each range sensor value is of two bytes (16 bits) which is sent to PC running Matlab. The communication between the FPGA board and PC is carried out through RS232 cable (UART communication). PC again sends 4 bytes of data back to FPGA board. First two bytes represent the distance from the midpoint between two sensors and the last two bytes repre-sent the angle of the object from the midpoint between two sensors. Both the range sensor readings and the data received from the PC should be displayed on 7-segment. A character should be displayed which represents the property followed by three digit value of the property.
