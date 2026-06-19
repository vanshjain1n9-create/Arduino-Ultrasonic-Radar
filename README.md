# Arduino & Processing Ultrasonic Radar System

A hardware-software collaborative project that visualizes real-time environments using an Arduino Uno SMD (CH340), an HC-SR04 ultrasonic sensor, and an SG90 servo motor. The sensor acts as the "radar dish" swept back and forth by the servo, sending spatial data to a custom retro-green graphics interface rendered in Processing IDE.

---

## 🚀 Features
* **150° Scan Field:** Continuous sweeping coverage from 15° to 165° and back.
* **Real-Time Mapping:** Objects mapped instantly on a vector tracking grid.
* **Proximity Alert:** Detected obstacles appear dynamically as red target vectors based on proximity boundaries.
* **Dynamic Distance Tracker:** Live text feedback calculating object distance down to the exact centimeter.

---

## 🛠️ Hardware Requirements
* **Microcontroller:** Arduino Uno (SMD variant with CH340 USB-to-Serial chip)
* **Range Sensor:** HC-SR04 Ultrasonic Sensor
* **Actuator:** TowerPro SG90 Micro Servo
* **Prototyping:** Half-size Breadboard & Male-to-Male jumper wires
* **Power Supply:** Standard USB-A to USB-B cable

---

## 🔌 Circuit Topology (Pin Mapping)

The hardware pins must be mapped exactly as shown in the table below to match the core firmware architecture:

| Component | Component Pin | Arduino Uno Pin | Function / Description |
| :--- | :--- | :--- | :--- |
| **HC-SR04 Sensor** | VCC | 5V | Main 5V Power Rail |
| | Trig (Trigger) | Pin 10 | Output pulse trigger |
| | Echo | Pin 11 | Input pulse reflection return |
| | GND | GND | System Ground |
| **SG90 Servo** | Signal (Orange/Yellow) | Pin 9 | PWM Duty Cycle Control Signal |
| | VCC (Red) | 5V | Main 5V Power Rail |
| | GND (Brown/Black) | GND | System Ground |

> ⚠️ **Power Tip:** If the servo motor shudders, clicks, or causes the Arduino's onboard status LEDs to dim during operations, it indicates an over-current draw from the host machine's USB bus. If this occurs, isolate the servo's power network using a regulated external 5V power supply or a 4xAA battery pack, ensuring all ground nets are tied together to maintain a common system reference.

---

## 💻 Software & Integration Guide

### 1. Arduino Code Setup
1. Open the **Arduino IDE**.
2. Flash the target firmware (`.ino` file provided in this repository) to your Arduino Uno board.
3. Once the upload states `Done Uploading`, inspect the board to ensure the status LEDs are solid and stable.
4. **Crucial:** Note down the serial COM port designation (e.g., `COM3`, `COM5`, or `/dev/cu.usbserial...`) and close the Arduino IDE entirely. 

### 2. Processing Visualization Setup
1. Launch **Processing IDE**.
2. Open the visualizer code (`.pde` file provided in this repository).
3. Navigate to the `setup()` block near line 20 and look for the following line:
   ```java
   myPort = new Serial(this, "COM3", 9600);
