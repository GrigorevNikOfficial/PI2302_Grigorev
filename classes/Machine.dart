class Machine {
  
  int _coffeeBeans;
  int _milk;
  int _water;
  int _cash;

  Machine(this._coffeeBeans, this._milk, this._water, this._cash);

  int get coffeeBeans {return _coffeeBeans;}
  set coffeeBeans(int value) {
    _coffeeBeans = value;
  }

  int get milk {return _milk;}
  set milk(int value) {
    _milk = value;
  }

  int get water {return _water;}
  set water (int value) {
    _water = value;
  }

  int get cash {return _cash;}
  set cash (int value) {
    _cash = value;
  }

}