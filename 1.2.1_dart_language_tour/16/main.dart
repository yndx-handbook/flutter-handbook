int counter = 1;

typedef RobotBuilder = String Function(String name);

RobotBuilder robotFactory(String specifications) {
  final model = 'Death bot Pluto-$counter';
  counter++;
  return (String name) => '$model, $name, $specifications';
}

void main() {
  final firstRobot = robotFactory('Love cookies!');
  final secondRobot = robotFactory('Love Katya!');
  final thirdrobot = robotFactory('Love bloody pirogi!');

  print(firstRobot('HRAZ'));
  print(secondRobot.call('Sechenov'));
  print(thirdrobot('Nechyaev'));
}
