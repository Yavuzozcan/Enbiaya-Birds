class BirdModel {
  double y;

  BirdModel({
    this.y = 0,
  });

  void jump() {
    y -= 0.25;
  }

  void fall() {
    y += 0.05;
  }

  void reset() {
    y = 0;
  }
}
