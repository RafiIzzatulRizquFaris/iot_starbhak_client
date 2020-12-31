class Device {
  final int id;
  final String title, description, image, state;

  Device({this.id, this.state, this.title, this.description, this.image});
}

// list of Devices
// for our demo
List<Device> devices = [
  Device(
    id: 1,
    state: "on",
    title: "Lamp",
    image: "assets/images/lamp.png",
    description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Device(
    id: 4,
    state: "off",
    title: "Water Springkler Garden",
    image: "assets/images/water.png",
    description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Device(
    id: 9,
    state: "lock",
    title: "Door",
    image: "assets/images/door.png",
    description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
];
